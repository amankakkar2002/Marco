pageextension 50104 "Item Card COA Ext" extends "Item Card"
{
    layout
    {
        addafter("No.")
        {
            field("Item Name"; Rec."Item Name")
            {
                ApplicationArea = All;
                ToolTip = 'Name of the compound.';
            }
        }
        addlast(Item)
        {
            field("SMILES"; Rec."SMILES")
            {
                ApplicationArea = All;
                ToolTip = 'SMILES notation of the compound.';
            }
        }
        addafter(Item)
        {
            group("COA fields")
            {
                Caption = 'COA fields';

                field("COA Compound Ref."; Rec."COA Compound Ref.")
                {
                    ApplicationArea = All;
                }
                field("COA Compound Name"; Rec."COA Compound Name")
                {
                    ApplicationArea = All;
                }
                field("COA CAS No."; Rec."COA CAS No.")
                {
                    ApplicationArea = All;
                }
                field("COA Mol. Wt. w Salt"; Rec."COA Mol. Wt. w Salt")
                {
                    ApplicationArea = All;
                }
                field("COA Mol. Wt. wo Salt"; Rec."COA Mol. Wt. wo Salt")
                {
                    ApplicationArea = All;
                }
                field("COA Chemical Formula"; Rec."COA Chemical Formula")
                {
                    ApplicationArea = All;
                }
                field("Catalog ID"; Rec."Catalog ID")
                {
                    ApplicationArea = All;
                }
            }

            group("COA Settings")
            {
                Caption = 'COA Settings';

                field("COA Storage Recomm."; Rec."COA Storage Recomm.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
