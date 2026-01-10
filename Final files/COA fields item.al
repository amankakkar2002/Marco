tableextension 50103 "Item COA Ext" extends Item
{
    fields
    {
        field(50100; "COA Compound Ref."; Code[50])
        {
            Caption = 'COA Compound Ref.';
            DataClassification = ToBeClassified;
        }

        field(50101; "COA Compound Name"; Text[100])
        {
            Caption = 'COA Compound Name';
            DataClassification = ToBeClassified;
        }

        field(50102; "COA CAS No."; Code[50])
        {
            Caption = 'COA CAS No.';
            DataClassification = ToBeClassified;
        }

        field(50103; "COA Mol. Wt. w Salt"; Decimal)
        {
            Caption = 'COA Mol. Wt. w Salt';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 6;
        }

        field(50104; "COA Mol. Wt. wo Salt"; Decimal)
        {
            Caption = 'COA Mol. Wt. wo Salt';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 6;
        }

        field(50105; "COA Chemical Formula"; Text[100])
        {
            Caption = 'COA Chemical Formula';
            DataClassification = ToBeClassified;
        }

        field(50106; "COA Storage Recomm."; Enum "COA Storage Recommendation")
        {
            Caption = 'COA Storage Recommendation';
            DataClassification = ToBeClassified;
        }
        field(50107; "SMILES"; Text[350])
        {
            Caption = 'SMILES';
            DataClassification = ToBeClassified;
        }
        field(50108; "Item Name"; Text[350])
        {
            Caption = 'Item Name';
            DataClassification = ToBeClassified;
        }
        field(50109; "Catalog ID"; Text[350])
        {
            Caption = 'Catalog ID';
            DataClassification = ToBeClassified;
        }
    }
}
