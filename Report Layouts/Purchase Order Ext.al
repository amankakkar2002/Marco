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
        }
        add("Purchase Line")
        {
            column(Currency_Code; "Currency Code")
            {

            }
        }
    }
}