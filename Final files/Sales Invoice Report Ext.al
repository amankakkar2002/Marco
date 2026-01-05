reportextension 50105 SalesInvoiceExt extends "Standard Sales - Invoice"
{
    RDLCLayout = 'SalesInvoice.rdl';
    dataset
    {
        add(Header)
        {
            column(CompanyInfoCountryCode; CompanyInfo."Country/Region Code")
            {

            }
            column(Currency_Code_Header; "Currency Code")
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
            column(Pre_Assigned_No_; "Pre-Assigned No.")
            {

            }
            column(GetIBAN; GetIBAN(Header))
            {

            }
            column(GetAccountNo; GetAccountNo(Header))
            {

            }
            column(GetCurrency; GetCurrency(Header))
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
        }
        add(Line)
        {
            column(Currency_Code; Line.GetCurrencyCode())
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
        BankDetails: Text;

    procedure GetTermsAndConditions(var SalesInvoiceHeader: Record "Sales Invoice Header"): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        TermsAndConditions: Record "Terms and Conditions Custom";
    begin
        if TermsAndConditions.Get(SalesInvoiceHeader."Terms and Conditions Code") then begin
            TermsAndConditions.CalcFields("Terms and Conditions");
            TermsAndConditions."Terms and Conditions".CreateInStream(InStream, TextEncoding::UTF8);
            exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), TermsAndConditions.FieldName("Terms and Conditions")));
        end;
    end;

    procedure GetOrganicMolecule(var SalesInvoiceHeader: Record "Sales Invoice Header"): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        OrganicMolecule: Record "Organic Molecule";
    begin
        if OrganicMolecule.Get(SalesInvoiceHeader."Organic Molecule") then begin
            OrganicMolecule.CalcFields("Organic Molecule");
            OrganicMolecule."Organic Molecule".CreateInStream(InStream, TextEncoding::UTF8);
            exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), OrganicMolecule.FieldName("Organic Molecule")));
        end;
    end;

    procedure GetIBAN(var SalesInvoiceHeader: Record "Sales Invoice Header"): Text
    var
        BankDetails: Text;
    begin
        case SalesInvoiceHeader."Currency Code" of
            'USD':
                exit('CH26 0023 3233 2173 8761 U');

            'EUR':
                exit('CH16 0023 3233 2173 8760 J');

            else
                exit('CH74 0023 3233 2173 8701 P');
        end;
    end;

    procedure GetAccountNo(var SalesInvoiceHeader: Record "Sales Invoice Header"): Text
    var
        BankDetails: Text;
    begin
        case SalesInvoiceHeader."Currency Code" of
            'USD':
                exit('233-217387.61U');

            'EUR':
                exit('233-217387.60J');

            else
                exit('233-217387.01P');
        end;
    end;

    procedure GetCurrency(var SalesInvoiceHeader: Record "Sales Invoice Header"): Text
    var
        BankDetails: Text;
    begin
        case SalesInvoiceHeader."Currency Code" of
            'USD':
                exit('USD');

            'EUR':
                exit('EUR');

            else
                exit('CHF');
        end;
    end;


    local procedure GetCustomerAddress(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
        Customer: Record Customer;
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then
                exit(Customer.Address + ', ' + Customer."Address 2");
        end;
    end;

    local procedure GetCustomerName(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
        Customer: Record Customer;
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then
                exit(Customer.Name);
        end;
    end;

    local procedure GetCustomerCity(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
        Customer: Record Customer;
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then
                exit(Customer."Post Code" + ' - ' + Customer.City);
        end;
    end;

    local procedure GetCustomerCountry(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
        Customer: Record Customer;
        CountryRegion: Record "Country/Region";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
                if CountryRegion.Get(Customer."Country/Region Code") then
                    exit(CountryRegion.Name);
            end;
        end;
    end;

    local procedure GetShippingAddress(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Address" + ', ' + SalesHeader."Ship-to Address 2");
        end;
    end;

    local procedure GetShippingName(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Name");
        end;
    end;

    local procedure GetShippingCity(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Post Code" + ' - ' + SalesHeader."Ship-to City")
        end;
    end;

    local procedure GetShippingPhone(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            exit(SalesHeader."Ship-to Phone No.");
        end;
    end;

    local procedure GetShippingCountry(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
        CountryRegion: Record "Country/Region";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            if CountryRegion.Get(SalesHeader."Ship-to Country/Region Code") then
                exit(CountryRegion.Name);
        end;
    end;

    local procedure GetBillingAddress(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            exit(SalesHeader."Bill-to Address" + ', ' + SalesHeader."Bill-to Address 2");
        end;
    end;

    local procedure GetBillingName(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            exit(SalesHeader."Bill-to Name");
        end;
    end;

    local procedure GetBillingCity(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            exit(SalesHeader."Bill-to Post Code" + ' - ' + SalesHeader."Bill-to City")
        end;
    end;

    local procedure GetBillingCountry(var SalesHeader: Record "Sales Invoice Header"): Text
    var
        SalesHeaderRec: Record "Sales Invoice Header";
        CountryRegion: Record "Country/Region";
    begin
        if SalesHeaderRec.Get(SalesHeader."No.") then begin
            if CountryRegion.Get(SalesHeader."Bill-to Country/Region Code") then
                exit(CountryRegion.Name);
        end;
    end;
}