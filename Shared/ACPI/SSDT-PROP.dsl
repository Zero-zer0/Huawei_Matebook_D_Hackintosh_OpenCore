// All in one fake device injection inspired by XStar-Dev:  https://github.com/XStar-Dev
// Credit to OC-Little, Acidanthera, RehabMan

DefinitionBlock ("", "SSDT", 2, "ACDT", "PROP", 0x00000000)
{
    External (_PR_.CPPC, FieldUnitObj)
    External (_PR_.PR00, ProcessorObj)
    External (_SB_.PCI0.RP01._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX._DSM, MethodObj)    // 4 Arguments
    External (_SB_.PCI0.RP01.PXSX._PS3, MethodObj)    // 0 Arguments

    If (_OSI ("Darwin"))
    {
        Method (DTGP, 5, NotSerialized)
        {
            If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
            {
                If ((Arg1 == One))
                {
                    If ((Arg2 == Zero))
                    {
                        Arg4 = Buffer (One)
                            {
                                 0x03                                             // .
                            }
                        Return (One)
                    }

                    If ((Arg2 == One))
                    {
                        Return (One)
                    }
                }
            }

            Arg4 = Buffer (One)
                {
                     0x00                                             // .
                }
            Return (Zero)
        }

        Scope (_SB)
        {
            Device (ALS0)
            {
                Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
                Name (_CID, "smc-als")  // _CID: Compatible ID
                Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
                Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
                {
                    Package (0x02)
                    {
                        0x64, 
                        0x012C
                    }
                })
            }

            Device (DGPU)
            {
                Name (_HID, "DGPU1000")  // _HID: Hardware ID
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    If (CondRefOf (\_SB.PCI0.RP01.PXSX._PS3))
                    {
                        \_SB.PCI0.RP01.PXSX._DSM (ToUUID ("a486d8f8-0bda-471b-a72b-6042a6b5bee0"), 0x0100, 0x1A, Buffer (0x04)
                            {
                                 0x01, 0x00, 0x00, 0x03                           // ....
                            })
                        \_SB.PCI0.RP01.PXSX._PS3 ()
                    }

                    If (CondRefOf (\_SB.PCI0.RP01._OFF))
                    {
                        \_SB.PCI0.RP01._OFF ()
                    }
                }
            }

            Device (PNLF)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                Name (_CID, "backlight")  // _CID: Compatible ID
                Name (_UID, 0x10)  // _UID: Unique ID
            }

            Device (RMNE)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "NULE0000")  // _HID: Hardware ID
                Name (MAC, Buffer (0x06)
                {
                     0x11, 0x22, 0x33, 0x44, 0x55, 0x66               // ."3DUf
                })
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x0A)
                    {
                        "built-in", 
                        Buffer (One)
                        {
                             0x00                                             // .
                        }, 

                        "IOName", 
                        "ethernet", 
                        "name", 
                        Buffer (0x09)
                        {
                            "ethernet"
                        }, 

                        "model", 
                        Buffer (0x15)
                        {
                            "RM-NullEthernet-1001"
                        }, 

                        "device_type", 
                        Buffer (0x09)
                        {
                            "ethernet"
                        }
                    })
                }
            }
        }

        Scope (_PR.PR00)
        {
            Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
            {
                Return (\_PR.CPPC) /* External reference */
            }

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                Local0 = Package (0x02)
                    {
                        "plugin-type", 
                        One
                    }
                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                Return (Local0)
            }
        }
    }
}

