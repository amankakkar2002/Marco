reportextension 50102 SalesQuoteExt extends "Standard Sales - Quote"
{
    RDLCLayout = 'SalesQuote.rdl';
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
            column(GetWorkDescription; GetWorkDescription)
            {

            }
        }
        add(Line)
        {
            column(Currency_Code; "Currency Code")
            {

            }
        }
    }
}