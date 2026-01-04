pageextension 50101 SalesOrderPageExt extends "Sales Order"
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