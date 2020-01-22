page 50130 "Signature Pad"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    Editable = true;


    layout
    {
        area(Content)
        {
            group(Signature)
            {
                usercontrol(SignaturePad; SignaturePad_Ctrl)
                {
                    ApplicationArea = All;

                    trigger OnControlAddInReady()
                    begin
                    end;

                    trigger AfterSaveSignature(Image: Text)
                    var
                        SalesShipmentHeader: record "Sales Shipment Header";
                        Base64Convert: Codeunit "Base64 Convert";
                        Outstream: OutStream;
                    begin


                        SalesShipmentHeader.Get(PostedShipmentNo);

                        SalesShipmentHeader."Signature Image".CreateOutStream(OutStream);
                        Base64Convert.FromBase64(Image.Remove(1, 22), Outstream);
                        SalesShipmentHeader.Modify();

                        Message('Image has been saved');


                    end;

                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Clear")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SignaturePad.ClearPad();
                end;
            }

            action("Update Profile")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    UserPersonalizationRec: record "User Personalization";
                    ProfileRec: record "All Profile";
                    SessionSettingVar: SessionSettings;
                    ProfileScope: Option System,Tenant;
                begin
                    UserPersonalizationRec.SetRange("User ID", UserId);
                    if UserPersonalizationRec.FindFirst() then begin

                        UserPersonalizationRec."Profile ID" := 'NEWPROFILE';
                        UserPersonalizationRec.Modify();

                        ProfileRec.SetRange("Profile ID", UserPersonalizationRec."Profile ID");
                        ProfileRec.FindFirst();



                        SessionSettingVar.Init();

                        SessionSettingVar.Company := CompanyName;
                        SessionSettingVar.ProfileId := UserPersonalizationRec."Profile ID";
                        SessionSettingVar.ProfileAppId := ProfileRec."App ID";
                        SessionSettingVar.ProfileSystemScope := ProfileScope = ProfileScope::System;
                        SessionSettingVar.LanguageId := UserPersonalizationRec."Language ID";
                        SessionSettingVar.LocaleId := UserPersonalizationRec."Locale ID";
                        SessionSettingVar.TimeZone := UserPersonalizationRec."Time Zone";

                        SessionSettingVar.RequestSessionUpdate(true);
                    end;
                end;
            }

            action("Undo")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SignaturePad.Undo();
                end;
            }

            action("Save Signature")
            {
                ApplicationArea = All;


                trigger OnAction()
                var
                    Image: Text;
                begin
                    CurrPage.SignaturePad.SaveSignature(Image);
                end;
            }

        }
    }

    var
        PostedShipmentNo: Code[20];

    procedure SetPostedShipmentNo(pcodePostedShipmentNo: Code[20])
    begin
        PostedShipmentNo := pcodePostedShipmentNo;
    end;
}