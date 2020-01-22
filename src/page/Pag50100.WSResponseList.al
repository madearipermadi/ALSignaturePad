page 50100 "WS Response List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "WS Response";

    layout
    {
        area(Content)
        {

            repeater(Group)
            {

                field(No; No)
                {
                    ApplicationArea = All;
                }

                field(JSONResponse; "JSON Response")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Instr: InStream;
                        ContentLine: Text;
                        ContentAll: Text;
                    begin
                        ContentAll := '';
                        ContentLine := '';
                        Rec.CALCFIELDS("JSON Response");
                        Rec."JSON Response".CreateInStream(Instr);
                        while not InStr.EOS do begin
                            InStr.READTEXT(ContentLine);
                            ContentAll += ContentLine;
                        end;

                        Message(ContentAll);
                    end;


                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Save Sample JSON")
            {
                ApplicationArea = All;


                trigger OnAction()
                var
                    OutStr: OutStream;
                    WSResponse: Record "WS Response";
                begin
                    WSResponse.Get(No);
                    WSResponse."JSON Response".CreateOutStream(OutStr);
                    Outstr.WRITETEXT(
                        '{' +
                            '"TM": 1564131091,' +
                            '"SC": "f858092d4b4e42e933c0c9032a499357a502365e9253c21e5ede1218b12f7e9c",' +
                            '"IC": "0778787873687",' +
                            '"DC": "87987879374492",' +
                            '"DP": "Cokelat Silver Queen",' +
                            '"IG": "Snack"' +
                        '}');
                    WSResponse.Modify();
                end;
            }
        }
    }
}