pageextension 50107 GenJournalLineExt extends "General Journal"
{
    actions
    {
        addlast(processing)
        {
            action(Download)
            {
                Caption = 'Export to Excel';
                Image = ExportToExcel;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.FindFirst() then
                        GeneralManagement.ExportToExcel(Rec);
                end;
            }
            action(Import)
            {
                Caption = 'Import from Excel';
                Image = ImportExcel;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TemplateIsBlankMsg: label 'Template Name cannot be blank';
                    BatchIsBlankMsg: label 'Batch Name cannot be blank';
                begin
                    if Rec."Journal Template Name" = '' then
                        Error(TemplateIsBlankMsg);

                    if Rec."Journal Batch Name" = '' then
                        Error(BatchIsBlankMsg);

                    GeneralManagement.ReadAndImportExcelSheet(Rec);
                end;
            }
        }
    }
    var
        GeneralManagement: Codeunit GeneralManagement;
}