codeunit 50100 CustomSubscribers
{
    [EventSubscriber(ObjectType::Report, Report::"Standard Sales - Pro Forma Inv", OnAfterLineOnPreDataItem, '', false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
        SalesLine.SetRange(Type);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Standard Sales - Pro Forma Inv", OnBeforeGetItemForRec, '', false, false)]
    local procedure OnBeforeGetItemForRec(ItemNo: Code[20]; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //>> AK QR Merging 07072026
    [EventSubscriber(ObjectType::Report, Report::"Standard Sales - Invoice", 'OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted', '', false, false)]
    local procedure OnHeaderOnAfterGetRecordOnAfterUpdateNoPrinted(ReportInPreviewMode: Boolean; var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        QRBufferMgt: Codeunit "QR Buffer Mgt.";
        TempSwissQRBillBuffer: Record "Swiss QR-Bill Buffer" temporary;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(SalesInvoiceHeader);

        TempSwissQRBillBuffer.InitBuffer('');
        // TempSwissQRBillBuffer.InitSourceRecord(RecRef);
        TempSwissQRBillBuffer.SetSourceRecord(SalesInvoiceHeader."Cust. Ledger Entry No.");
        QRBufferMgt.AddBuffer(TempSwissQRBillBuffer);
    end;

    //<< AK QR Merging 07072026
}