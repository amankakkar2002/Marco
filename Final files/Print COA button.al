pageextension 50130 "SalesOrderCOAExt" extends "Sales Order"
{
    actions
    {
        addlast(Reporting)
        {
            action(PrintCOA)
            {
                Caption = 'Print COA';
                ApplicationArea = All;
                Image = Report;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    SalesHeader := Rec;
                    SalesHeader.SetRecFilter();
                    Report.Run(Report::"Item COA Report", true, false, SalesHeader);
                end;
            }
            action(PrintSDS)
            {
                Caption = 'Print SDS';
                ApplicationArea = All;
                Image = Report;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    SalesHeader := Rec;
                    SalesHeader.SetRecFilter();
                    Report.Run(Report::SDS, true, false, SalesHeader);
                end;
            }
        }
    }
}