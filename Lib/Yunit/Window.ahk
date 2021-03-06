class YunitWindow
{
    __new(instance)
    {
        global YunitWindowTitle, YunitWindowEntries
        Gui, Yunit:Font, s16, Arial
        Gui, Yunit:Add, Text, x0 y0 h30 vYunitWindowTitle Center, Test Results
        
        hImageList := IL_Create()
        IL_Add(hImageList,"shell32.dll",78) ;yellow triangle with exclamation mark
        IL_Add(hImageList,"shell32.dll",138) ;green circle with arrow facing right
        IL_Add(hImageList,"shell32.dll",135) ;two sheets of paper
        this.icons := {fail: "Icon1", pass: "Icon2", detail: "Icon3"}
        
        Gui, Yunit:Font, s10
        Gui, Yunit:Add, TreeView, x10 y30 vYunitWindowEntries ImageList%hImageList%
        
        Gui, Yunit:Font, s8
        Gui, Yunit:Add, StatusBar
        Gui, Yunit:+Resize +MinSize320x200
        Gui, Yunit:Show, w500 h400, Yunit Testing
        Gui, Yunit:+LastFound
        
        this.Categories := {}
        Return this
        
        YunitGuiSize:
        GuiControl, Yunit:Move, YunitWindowTitle, w%A_GuiWidth%
        GuiControl, Yunit:Move, YunitWindowEntries, % "w" . (A_GuiWidth - 20) . " h" . (A_GuiHeight - 60)
        Gui, Yunit:+LastFound
        WinSet, Redraw
        Return
        
        YunitGuiClose:
        ExitApp
    }
    
    Update(Category, TestName, Result)
    {
        Gui, Yunit:Default
        If !this.Categories.HasKey(Category)
            this.AddCategories(Category)
        Parent := this.Categories[Category]
        If IsObject(result)
        {
            hChildNode := TV_Add(TestName,Parent,this.icons.fail)
            TV_Add("Line #" result.line ": " result.message,hChildNode,this.icons.detail)
            key := category
            pos := 1
            while (pos)
            {
                TV_Modify(this.Categories[key], this.icons.fail)
                pos := InStr(key, ".", false, 0, 1)
                key := SubStr(key, 1, pos-1)
            }
        }
        Else
            TV_Add(TestName,Parent,this.icons.pass)
        TV_Modify(Parent, "Expand")
    }
    
    AddCategories(Categories)
    {
        Parent := 0
        Category := ""
        Loop, Parse, Categories, .
        {
            Category .= (Category == "" ? "" : ".") A_LoopField
            If (!this.Categories.HasKey(Category))
                this.Categories[Category] := TV_Add(A_LoopField, Parent, this.icons.pass)
            Parent := this.Categories[Category]
        }
    }
}