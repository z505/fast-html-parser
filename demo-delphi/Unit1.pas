unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  fasthtmlparser;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    bGetElementByID: TButton;
    procedure bGetElementByIDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.bGetElementByIDClick(Sender: TObject);
var
  s: string;
  Hp: THtmlParser;
  InnerHtml, Tag, TagEnd: string;
begin
  s := '<html><head></head><body><div>some text</div><div id="divbox1">text about <b>something</b></div></body></html>';
  Hp := THtmlParser.Create(s);
  InnerHtml := Hp.GetElementById('divbox1', Tag, TagEnd);
  Memo1.Lines.Add('Element name: divbox1');
  Memo1.Lines.Add('Element Inner HTML: ');
  Memo1.Lines.Add(InnerHtml);
  Memo1.Lines.Add('Tag: ');
  Memo1.Lines.Add(Tag);

  Hp.Free; Hp := nil;
end;

end.
