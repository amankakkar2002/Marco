reportextension 50101 PurchaseOrderExt extends "Standard Purchase - Order"
{
    RDLCLayout = 'PurchaseOrder.rdl';
    dataset
    {
        add("Purchase Header")
        {
            column(CompanyInfoCountryCode; CompanyInfo."Country/Region Code")
            {

            }
            column(GetVendorName; GetVendorName("Purchase Header"))
            {

            }
            column(GetVendorAddress; GetVendorAddress("Purchase Header"))
            {

            }
            column(GetVendorCity; GetVendorCity("Purchase Header"))
            {

            }
            column(GetVendorCountry; GetVendorCountry("Purchase Header"))
            {

            }
        }
        add("Purchase Line")
        {
            column(Currency_Code; "Currency Code")
            {

            }
        }
    }

    local procedure GetVendorAddress(var PurchaseHeader: Record "Purchase Header"): Text
    var
        PurchaseHeaderRec: Record "Purchase Header";
        Vendor: Record Vendor;
    begin
        if PurchaseHeaderRec.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            if Vendor.Get(PurchaseHeader."Buy-from Vendor No.") then
                exit(Vendor.Address + ', ' + Vendor."Address 2");
        end;
    end;

    local procedure GetVendorName(var PurchaseHeader: Record "Purchase Header"): Text
    var
        PurchaseHeaderRec: Record "Purchase Header";
        Vendor: Record Vendor;
    begin
        if PurchaseHeaderRec.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            if Vendor.Get(PurchaseHeader."Buy-from Vendor No.") then
                exit(Vendor.Name);
        end;
    end;

    local procedure GetVendorCity(var PurchaseHeader: Record "Purchase Header"): Text
    var
        PurchaseHeaderRec: Record "Purchase Header";
        Vendor: Record Vendor;
    begin
        if PurchaseHeaderRec.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            if Vendor.Get(PurchaseHeader."Buy-from Vendor No.") then
                exit(Vendor."Post Code" + ' - ' + Vendor.City);
        end;
    end;

    local procedure GetVendorCountry(var PurchaseHeader: Record "Purchase Header"): Text
    var
        PurchaseHeaderRec: Record "Purchase Header";
        Vendor: Record Vendor;
        CountryRegion: Record "Country/Region";
    begin
        if PurchaseHeaderRec.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            if Vendor.Get(PurchaseHeader."Buy-from Vendor No.") then begin
                if CountryRegion.Get(Vendor."Country/Region Code") then
                    exit(CountryRegion.Name);
            end;
        end;
    end;

}