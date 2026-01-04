pageextension 50103 PostedSalesInvoiceExt extends "Posted Sales Invoice"
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