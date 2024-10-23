unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnColorWall: TButton;
    btnColorDoor: TButton;
    btnColorRoof: TButton;
    btnColorWindow: TButton;
    btnTranslate: TButton;
    btnScaleDown: TButton;
    btnScaleUp: TButton;
    Timer1: TTimer;
    procedure btnColorDoorClick(Sender: TObject);
    procedure btnColorRoofClick(Sender: TObject);
    procedure btnColorWallClick(Sender: TObject);
    procedure btnColorWindowClick(Sender: TObject);
    procedure btnScaleDownClick(Sender: TObject);
    procedure btnScaleUpClick(Sender: TObject);
    procedure btnTranslateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
  { Private declarations }
    WallColor, RoofColor, DoorColor, WindowColor: TColor;
    ScaleFactor: Double;
    TranslateX, TranslateY: Integer;
  public
      { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// Menggambar rumah sederhana dengan skala
procedure TForm1.FormPaint(Sender: TObject);
var
  ScaledX1, ScaledY1, ScaledX2, ScaledY2: Integer;
begin
  // Menggunakan faktor skala untuk mengatur ukuran
  ScaledX1 := Round(100 * ScaleFactor);
  ScaledY1 := Round(200 * ScaleFactor);
  ScaledX2 := Round(300 * ScaleFactor);
  ScaledY2 := Round(400 * ScaleFactor);

  // Menggambar dinding
  Canvas.Brush.Color := WallColor;
  Canvas.Rectangle(ScaledX1 + TranslateX, ScaledY1 + TranslateY,
                   ScaledX2 + TranslateX, ScaledY2 + TranslateY);

  // Menggambar atap (segitiga)
  Canvas.Brush.Color := RoofColor;
  Canvas.Polygon([Point(ScaledX1 + TranslateX, ScaledY1 + TranslateY),
                  Point(ScaledX2 + TranslateX, ScaledY1 + TranslateY),
                  Point((ScaledX1 + ScaledX2) div 2 + TranslateX, ScaledY1 - Round(100 * ScaleFactor) + TranslateY)]);

  // Menggambar pintu
  Canvas.Brush.Color := DoorColor;
  Canvas.Rectangle(Round(180 * ScaleFactor) + TranslateX, Round(300 * ScaleFactor) + TranslateY,
                   Round(220 * ScaleFactor) + TranslateX, ScaledY2 + TranslateY);

  // Menggambar jendela (lingkaran)
  Canvas.Brush.Color := WindowColor;
  Canvas.Ellipse(Round(130 * ScaleFactor) + TranslateX, Round(230 * ScaleFactor) + TranslateY,
                 Round(170 * ScaleFactor) + TranslateX, Round(270 * ScaleFactor) + TranslateY);
end;

// Proses translasi rumah dalam timer
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  TranslateX := TranslateX + 5;  // Menggeser rumah secara horizontal
  if TranslateX > Form1.ClientWidth then
    TranslateX := -Round(300 * ScaleFactor);  // Mengulang dari awal jika sudah keluar dari layar
  Invalidate;  // Memicu ulang tampilan form untuk menggambar ulang
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ScaleFactor := 1.0;  // Faktor skala default
  TranslateX := 0;     // Posisi awal translasi
  TranslateY := 0;

  // Warna default
  WallColor := clBlue;
  RoofColor := clRed;
  DoorColor := clDkGray;
  WindowColor := clYellow;
end;

// Tombol untuk mengubah warna dinding
procedure TForm1.btnColorWallClick(Sender: TObject);
begin
  WallColor := clGreen;
  Invalidate;  // Memicu ulang tampilan form untuk menggambar ulang
end;

// Tombol untuk mengubah warna jendela
procedure TForm1.btnColorWindowClick(Sender: TObject);
begin
  WindowColor := clblue;
  Invalidate;
end;

// Tombol untuk memperkecil rumah (Scale Down)
procedure TForm1.btnScaleDownClick(Sender: TObject);
begin
  ScaleFactor := ScaleFactor - 0.1;
  if ScaleFactor < 0.1 then ScaleFactor := 0.1;  // Mencegah skala menjadi terlalu kecil
  Invalidate;
end;

// Memperbesar skala rumah (Scale up)
procedure TForm1.btnScaleUpClick(Sender: TObject);
begin
  ScaleFactor := ScaleFactor + 0.1;
  Invalidate;
end;

// Tombol untuk mengaktifkan animasi translasi (pergeseran rumah)
procedure TForm1.btnTranslateClick(Sender: TObject);
begin
  Timer1.Enabled := False;  // Mengaktifkan Timer untuk animasi
end;

// Tombol untuk mengubah warna atap
procedure TForm1.btnColorRoofClick(Sender: TObject);
begin
  RoofColor := clPurple;
  Invalidate;
end;

// Tombol untuk mengubah warna pintu
procedure TForm1.btnColorDoorClick(Sender: TObject);
begin
  DoorColor := clTeal;
  Invalidate;
end;

end.

