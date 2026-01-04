tableextension 50101 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "Terms and Conditions Code"; Code[20])
        {
            TableRelation = "Terms and Conditions Custom".Code;
        }
        field(50001; "Organic Molecule"; Code[20])
        {
            TableRelation = "Organic Molecule".Code;
        }
    }
}