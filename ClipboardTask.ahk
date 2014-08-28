class ClipboardTask
{
    TryCopyGetClipboardContents()
    {
        SetKeyDelay, 100
        clipboardWait_s := 5
        ClipSaved := ClipboardAll
        clipboard = ; Empty
        Send, ^c
        ClipWait, %clipboardWait_s%
        if ErrorLevel
        {
            MsgBox, Aborting: could not get clipboard contents after %clipboardWait_s% seconds.
            return
        }
        outval := clipboard
        clipboard := ClipSaved
        ClipSaved = ; Clear
        return outval
    }
}
