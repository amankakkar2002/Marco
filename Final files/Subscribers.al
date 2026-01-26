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
}