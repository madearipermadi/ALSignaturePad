table 50100 "WS Response"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "JSON Response"; Blob)
        {
            Subtype = Json;
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

}