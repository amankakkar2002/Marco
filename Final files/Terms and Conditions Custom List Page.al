page 50100 "Terms and Conditions Custom"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Terms and Conditions Custom";

    layout
    {
        area(Content)
        {
            repeater("TermsAndConditions")
            {
                Caption = 'Terms and Conditions';
                field(Code; Rec.Code)
                {

                }
                field("Terms and Conditions"; TermsAndConditions)
                {
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.SetTermsAndConditions(TermsAndConditions);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        TermsAndConditions := Rec.GetTermsAndConditions();
    end;

    var
        TermsAndConditions: Text;
}