pageextension 50100 "Sales Quote Page Ext" extends "Sales Quote"
{
    layout
    {
        addafter("Work Description")
        {
            field("Organic Molecule"; Rec."Organic Molecule")
            {
                ApplicationArea = All;
            }
        }
    }
}