codeunit 50101 GeneralManagement
{
    var
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';

    procedure ExportToExcel(var RecGenJournalLines: Record "Gen. Journal Line")
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        GeneralJournalLines: Record "Gen. Journal Line";
        GenJournalLinesLbl: Label 'Gen. Journal Lines';
        ExcelFileName: Label 'GenJournalLines_%1';
    begin
        CreateHeader(TempExcelBuffer, RecGenJournalLines);
        CreateLines(TempExcelBuffer, RecGenJournalLines);

        TempExcelBuffer.CreateNewBook(GenJournalLinesLbl);
        TempExcelBuffer.WriteSheet(GenJournalLinesLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime));
        TempExcelBuffer.OpenExcel();
    end;

    local procedure CreateHeader(var TempExcelBuffer: Record "Excel Buffer"; var GeneralJournalLines: Record "Gen. Journal Line")
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Document No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Posting Date"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Account Type"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Account No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Bal. Account Type"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Bal. Account No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption(Amount), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption(Description), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Currency Code"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Bal. Gen. Posting Type"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Bal. VAT Bus. Posting Group"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Bal. VAT Prod. Posting Group"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Gen. Posting Type"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("VAT Bus. Posting Group"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("VAT Prod. Posting Group"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Shortcut Dimension 1 Code"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Applies-to Doc. No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GeneralJournalLines.FieldCaption("Document Type"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateLines(var TempExcelBuffer: Record "Excel Buffer"; var RecGeneralJournalLines: Record "Gen. Journal Line")
    var
        GeneralJournalLines: Record "Gen. Journal Line";
    begin
        GeneralJournalLines.Reset();
        GeneralJournalLines.SetRange("Journal Template Name", RecGeneralJournalLines."Journal Template Name");
        GeneralJournalLines.SetRange("Journal Batch Name", RecGeneralJournalLines."Journal Batch Name");
        if GeneralJournalLines.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(GeneralJournalLines."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Posting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Account Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Bal. Account Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Bal. Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines.Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Currency Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Bal. Gen. Posting Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Bal. VAT Bus. Posting Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Bal. VAT Prod. Posting Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Gen. Posting Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."VAT Bus. Posting Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."VAT Prod. Posting Group", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Shortcut Dimension 1 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Applies-to Doc. No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GeneralJournalLines."Document Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            until GeneralJournalLines.Next() = 0;
    end;

    procedure ReadAndImportExcelSheet(var RecGenJournalLine: Record "Gen. Journal Line")
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
        FileName: Text[100];
        SheetName: Text[100];
        TempExcelBuffer: Record "Excel Buffer" temporary;
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
        ImportExcelData(RecGenJournalLine, TempExcelBuffer);
    end;

    local procedure ImportExcelData(var RecGenJournalLine: Record "Gen. Journal Line"; var TempExcelBuffer: Record "Excel Buffer")
    var
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        DocumentNo: Code[20];
        PostingDate: Date;
        AccountType: Enum "Gen. Journal Account Type";
        AccountNo: Code[20];
        BalAccountType: Enum "Gen. Journal Account Type";
        BalAccountNo: Code[20];
        Amount: Decimal;
        Description: Text[100];
        CurrencyCode: Code[10];
        BalGenPostingType: Enum "General Posting Type";
        BalVATBusPostingGroup: Code[20];
        BalVATProdPostingGroup: Code[20];
        GenPostingType: Enum "General Posting Type";
        VATBusPostingGroup: Code[20];
        VATProdPostingGroup: Code[20];
        Dimension1: Code[20];
        AppliesToDocNo: Code[20];
        DocumentType: Enum "Gen. Journal Document Type";
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", RecGenJournalLine."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", RecGenJournalLine."Journal Batch Name");
        if GenJnlLine.FindSet() then
            if Dialog.Confirm('Lines already exist. Do you want to overwrite the existing lines?', true) then begin
                GenJnlLine.DeleteAll();
                LineNo := 0;
            end else begin
                GenJnlLine.FindLast();
                LineNo := GenJnlLine."Line No.";
            end;

        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;

        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;
            GenJnlLine.Init();
            GenJnlLine.Validate("Journal Template Name", RecGenJournalLine."Journal Template Name");
            GenJnlLine.Validate("Journal Batch Name", RecGenJournalLine."Journal Batch Name");
            GenJnlLine."Line No." := LineNo;

            Evaluate(DocumentNo, GetValueAtCell(RowNo, 1, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Document No.", DocumentNo);

            Evaluate(PostingDate, GetValueAtCell(RowNo, 2, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Posting Date", PostingDate);

            Evaluate(AccountType, GetValueAtCell(RowNo, 3, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Account Type", AccountType);

            Evaluate(AccountNo, GetValueAtCell(RowNo, 4, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Account No.", AccountNo);

            Evaluate(BalAccountType, GetValueAtCell(RowNo, 5, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Bal. Account Type", BalAccountType);

            Evaluate(BalAccountNo, GetValueAtCell(RowNo, 6, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.", BalAccountNo);

            Evaluate(Amount, GetValueAtCell(RowNo, 7, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine.Amount, Amount);

            Evaluate(Description, GetValueAtCell(RowNo, 8, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine.Description, Description);

            Evaluate(CurrencyCode, GetValueAtCell(RowNo, 9, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Currency Code", CurrencyCode);

            Evaluate(BalGenPostingType, GetValueAtCell(RowNo, 10, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Bal. Gen. Posting Type", BalGenPostingType);

            Evaluate(BalVATBusPostingGroup, GetValueAtCell(RowNo, 11, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Bal. VAT Bus. Posting Group", BalVATBusPostingGroup);

            Evaluate(BalVATProdPostingGroup, GetValueAtCell(RowNo, 12, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Bal. VAT Prod. Posting Group", BalVATProdPostingGroup);

            Evaluate(GenPostingType, GetValueAtCell(RowNo, 13, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Gen. Posting Type", GenPostingType);

            Evaluate(VATBusPostingGroup, GetValueAtCell(RowNo, 14, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group", VATBusPostingGroup);

            Evaluate(VATProdPostingGroup, GetValueAtCell(RowNo, 15, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group", VATProdPostingGroup);

            Evaluate(Dimension1, GetValueAtCell(RowNo, 16, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code", Dimension1);

            Evaluate(AppliesToDocNo, GetValueAtCell(RowNo, 17, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.", AppliesToDocNo);

            Evaluate(DocumentType, GetValueAtCell(RowNo, 18, TempExcelBuffer));
            GenJnlLine.Validate(GenJnlLine."Document Type", DocumentType);

            GenJnlLine.Insert();
        end;
        Message(ExcelImportSucess);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; var TempExcelBuffer: Record "Excel Buffer"): Text
    begin
        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;
}