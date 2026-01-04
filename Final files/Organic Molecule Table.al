table 50101 "Organic Molecule"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Organic Molecule"; Blob)
        {
            Caption = 'Organic Molecule';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    procedure SetOrganicMolecule(NewOrganicMolecule: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Organic Molecule");
        "Organic Molecule".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewOrganicMolecule);
        Modify();
    end;

    procedure GetOrganicMolecule(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Organic Molecule");
        "Organic Molecule".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Organic Molecule")));
    end;
}