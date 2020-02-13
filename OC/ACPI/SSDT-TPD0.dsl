/*
Necessary Hotpatch for trackpad GPIO Interrupt mode for Huawei Matebook D 2018 by Zero-zer0
With this patch, the dirty SSDT-XOSI is no longer needed.
2 Patches in DSDT is needed, please pair this with "skip" and "count" function of OpenCore
1. _CRS --> XCRS  TgtBridge: TPD0
2. _INI --> XINI  TgtBridge: TPD0
Don't remember to make changes in Config.plist
*/
DefinitionBlock ("", "SSDT", 2, "hack", "TPD0", 0x00000000)
{
    External (_SB_.GNUM, MethodObj)    // 1 Arguments
    External (_SB_.INUM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.HIDG, IntObj)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0._HID, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.BADR, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.HID2, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.INT1, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.INT2, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFB, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFI, UnknownObj)
    External (_SB_.PCI0.I2C0.TPD0.SPED, UnknownObj)
    External (_SB_.PCI0.TP7G, IntObj)
    External (_SB_.SHPO, MethodObj)    // 2 Arguments
    External (_SB_.SRXO, MethodObj)    // 2 Arguments
    External (BADR, IntObj)
    External (GPDI, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (SBFI, IntObj)
    External (SDM0, FieldUnitObj)
    External (SDS0, FieldUnitObj)
    External (SPED, IntObj)
    External (TPDB, FieldUnitObj)
    External (TPDH, FieldUnitObj)
    External (TPDS, FieldUnitObj)

    Scope (_SB.PCI0.I2C0.TPD0)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin")){}
            ElseIf ((OSYS < 0x07DC))
            {
                SRXO (GPDI, One)
            }

            INT1 = GNUM (GPDI)
            INT2 = INUM (GPDI)
            If ((SDM0 == Zero))
            {
                SHPO (GPDI, One)
            }

            If ((SDS0 == One))
            {
                _HID = "SYNA2393"
                HID2 = 0x20
                Return (Zero)
            }

            If ((SDS0 == 0x02))
            {
                _HID = "06CB2846"
                HID2 = 0x20
                Return (Zero)
            }

            If ((SDS0 == 0x06))
            {
                _HID = "ALPS0000"
                HID2 = 0x20
                BADR = 0x2C
                Return (Zero)
            }

            If ((SDS0 == 0x05))
            {
                _HID = "ELAN2202"
                HID2 = TPDH /* External reference */
                BADR = TPDB /* External reference */
                If ((TPDS == Zero))
                {
                    SPED = 0x000186A0
                }

                If ((TPDS == One))
                {
                    SPED = 0x00061A80
                }

                If ((TPDS == 0x02))
                {
                    SPED = 0x000F4240
                }

                Return (Zero)
            }
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin"))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }

            If ((OSYS < 0x07DC))
            {
                Return (SBFI) /* External reference */
            }

            If ((SDM0 == Zero))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }

            Return (ConcatenateResTemplate (SBFB, SBFI))
        }
    }
}

