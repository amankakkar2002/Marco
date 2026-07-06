/// <summary>
/// AK QR Merging 07072026
///     <code>New Object Created </code>
/// </summary>
reportextension 50105 SalesInvoiceExt extends "Standard Sales - Invoice"
{
    RDLCLayout = 'src/Layouts/StandardSalesInvoice.rdl';
    dataset
    {
        add(Line)
        {
            column(Quantity; Quantity)
            {

            }
            column(Unit_Price; "Unit Price")
            {

            }
            column(VAT__; GetVAT(Line))
            {

            }
            column(Line_Discount__; "Line Discount %")
            {

            }
            column(Line_Amount; "Line Amount")
            {

            }
        }
        add(Header)
        {
            column(Currency_Code; LocalGetCurrencyCode("Currency Code"))
            {

            }
        }

        addbefore(Line)
        {
            dataitem(SwissQRBillBuffer; "Swiss QR-Bill Buffer")
            {
                DataItemTableView = sorting("Entry No.");
                UseTemporary = true;

                column(PaymentPartLbl; PaymentPartLbl) { }
                column(AccountPayableToLbl; AccountPayableToLbl) { }
                column(ReferenceLbl; ReferenceLbl) { }
                column(AdditionalInformationLbl; AdditionalInformationLbl) { }
                column(CurrencyLbl; CurrencyLbl) { }
                column(AmountLbl; AmountLbl) { }
                column(ReceiptLbl; ReceiptLbl) { }
                column(AcceptancePointLbl; AcceptancePointLbl) { }
                column(PayableByLbl; PayableByLbl) { }
                column(PayableByNameAddressLbl; PayableByNameAddressLbl) { }
                column(AltProcName1Lbl; "Alt. Procedure Name 1") { }
                column(AltProcName2Lbl; "Alt. Procedure Name 2") { }
                column(SeparateLbl; SeparateLbl) { }
                column(QRImage; "QR-Code Image") { }
                column(AccountPayableToText; AccountPayableTo) { }
                column(ReferenceText; PaymentReferenceNoText) { }
                column(PayableByText; PayableBy) { }
                column(AdditionalInformationText; AddInformationText) { }
                column(CurrencyText; Currency) { }
                column(AmountText; AmountText) { }
                column(AltProcValue1Text; "Alt. Procedure Value 1") { }
                column(AltProcValue2Text; "Alt. Procedure Value 2") { }
                column(CompanyInfoPicture; CompanyInfo.Picture) { }
                column(GlobalVAT; FormattedVATPct) { }

                trigger OnPreDataItem()
                begin
                    QRBufferMgt.GetBuffer(SwissQRBillBuffer);

                    PrintedCount := SwissQRBillBuffer.Count;

                    if PrintedCount > 0 then
                        SwissQRBillBuffer.FindSet();
                    CompanyInfo.Get();
                end;

                trigger OnAfterGetRecord()
                var
                    Language: Codeunit Language;
                begin
                    CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                    CurrReport.FormatRegion := Language.GetFormatRegionOrDefault("Format Region");
                    PrepareForPrint();
                    SwissQRBillMgt.GenerateImage(SwissQRBillBuffer);
                    AccountPayableTo := ReportAccountPayableToInfo(SwissQRBillBuffer);
                    PayableBy := ReportAccountPayableByInfo(SwissQRBillBuffer);
                    AmountText := FormatAmount(Amount);
                    PaymentReferenceNoText := SwissQRBillMgt.FormatPaymentReference("Payment Reference Type", "Payment Reference");
                    AddInformationText := ReportAddInformationInfo(SwissQRBillBuffer);
                    SwissQRBillBuffer.Modify();
                end;
            }
        }
    }

    var
        SwissQRBillMgt: Codeunit "Swiss QR-Bill Mgt.";
        AccountPayableTo: Text;
        PayableBy: Text;
        AddInformationText: Text;
        AmountText: Text;
        PaymentReferenceNoText: Text;
        PrintedCount: Integer;
        FilteredCount: Integer;
        BufferIsSet: Boolean;
        PaymentPartLbl: Label 'Payment part';
        AccountPayableToLbl: Label 'Account / Payable to';
        ReferenceLbl: Label 'Reference';
        AdditionalInformationLbl: Label 'Additional information';
        CurrencyLbl: Label 'Currency';
        AmountLbl: Label 'Amount';
        ReceiptLbl: Label 'Receipt';
        AcceptancePointLbl: Label 'Acceptance point';
        PayableByLbl: Label 'Payable by';
        PayableByNameAddressLbl: Label 'Payable by (name/address)';
        SeparateLbl: Label 'Separate before paying in';
        BlankedOutputErr: Label 'There is no document found to print QR-Bill with the specified filters. Only CHF and EUR currency is allowed.';
        NotAllPrintedMsg: Label 'Not all documents were printed QR-Bill with the specified filters. Only CHF and EUR currency is allowed.';
        QRBufferMgt: Codeunit "QR Buffer Mgt.";
        GlobalVAT: Decimal;

    trigger OnPreReport()
    begin
        GlobalVAT := 0;
    end;

    trigger OnPostReport()
    begin
        if SwissQRBillBuffer.FindSet() then
            repeat
                SwissQRBillMgt.DeleteTenantMedia(SwissQRBillBuffer."QR-Code Image".MediaId);
            until SwissQRBillBuffer.Next() = 0;

        if (PrintedCount = 0) and GuiAllowed() then
            Error(BlankedOutputErr);

        if (PrintedCount < FilteredCount) and GuiAllowed() then
            Message(NotAllPrintedMsg);

        QRBufferMgt.ClearBuffer();
    end;

    local procedure ReportAccountPayableToInfo(var SwissQRBillBuffer: Record "Swiss QR-Bill Buffer") Result: Text
    var
        TempCustomer: Record Customer temporary;
    begin
        Result := SwissQRBillMgt.FormatIBAN(SwissQRBillBuffer.IBAN);
        if SwissQRBillBuffer.GetCreditorInfo(TempCustomer) then
            SwissQRBillMgt.AddLine(Result, ReportFormatCustomerPartyInfo(TempCustomer));
    end;

    local procedure ReportAccountPayableByInfo(var SwissQRBillBuffer: Record "Swiss QR-Bill Buffer"): Text
    var
        TempCustomer: Record Customer temporary;
    begin
        if SwissQRBillBuffer.GetUltimateDebitorInfo(TempCustomer) then
            exit(ReportFormatCustomerPartyInfo(TempCustomer));
    end;

    local procedure ReportFormatCustomerPartyInfo(Customer: Record Customer) Result: Text
    begin
        SwissQRBillMgt.AddLineIfNotBlanked(Result, CopyStr(Customer.Name, 1, 70));
        SwissQRBillMgt.AddLineIfNotBlanked(Result, CopyStr(Customer.Address + ' ' + Customer."Address 2", 1, 70));
        SwissQRBillMgt.AddLineIfNotBlanked(Result, CopyStr(Customer."Post Code" + ' ' + Customer.City, 1, 70));
    end;

    local procedure ReportAddInformationInfo(SwissQRBillBuffer: Record "Swiss QR-Bill Buffer") Result: Text
    var
        BillingInfo: Text;
    begin
        SwissQRBillBuffer.CheckLimitForUnstrAndBillInfoText();
        BillingInfo := SwissQRBillBuffer."Billing Information";
        Result := SwissQRBillBuffer."Unstructured Message";
        if (Result <> '') and (StrLen(BillingInfo) > 45) then
            Result += ' ' + BillingInfo
        else
            SwissQRBillMgt.AddLineIfNotBlanked(Result, BillingInfo);
    end;

    local procedure FormatAmount(Amount: Decimal): Text
    begin
        if Amount = 0 then
            exit('');
        exit(Format(Round(Amount, 0.01), 0, '<Sign><Integer Thousand><1000Character, ><Decimals,3><Comma,.><Filler Character,0>'));
    end;

    local procedure LocalGetCurrencyCode(CurrencyCode: Code[20]): Text
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if CurrencyCode = '' then begin
            GLSetup.Get();
            exit(GLSetup."LCY Code");
        end;
        exit(CurrencyCode);
    end;

    local procedure GetVAT(var Line: Record "Sales Invoice Line"): Decimal
    begin
        if GlobalVAT = 0 then
            GlobalVAT := Line."VAT %";

        exit(Line."VAT %");
    end;
}