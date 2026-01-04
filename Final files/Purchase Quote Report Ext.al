reportextension 50100 PurchaseQuoteExt extends "Purchase - Quote"
{
    RDLCLayout = 'PurchaseQuote.rdl';
    dataset
    {
        add(CopyLoop)
        {
            column(CompanyInfoCountryCode; CompanyInfo."Country/Region Code")
            {

            }
        }
    }
}