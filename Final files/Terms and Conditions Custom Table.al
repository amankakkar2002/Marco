table 50100 "Terms and Conditions Custom"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Terms and Conditions"; Blob)
        {
            Caption = 'Terms and Conditions';
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
    procedure SetTermsAndConditions(NewTermsAndConditions: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Terms and Conditions");
        "Terms and Conditions".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewTermsAndConditions);
        Modify();
    end;

    procedure GetTermsAndConditions(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Terms and Conditions");
        "Terms and Conditions".CreateInStream(InStream, TextEncoding::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Terms and Conditions")));
    end;
}