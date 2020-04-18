DefinitionBlock ("", "SSDT", 2, "ACDT", "BrightFN", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC0_, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.XQF1, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.EC0_.XQF2, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_QF1, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x20) // Reserved
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQF1 ()
            }
        }

        Method (_QF2, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x10) // Reserved
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQF2 ()
            }
        }
    }
}

