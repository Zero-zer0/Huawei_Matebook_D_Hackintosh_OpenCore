DefinitionBlock ("", "SSDT", 2, "OCLT", "PTSWAK", 0x00000000)
{
    External (_SB_.PCI0.RP01._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01._ON_, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX._ON_, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX._PS0, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX._PS3, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX.HGOF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP01.PXSX.HGON, MethodObj)    // 0 Arguments
    External (ZPTS, MethodObj)    // 1 Arguments
    External (ZWAK, MethodObj)    // 1 Arguments

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (\_SB.PCI0.RP01._ON))
            {
                \_SB.PCI0.RP01._ON ()
            }

            If (CondRefOf (\_SB.PCI0.RP01.PXSX._PS0))
            {
                \_SB.PCI0.RP01.PXSX._PS0 ()
            }

            If (CondRefOf (\_SB.PCI0.RP01.PXSX._ON))
            {
                \_SB.PCI0.RP01.PXSX._ON ()
            }

            If (CondRefOf (\_SB.PCI0.RP01.PXSX.HGON))
            {
                \_SB.PCI0.RP01.PXSX.HGON ()
            }
        }

        ZPTS (Arg0)
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (\_SB.PCI0.RP01.PXSX._PS3))
            {
                \_SB.PCI0.RP01.PXSX._PS3 ()
            }

            If (CondRefOf (\_SB.PCI0.RP01.PXSX._OFF))
            {
                \_SB.PCI0.RP01.PXSX._OFF ()
            }

            If (CondRefOf (\_SB.PCI0.RP01.PXSX.HGOF))
            {
                \_SB.PCI0.RP01.PXSX.HGOF ()
            }

            If (CondRefOf (\_SB.PCI0.RP01._OFF))
            {
                \_SB.PCI0.RP01._OFF ()
            }
        }

        Local0 = ZWAK (Arg0)
        Return (Local0)
    }
}

