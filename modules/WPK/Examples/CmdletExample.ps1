New-Grid -Columns 2 -Rows 5 {
    $script:Action = {
        $noun = $this.Parent | 
            Get-ChildControl Noun |
            Select-Object -ExpandProperty Text 
        $verb = $this.Parent | 
            Get-ChildControl Verb |
            Select-Object -ExpandProperty Text
        $name = $this.Parent | 
            Get-ChildControl Name |
            Select-Object -ExpandProperty Text
        $module = $this.Parent | 
            Get-ChildControl Module |
            Select-Object -ExpandProperty Text
        if ($noun -or $verb) {
            Get-Command -Noun "$noun" -Verb "$verb" -ErrorAction SilentlyContinue  | Select Name, CommandType, Module  | Out-GridView
            return
        }
        if ($name) {
            Get-Command -Name "$name" -ErrorAction SilentlyContinue | Select Name, CommandType, Module  | Out-GridView
            return
        }
        
        if ($module) {
            Get-Command -Name "$name" -Module "$module" -ErrorAction SilentlyContinue | Select Name, CommandType, Module  | Out-GridView
            return
        }
        
        Get-Command -Noun * -Verb * | Select Name, CommandType, Module |  Out-GridView
         
    }
    New-Button -ColumnSpan 2 "Get-Command" -On_Click $action
    
    New-Label -Row 1 "Noun"
    New-TextBox -Row 1 -Column 1 -Name Noun -On_PreviewKeyDown { if ($_.Key -ne "Enter") { return } }, $action
    New-Label -Row 2 "Verb"
    New-TextBox -Row 2 -Column 1 -Name Verb -On_PreviewKeyDown { if ($_.Key -ne "Enter") { return } }, $action
    New-Label -Row 3 "Name"
    New-TextBox -Row 3 -Column 1 -Name Name -On_PreviewKeyDown { if ($_.Key -ne "Enter") { return } }, $action
    New-Label -Row 4 "Module"
    New-TextBox -Row 4 -Column 1 -Name Module -On_PreviewKeyDown { if ($_.Key -ne "Enter") { return } }, $action
} -show