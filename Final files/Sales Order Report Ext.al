reportextension 50106 SalesOrderExt extends "Standard Sales - Order Conf."
{
    RDLCLayout = 'SalesOrderConf.rdl';
    dataset
    {
        add(Header)
        {
            column(CompanyInfoCountryCode; CompanyInfo."Country/Region Code")
            {

            }
            column(Currency_Code_Header; GetCurrencyCode("Currency Code"))
            {

            }
            column(GetTermsAndConditions; GetTermsAndConditions(Header))
            {

            }
            column(GetOrganicMolecule; GetOrganicMolecule(Header))
            {

            }
            column(GetWorkDescription; GetWorkDescription)
            {

            }
            column(GetCustomerName; GetCustomerName(Header))
            {

            }
            column(GetCustomerAddress; GetCustomerAddress(Header))
            {

            }
            column(GetCustomerCity; GetCustomerCity(Header))
            {

            }
            column(GetCustomerCountry; GetCustomerCountry(Header))
            {

            }
            column(GetShippingName; GetShippingName(Header))
            {

            }
            column(GetShippingAddress; GetShippingAddress(Header))
            {

            }
            column(GetShippingCity; GetShippingCity(Header))
            {

            }
            column(GetShippingCountry; GetShippingCountry(Header))
            {

            }
            column(GetShippingPhone; GetShippingPhone(Header))
            {

            }
            column(GetBillingName; GetBillingName(Header))
            {

            }
            column(GetBillingAddress; GetBillingAddress(Header))
            {

            }
            column(GetBillingCity; GetBillingCity(Header))
            {

            }
            column(GetBillingCountry; GetBillingCountry(Header))
            {

            }
            column(Ship_to_Contact; "Ship-to Contact")
            {

            }
        }
        add(Totals)
        {
            column(TotalAmountDec; TotalAmount)
            {

            }
            column(TotalAmountInclVATDec; TotalAmountInclVAT)
            {

            }
            column(TotalVATAmountDec; TotalAmountVAT)
            {

            }
        }
    }

    var
        FormatAddr: Codeunit "Format Address";
        ShipToAddr: array[8] of Text[100];


    procedure GetTermsAndConditions(var SalesHeader: Record "Sales Header"): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        TermsAndConditions: Record "Terms and Conditions Custom";
    begin
        if TermsAndConditions.Get(SalesHeader."Terms and Conditions Code") then begin
            TermsAndConditions.CalcFields("Terms and Conditions");
            TermsAndConditions."Terms and Conditions".CreateInStream(InStream, TextEncoding::UTF8);
            exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), TermsAndConditions.FieldName("Terms and Conditions")));
        end;
    end;

    procedure GetOrganicMolecule(var SalesHeader: Record "Sales Header"): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        OrganicMolecule: Record "Organic Molecule";
    begin
        if OrganicMolecule.Get(SalesHeader."Organic Molecule") then begin
            OrganicMolecule.CalcFields("Organic Molecule");
            OrganicMolecule."Organic Molecule".CreateInStream(InStream, TextEncoding::UTF8);
            exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), OrganicMolecule.FieldName("Organic Molecule")));
        end;
    end;

    local procedure GetCustomerAddress(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
        Customer: Record Customer;
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then
                exit(Customer.Address + ', ' + Customer."Address 2");
        end;
    end;

    local procedure GetCustomerName(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
        Customer: Record Customer;
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then
                exit(Customer.Name);
        end;
    end;

    local procedure GetCustomerCity(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
        Customer: Record Customer;
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then
                exit(Customer."Post Code" + ' - ' + Customer.City);
        end;
    end;

    local procedure GetCustomerCountry(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
        Customer: Record Customer;
        CountryRegion: Record "Country/Region";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
                if CountryRegion.Get(Customer."Country/Region Code") then
                    exit(CountryRegion.Name);
            end;
        end;
    end;

    local procedure GetShippingAddress(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Address" + ', ' + SalesHeader."Ship-to Address 2");
        end;
    end;

    local procedure GetShippingName(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Name");
        end;
    end;

    local procedure GetShippingCity(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Post Code" + ' - ' + SalesHeader."Ship-to City")
        end;
    end;

    local procedure GetShippingPhone(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Phone No.");
        end;
    end;

    local procedure GetShippingCountry(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
        CountryRegion: Record "Country/Region";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            if CountryRegion.Get(SalesHeader."Ship-to Country/Region Code") then
                exit(CountryRegion.Name);
        end;
    end;

    local procedure GetBillingAddress(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            exit(SalesHeader."Bill-to Address" + ', ' + SalesHeader."Bill-to Address 2");
        end;
    end;

    local procedure GetBillingName(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            exit(SalesHeader."Bill-to Name");
        end;
    end;

    local procedure GetBillingCity(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            exit(SalesHeader."Bill-to Post Code" + ' - ' + SalesHeader."Bill-to City")
        end;
    end;

    local procedure GetBillingCountry(var SalesHeader: Record "Sales Header"): Text
    var
        SalesHeaderRec: Record "Sales Header";
        CountryRegion: Record "Country/Region";
    begin
        if SalesHeaderRec.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            if CountryRegion.Get(SalesHeader."Bill-to Country/Region Code") then
                exit(CountryRegion.Name);
        end;
    end;

    local procedure GetCurrencyCode(CurrencyCode: Code[20]): Text
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if CurrencyCode = '' then begin
            GLSetup.Get();
            exit(GLSetup."LCY Code");
        end
        else
            exit(CurrencyCode);
    end;
}