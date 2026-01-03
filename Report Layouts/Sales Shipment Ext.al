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
    }
}