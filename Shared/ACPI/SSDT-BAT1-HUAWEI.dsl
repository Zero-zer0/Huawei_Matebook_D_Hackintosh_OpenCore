// battery hotpatch for 
// Huawei Matebook D 2018 Intel Edition by iStarForever: https://github.com/XStar-Dev
//
// In config ACPI, UPBX,0,N renamed XPBX 
// Find:     55 50 42 58 00
// Replace:  58 50 42 58 00
//
// In config ACPI, UPBI,0,N renamed XPBI
// Find:     55 50 42 49 00
// Replace:  58 50 42 49 00
//
// In config ACPI, UPBS,0,N renamed XPBS
// Find:     55 50 42 53 00
// Replace:  58 50 42 53 00
//
// In config ACPI, _STA renamed XSTA in BAT1
// Find:     5F 53 54 41 00 A4 42 41 54 50
// Replace:  58 53 54 41 00 A4 42 41 54 50
//
DefinitionBlock ("", "SSDT", 2, "ACDT", "BAT1", 0x00000000)
{
    External (_SB_.ACAD, DeviceObj)
    External (_SB_.ACAD._PSR, MethodObj)    // 0 Arguments
    External (_SB_.BAT1, DeviceObj)
    External (_SB_.BAT1.BATP, IntObj)
    External (_SB_.BAT1.PBFE, MethodObj)    // 3 Arguments
    External (_SB_.BAT1.PBIF, PkgObj)
    External (_SB_.BAT1.PBIX, PkgObj)
    External (_SB_.BAT1.PBST, PkgObj)
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.BATH, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BATL, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.BNBC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0_.CHEM, FieldUnitObj)
    External (BATP, IntObj)

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }

    Scope (_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (ERAX, SystemMemory, 0xFE708300, 0x0100)
        Field (ERAX, ByteAcc, Lock, Preserve)
        {
            Offset (0x64), 
            BTV0,   8, 
            BTV1,   8, 
            BTI0,   8, 
            BTI1,   8, 
            Offset (0x6A), 
            BTC0,   8, 
            BTC1,   8, 
            BTF0,   8, 
            BTF1,   8, 
            Offset (0x76), 
            BTA0,   8, 
            BTA1,   8, 
            BTD0,   8, 
            BTD1,   8, 
            TCC0,   8, 
            TCC1,   8
        }

        Method (RE1B, 1, NotSerialized)
        {
            Local0 = (0xFE708300 + Arg0)
            OperationRegion (ERM2, SystemMemory, Local0, One)
            Field (ERM2, ByteAcc, NoLock, Preserve)
            {
                BYTE,   8
            }

            Return (BYTE) /* \_SB_.PCI0.LPCB.EC0_.RE1B.BYTE */
        }

        Method (RECB, 2, Serialized)
        {
            Arg1 = ((Arg1 + 0x07) >> 0x03)
            Name (TEMP, Buffer (Arg1){})
            Arg1 += Arg0
            Local0 = Zero
            While ((Arg0 < Arg1))
            {
                TEMP [Local0] = RE1B (Arg0)
                Arg0++
                Local0++
            }

            Return (TEMP) /* \_SB_.PCI0.LPCB.EC0_.RECB.TEMP */
        }
    }

    Scope (_SB.BAT1)
    {
        Method (UPBX, 0, NotSerialized)
        {
            If (((^^PCI0.LPCB.EC0.BATL & One) == Zero))
            {
                Return (0xFF)
            }

            PBIX [0x02] = B1B2 (^^PCI0.LPCB.EC0.BTA0, ^^PCI0.LPCB.EC0.BTA1)
            Name (FDDC, Zero)
            FDDC = ((B1B2 (^^PCI0.LPCB.EC0.BTA0, ^^PCI0.LPCB.EC0.BTA1) / 0x0A) * 0x0B)
            If ((B1B2 (^^PCI0.LPCB.EC0.BTF0, ^^PCI0.LPCB.EC0.BTF1) >= FDDC))
            {
                PBIX [0x03] = FDDC /* \_SB_.BAT1.UPBX.FDDC */
            }
            Else
            {
                PBIX [0x03] = B1B2 (^^PCI0.LPCB.EC0.BTF0, ^^PCI0.LPCB.EC0.BTF1)
            }

            PBIX [0x05] = B1B2 (^^PCI0.LPCB.EC0.BTD0, ^^PCI0.LPCB.EC0.BTD1)
            PBIX [0x08] = B1B2 (^^PCI0.LPCB.EC0.TCC0, ^^PCI0.LPCB.EC0.TCC1)
            Local0 = ^^PCI0.LPCB.EC0.RECB (0xD0, 0x78)
            PBFE (Local0, ^^PCI0.LPCB.EC0.BNBC, Zero)
            PBIX [0x10] = Local0
            If (^^PCI0.LPCB.EC0.CHEM)
            {
                PBIX [0x12] = "NiMH"
            }
            Else
            {
                PBIX [0x12] = "LIon"
            }

            Return (Zero)
        }

        Method (UPBI, 0, NotSerialized)
        {
            If (((^^PCI0.LPCB.EC0.BATL & One) == Zero))
            {
                Return (0xFF)
            }

            PBIF [One] = B1B2 (^^PCI0.LPCB.EC0.BTA0, ^^PCI0.LPCB.EC0.BTA1)
            PBIF [0x02] = B1B2 (^^PCI0.LPCB.EC0.BTF0, ^^PCI0.LPCB.EC0.BTF1)
            PBIF [0x04] = B1B2 (^^PCI0.LPCB.EC0.BTD0, ^^PCI0.LPCB.EC0.BTD1)
            Local0 = ^^PCI0.LPCB.EC0.RECB (0xD0, 0x78)
            PBFE (Local0, ^^PCI0.LPCB.EC0.BNBC, Zero)
            PBIF [0x09] = Local0
            If (^^PCI0.LPCB.EC0.CHEM)
            {
                PBIF [0x0B] = "NiMH"
            }
            Else
            {
                PBIF [0x0B] = "LIon"
            }

            Return (Zero)
        }

        Method (UPBS, 0, NotSerialized)
        {
            If (((^^PCI0.LPCB.EC0.BATL & One) == Zero))
            {
                Return (0xFF)
            }

            Local0 = Zero
            If (((^^PCI0.LPCB.EC0.BATH & 0x0F) == One))
            {
                Local0 |= One
            }
            ElseIf ((^^PCI0.LPCB.EC0.BATH & 0x0C))
            {
                Local0 |= 0x02
            }

            PBST [Zero] = Local0
            Local1 = B1B2 (^^PCI0.LPCB.EC0.BTI0, ^^PCI0.LPCB.EC0.BTI1)
            If ((Local1 & 0x8000))
            {
                Local1 |= 0xFFFF0000
                Local1 = ((0xFFFFFFFF - Local1) + One)
            }

            PBST [One] = Local1
            PBST [0x02] = B1B2 (^^PCI0.LPCB.EC0.BTC0, ^^PCI0.LPCB.EC0.BTC1)
            PBST [0x03] = B1B2 (^^PCI0.LPCB.EC0.BTV0, ^^PCI0.LPCB.EC0.BTV1)
            Return (Zero)
        }

        Method (_STA, 0, Serialized)  // _STA: Status
        {
            Name (OACS, Ones)
            Local0 = \_SB.ACAD._PSR ()
            If ((OACS != Local0))
            {
                OACS = Local0
                Notify (\_SB.ACAD, 0x80) // Status Change
            }

            Return (BATP) /* External reference */
        }
    }
}

