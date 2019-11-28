tableextension 50100 "SalesShipmentHeaderExt" extends "Sales Shipment Header" //110
{
    fields
    {
        field(50100; "Signature Image"; Blob)
        {
            Subtype = Bitmap;
            DataClassification = ToBeClassified;
        }

    }

}