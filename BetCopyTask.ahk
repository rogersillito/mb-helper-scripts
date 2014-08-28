class BetCopyTask
{
    __New(clipboardTask, oMRowParser)
    {
        this.OMRowParser := oMRowParser
        this.ClipboardTask := clipboardTask
    }

    ; matchType = Qualifier, Arb, Free SNR, Free SR
    ; betType   = Single, Multiple
    CopyFromOm(matchType, betType)
    {
        clipContents := this.ClipboardTask.TryCopyGetClipboardContents()
        this.OMRowParser.Parse(clipContents)
    }
}
