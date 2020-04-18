// Credit to hjmmc: https://github.com/hjmmc

DefinitionBlock ("", "SSDT", 2, "hack", "_LID", 0x00000000)
{
    External (_SB_.LID0, DeviceObj)
    External (_SB_.LID0.LDRT, IntObj)
    External (_SB_.LID0.XLID, MethodObj)    // 0 Arguments
    External (ECOK, IntObj)
    External (LIDS, UnknownObj)
    External (UPDL, MethodObj)    // 0 Arguments
    External (XLID, MethodObj)    // 0 Arguments

    Method (_SB.LID0._LID, 0, NotSerialized)  // _LID: Lid Status
    {
        If (_OSI ("Darwin"))
        {
            If (ECOK)
            {
                UPDL ()
                \_SB.LID0.LDRT = Zero
            }

            UPDL ()
            Return (LIDS) /* External reference */
        }
        Else
        {
            Return (XLID ())
        }
    }
}

