reportextension 50104 SalesProFormaExt extends "Standard Sales - Pro Forma Inv"
{
    RDLCLayout = 'SalesProFormaInv.rdl';
    dataset
    {
        add(Header)
        {
            column(CompanyInfoCountryCode; CompanyInformation."Country/Region Code")
            {

            }
            column(VAT_Registration_No_; GetVATRegistrationNo(Header))
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
            column(ShowShipAddr; FormatAddr.SalesHeaderShipTo(ShipToAddr, CustomerAddress, Header))
            {

            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
        }
        add(Line)
        {
            column(Currency_Code; "Currency Code")
            {

            }
            column(No_; "No.")
            {

            }
            column(Unit_of_Measure; "Unit of Measure")
            {

            }
            column(Line_No_; "Line No.")
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
            column(TotalVATAmountDec; TotalVATAmount)
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

    local procedure GetVATRegistrationNo(var SalesHeader: Record "Sales Header"): Text
    var
        Customer: Record Customer;
    begin
        If Customer.Get(Header."Bill-to Customer No.") and (Customer."VAT Registration No." <> '') then
            exit(Customer."VAT Registration No.")
        else if Customer.Get(Header."Sell-to Customer No.") and (Customer."VAT Registration No." <> '') then
            exit(Customer."VAT Registration No.")
        else
            exit(SalesHeader."VAT Registration No.");
    end;
}