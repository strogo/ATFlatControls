unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ATListbox;

type
  { TfmMain }

  TfmMain = class(TForm)
    ed: TEdit;
    procedure edKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    procedure ListDraw(Sender: TObject; AIndex: integer; const ARect: TRect);
    procedure ListClick(Sender: TObject);
  public
    { public declarations }
    b: TATListbox;
  end;

var
  fmMain: TfmMain;

implementation

uses Math, LCLProc, LCLType;

{$R *.lfm}

{ TfmMain }

procedure TfmMain.FormCreate(Sender: TObject);
begin
  b:= TATListbox.Create(Self);
  b.Parent:= Self;
  b.Align:= alClient;
  b.OnDrawItem:= @ListDraw;
  b.OnClick:= @ListClick;

  b.Color:= $e0e0e0;
  b.ItemCount:= 21;
end;

procedure TfmMain.ListDraw(Sender: TObject; AIndex: integer; const ARect: TRect);
begin
  b.Canvas.Brush.Color:= IfThen(AIndex=b.ItemIndex, clMedGray, b.Color);
  b.Canvas.FillRect(ARect);

  b.Canvas.Pen.Color:= clMedGray;
  b.Canvas.Line(ARect.Left, ARect.Bottom-1, ARect.Right, ARect.Bottom-1);

  b.Canvas.TextOut(ARect.Left+4, ARect.Top+2, 'item '+inttostr(AIndex));
end;

procedure TfmMain.ListClick(Sender: TObject);
begin
  Beep;
  Caption:= 'Selected item: '+IntToStr(b.ItemIndex);
end;

procedure TfmMain.edKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key=vk_down) then
  begin
    if b.ItemIndex<b.ItemCount-1 then
      b.ItemIndex:= b.ItemIndex+1;
    //else
    //  b.ItemIndex:= 0;
    key:= 0;
    Exit
  end;
  if (key=vk_up) then
  begin
    if b.ItemIndex>0 then
      b.ItemIndex:= b.ItemIndex-1;
    //else
    //  b.ItemIndex:= b.ItemCount-1;
    key:= 0;
    Exit
  end;
  if (key=vk_home) then
  begin
    b.ItemIndex:= 0;
    key:= 0;
    Exit
  end;
  if (key=vk_end) then
  begin
    b.ItemIndex:= b.ItemCount-1;
    key:= 0;
    Exit
  end;
  if (key=vk_return) then
  begin
    ListClick(nil);
    key:= 0;
    Exit
  end;
end;

end.
