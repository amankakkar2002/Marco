pageextension 50100 "Sales Quote Page Ext" extends "Sales Quote"
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