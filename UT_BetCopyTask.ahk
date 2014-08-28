#Include <Yunit\Yunit>
#Include <Yunit\Window>

#Include BetCopyTask.ahk

class BetCopyTaskTests
{
    class When_CopyFromOm_is_called
    {
        Begin()
        {
            this.ClipboardTask := new FakeClipboardTask()
            this.OMRowParser := new FakeOMRowParser()
            this.SUT := new BetCopyTask(this.ClipboardTask, this.OMRowParser)
            this.Result := this.SUT.CopyFromOm("Qualifier", "Single")
        }

        End()
        {
            this.remove("SUT")
            this.remove("ClipboardTask")
            this.remove("OMRowParser")
        }

        It_should_copy_selection_and_get_clipboard()
        {
            Yunit.assert(this.ClipboardTask.CallCount == 1, "TryCopyGetClipboardContents() call count = " . this.ClipboardTask.CallCount)
        }

        It_should_pass_clipboard_contents_to_the_om_row_parser()
        {
            Yunit.assert(this.OMRowParser.CallCount == 1, "Parse() call count = " . this.OMRowParser.CallCount)
            Yunit.assert(this.OMRowParser.RowParam == "CLIP_CONTENTS", "Parse() was called with '" . this.OMRowParser.RowParam . "'")
        }
    }   
}

class FakeClipboardTask
{
    CallCount := 0        

    TryCopyGetClipboardContents()
    {
        this.CallCount += 1
        return "CLIP_CONTENTS"
    }
}

class FakeOMRowParser
{
    CallCount := 0        
    RowParam := ""
    Parsed := false

    Parse(row)
    {
        this.RowParam := row
        this.CallCount += 1
        ;TODO: either set values or set error based on Parsed
    }
}
