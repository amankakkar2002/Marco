page 50101 "Organic Molecule"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Organic Molecule";

    layout
    {
        area(Content)
        {
            repeater("Organic Molecules")
            {
                field(Code; Rec.Code)
                {

                }
                field("Organic Molecule"; OrganicMolecule)
                {
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.SetOrganicMolecule(OrganicMolecule);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OrganicMolecule := Rec.GetOrganicMolecule();
    end;

    var
        OrganicMolecule: Text;
}