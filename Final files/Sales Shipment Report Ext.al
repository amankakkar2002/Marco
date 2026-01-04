reportextension 50103 SalesShipmentExt extends "Standard Sales - Shipment"
{
    RDLCLayout = 'SalesShipment.rdl';
    dataset
    {
        add(Header)
        {
            column(CompanyInfoCountryCode; CompanyInfo."Country/Region Code")
            {
            }
        }
        add(Line)
        {
            column(SerialNo; GetSerialNo(Line))
            {
            }
        }
    }
    procedure GetSerialNo(var SalesLine: Record "Sales Shipment Line"): Text
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Document No.", SalesLine."Document No.");
        ItemLedgerEntry.SetRange("Posting Date", SalesLine."Posting Date");
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
        ItemLedgerEntry.SetRange("Document Line No.", SalesLine."Line No.");
        if ItemLedgerEntry.FindFirst() then
            exit(ItemLedgerEntry."Serial No.");
    end;
}