pageextension 50102 SalesInvoicePageExt extends "Sales Invoice"
{
    layout
    {
        addafter("Work Description")
        {
            field("Terms and Conditions Code"; Rec."Terms and Conditions Code")
            {
                ApplicationArea = All;
            }
            field("Organic Molecule"; Rec."Organic Molecule")
            {
                ApplicationArea = All;
            }
        }
    }
}