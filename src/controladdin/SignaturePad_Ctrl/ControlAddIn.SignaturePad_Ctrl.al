controladdin "SignaturePad_Ctrl"
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts =
        'scripts/signature_pad.umd.js',
        'scripts/procedure.js';
    StyleSheets = 'scripts/Signature_css.css';


    event OnControlAddInReady();
    procedure SaveSignature(Image: Text);
    event AfterSaveSignature(Image: Text);
    procedure ClearPad()
    procedure Undo()

}