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

    // local procedure BuildBankDetails(IBAN: Text; AccountNo: Text; Currency: Code[10]): Text
    // var
    //     Txt: Text;
    // begin
    //     Txt += '<b>Name of account:</b> - SpiroChem AG';
    //     Txt += '<br>';
    //     Txt += '<b>Name of bank:</b> ------ UBS Switzerland AG';
    //     Txt += '<br>';
    //     Txt += '<b>BIC:</b> ------------- UBSWCHZH80A';
    //     Txt += '<br>';
    //     Txt += '<b>IBAN:</b> ------------ ' + IBAN + '';
    //     Txt += '<br>';
    //     Txt += '<b>Account Nr.:</b> ----- ' + AccountNo + '';
    //     Txt += '<br>';
    //     Txt += '<b>Currency:</b> -------- ' + Currency + '';
    //     Txt += '<br>';
    //     Txt += '<b>VAT:</b> ------------- CHE-413.546.138';
    //     exit(Txt);
    // end;

}