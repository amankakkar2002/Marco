report 50111 "Item COA Report"
{
    Caption = 'COA Certificate';
    UsageCategory = None;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/COA/COAReport.Layout.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(SH_No; "No.") { }
            column(SH_SellToCustomer; "Sell-to Customer Name") { }
            column(SH_OrderDate; "Order Date") { }
            column(Date; Today) { }

            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                // DataItemLinkReference = SalesHeader;

                DataItemTableView = where(Type = const(Item)); // only item lines
                column(Document_No_; "Document No.") { }
                column(SL_LineNo; "Line No.") { }
                column(SL_ItemNo; "No.") { }
                column(SL_Description; Description) { }
                column(SL_Quantity; Quantity) { }

                dataitem(ResEntry; "Reservation Entry")
                {
                    // Link to this sales line
                    DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = field("Line No.");
                    // DataItemLinkReference = SalesLine;

                    DataItemTableView = where("Source Type" = const(37), Positive = const(false));    // outbound

                    column(RES_ItemNo; "Item No.") { }
                    column(RES_SerialNo; "Serial No.") { }
                    column(RES_Qty; Quantity) { }

                    dataitem(SNAttr; "SN Laboratory Attributes")
                    {
                        // Link lab attributes to this serial number
                        DataItemLink = "Item No." = field("Item No."), "Serial No." = field("Serial No.");
                        // DataItemLinkReference = ResEntry;

                        // ---- Serial attributes ----
                        column(SN_ItemNo; "Item No.") { }
                        column(SN_SerialNo; "Serial No.") { }
                        column(SN_Appearance; Appearance) { }
                        column(SN_MethodOfAnalysis; "Method of Analysis") { }
                        column(SN_Purity; Purity) { }
                        column(SN_IdentifiedImpurities; "Identified Impurities") { }
                        column(SN_Comments; Comments) { }

                        column(SN_ProducedBy; "Produced By Name") { }
                        column(SN_ProducedDate; "Produced Date") { }
                        column(SN_AnalyzedBy; "Analyzed By Name") { }
                        column(SN_AnalyzedDate; "Analyzed Date") { }
                        column(SN_ValidatedBy; "Validated By Name") { }
                        column(SN_ValidatedDate; "Validated Date") { }
                        column(SN_ProducedIn; Format("Produced In")) { }

                        // ---- Item COA master data ----
                        column(Item_CompoundRef; Item."COA Compound Ref.") { }
                        column(Item_CompoundName; Item."COA Compound Name") { }
                        column(Item_CASNo; Item."COA CAS No.") { }
                        column(Item_MolWtWSalt; Item."COA Mol. Wt. w Salt") { }
                        column(Item_MolWtWoSalt; Item."COA Mol. Wt. wo Salt") { }
                        column(Item_ChemFormula; Item."COA Chemical Formula") { }
                        column(Item_StorageRecomm; Format(Item."COA Storage Recomm.")) { }

                        // ---- Unit of Measure (204) ----
                        column(UOM_Code; Item."Base Unit of Measure") { }
                        column(UOM_Description; BaseUnitDescriptionTxt) { }

                        // ---- General report fields ----
                        column(ReportDate; Today()) { }


                        trigger OnAfterGetRecord()
                        begin
                            // Load Item & Unit of Measure description
                            Clear(BaseUnitDescriptionTxt);

                            if Item.Get("Item No.") then begin
                                if (Item."Base Unit of Measure" <> '') and
                                   UoM.Get(Item."Base Unit of Measure") then begin
                                    BaseUnitDescriptionTxt := UoM.Description;
                                end;
                            end;
                        end;
                    }
                }
            }


        }
    }

    var
        Item: Record Item;
        UoM: Record "Unit of Measure";           // table 204
        BaseUnitDescriptionTxt: Text[100];       // used in UOM_Description
}
