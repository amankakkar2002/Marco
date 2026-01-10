report 50100 SDS
{
    ApplicationArea = All;
    RDLCLayout = 'SDS.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Reservation Entry"; "Reservation Entry")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Source ID" = field("No.");
                DataItemTableView = where("Source Type" = const(37));
                column(Serial_No_; "Serial No.")
                {

                }
                column(GetPurity; GetPurity("Reservation Entry"))
                {

                }
                column(GetItemDesc; GetItemDesc("Item No."))
                {

                }
                column(GetItemCASNo; GetItemCASNo("Item No."))
                {

                }
                column(GetItemFormula; GetItemFormula("Item No."))
                {

                }
                column(GetItemCatalogID; GetItemCatalogID("Item No."))
                {

                }
                column(GetItemStorageRecom; GetItemStorageRecom("Item No."))
                {

                }
                column(GetItemMolWtWOSalt; GetItemMolWtWOSalt("Item No."))
                {

                }
                column(Today_Date; Today)
                {

                }
                column(CompanyName; CompanyInformation.Name)
                {

                }
                column(CompanyAddr; CompanyInformation.Address)
                {

                }
                column(CompanyAddr2; CompanyInformation."Address 2")
                {

                }
                column(CompanyCity; CompanyInformation.City)
                {

                }
                column(CompanyPostCode; CompanyInformation."Post Code")
                {

                }
                column(CompanyCountry; GetCountryName(CompanyInformation."Country/Region Code"))
                {

                }
                column(CompanyPhoneNo; CompanyInformation."Phone No.")
                {

                }
                column(CompanyEmail; CompanyInformation."E-Mail")
                {

                }
                trigger OnPreDataItem()
                begin
                    CompanyInformation.Get();
                end;
            }
        }
    }

    local procedure GetCountryName(CountryCode: Code[20]): Text
    var
        CountryRegion: Record "Country/Region";
    begin
        if CountryRegion.Get(CountryCode) then
            exit(CountryRegion.Name);
    end;

    local procedure GetPurity(var ReservationEntry: Record "Reservation Entry"): Decimal
    var
        SNAttributes: Record "SN Laboratory Attributes";
    begin
        if SNAttributes.Get("Reservation Entry"."Item No.", "Reservation Entry"."Serial No.") then
            exit(SNAttributes.Purity);
    end;

    local procedure GetItemDesc(ItemNo: Code[20]): Text
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then
            exit(Item.Description);
    end;

    local procedure GetItemCASNo(ItemNo: Code[20]): Text
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then
            exit(Item."COA CAS No.");
    end;

    local procedure GetItemFormula(ItemNo: Code[20]): Text
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then
            exit(Item."COA Chemical Formula");
    end;

    local procedure GetItemCatalogID(ItemNo: Code[20]): Text
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then
            exit(Item."Catalog ID");
    end;

    local procedure GetItemStorageRecom(ItemNo: Code[20]): Enum "COA Storage Recommendation"
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then
            exit(Item."COA Storage Recomm.");
    end;

    local procedure GetItemMolWtWOSalt(ItemNo: Code[20]): Decimal
    var
        Item: Record Item;
    begin
        if Item.Get(ItemNo) then
            exit(Item."COA Mol. Wt. wo Salt");
    end;

    var
        CompanyInformation: Record "Company Information";
        NoOfCopies: Integer;
}