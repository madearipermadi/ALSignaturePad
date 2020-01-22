pageextension 50100 "PostedSalesShipmentExt" extends "Posted Sales Shipment" //130
{
    layout
    {
        addafter("Work Description")
        {

            field("Signature Image"; "Signature Image")
            {
                ApplicationArea = All;
                Caption = 'Signature';
            }
        }

    }

    actions
    {
        addafter("&Print")
        {
            action("Record Signature")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    SignaturePad: page "Signature Pad";
                begin
                    Clear(SignaturePad);
                    SignaturePad.SetPostedShipmentNo("No.");
                    SignaturePad.RunModal();
                end;
            }

            action("Get Token")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    WSMgt: Codeunit "Web Service Mgt.";
                begin
                    WSMgt.GetOauthToken();
                end;
            }
        }

    }
}