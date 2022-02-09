unit uFrmMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLScene, GLObjects, GLMisc, GLWin32Viewer, GLVectorFileObjects,
  GLTexture, ExtCtrls, jpeg, StdCtrls, AsyncTimer;



type
  TBound =  array [0..3] of integer;

  TfmMap = class(TForm)
    GLScene1: TGLScene;
    dcMainCameraContainer: TGLDummyCube;
    cameraMain: TGLCamera;
    lightMainCamera: TGLLightSource;
    dcCameraTarget: TGLDummyCube;
    Plane: TGLPlane;
    PlaneFF: TGLFreeForm;
    GLMaterialLibrary1: TGLMaterialLibrary;
    ProxyObject: TGLProxyObject;
    Panel1: TPanel;
    ViewerMap: TGLSceneViewer;
    Panel2: TPanel;
    AsyncTimer1: TAsyncTimer;
    CheckBox1: TCheckBox;
    imgMain: TImage;
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ViewerMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ViewerMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure AsyncTimer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    mdx, mdy : Integer;
    f_bound: TBound;
    f_multiplier:integer;
    xx,yy: integer;
    f_image :TImage;

    f_pick:TPoint;
  public
    { Public declarations }
  end;

var
  fmMap: TfmMap;

implementation

uses VectorGeometry
     {uGlobalVars};

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TfmMap.AsyncTimer1Timer(Sender: TObject);
var
  bm1,bm2 :  TBitmap;
  A,B,C,D  , AB,AC,AD: TPoint;
  cc, ss,fi,angle : Single;
  v1,v2,v3,v4:TAffineVector;



begin
    angle := 50;





    bm2 := TBitmap.Create;
    bm2.Height:= imgMain.Height;
    bm2.Width := imgMain.Width;
    try
   //   bm2.Assign(imgBack.Picture.Bitmap);
//        bm2.Canvas.Draw(0,0,f_image.Picture.Graphic);  // Ok!!!!
      bm2.Canvas.StretchDraw( Bounds(f_bound[0]-f_multiplier,f_bound[1]-f_multiplier,f_bound[2]+f_multiplier,f_bound[3]+f_multiplier), f_image.Picture.Graphic);
      bm2.PixelFormat := pf32bit;


      A.X:=xx;
      A.Y:=yy;
      B.X:=f_pick.X;
      B.Y:=f_pick.Y;
   //   bm2.Canvas.Pen.Style:=psClear;
      bm2.Canvas.Pen.Style:=psDot;
      bm2.Canvas.Pen.Color := clAqua;
      bm2.Canvas.Brush.Color := clTeal;
      bm2.Canvas.Brush.Style :=bsCross;
     // bm2.Canvas.Pen.Color:=clTeal;
      bm2.Canvas.MoveTo(B.X, B.Y );
      bm2.Canvas.LineTo(A.X, A.Y );
      bm2.Canvas.Pen.Style:=psSolid;

      bm2.Canvas.Brush.Style :=bsSolid;
      bm2.Canvas.Pen.Color:=clAqua;
      bm2.Canvas.Brush.Color := clTeal;
   //   bm2.Canvas.Brush.Style :=bsCross;
      AB.X:= B.X - A.X;
      AB.Y:= B.Y - A.Y;
      C.X:= A.X+AB.X;
      C.Y:= A.Y+AB.Y;
      fi:= DegToRad(angle);
      AC.X:= round(AB.X*cos(fi) - AB.Y*sin(fi));
      AC.Y:= round(AB.X*sin(fi) + AB.Y*cos(fi));
      C.X:= A.X+AC.X;
      C.Y:= A.Y+AC.Y;
      fi:= DegToRad(-angle);
      AD.X:= round(AB.X*cos(fi) - AB.Y*sin(fi));
      AD.Y:= round(AB.X*sin(fi) + AB.Y*cos(fi));
      D.X:= A.X+AD.X;
      D.Y:= A.Y+AD.Y;
      bm2.Canvas.Pie(A.X-25,A.Y-25,A.X+25,A.Y+25, C.X,C.Y,  D.X,D.Y);



      bm2.Canvas.Brush.Color:=clRed;
      bm2.Canvas.Pen.Color:=clBlack;
      bm2.Canvas.Ellipse(A.X-5,A.Y-5,A.X+5,A.Y+5);

      bm2.Canvas.Brush.Style:=bsClear;
      bm2.Canvas.Font.Name:='Arial';
      bm2.Canvas.Font.Size:= 10;
      bm2.Canvas.Font.Color:=clSilver;
      bm2.Canvas.TextOut(xx+3,yy-14,'охрана');
      bm2.Canvas.Font.Color:=clWhite;
      bm2.Canvas.TextOut(xx+2,yy-15,'охрана');
      imgMain.Picture.Bitmap.Assign(bm2);
      imgMain.Picture.BitMap.Canvas.Brush.Style := bsClear; //что б фон не был белым, задаите стил кисти соответствуюшии
    finally
      bm2.Free;

    end;
  xx:=xx+1;
  yy:=yy+2;
  if xx>=f_image.Width then xx:=1;
  if yy>=f_image.Height then yy:=1;


end;
//------------------------------------------------------------------------------
procedure TfmMap.CheckBox1Click(Sender: TObject);
begin
 AsyncTimer1.Enabled:= CheckBox1.Checked;
end;
//------------------------------------------------------------------------------
procedure TfmMap.FormActivate(Sender: TObject);
begin
  ViewerMap.Align := alNone;
  ViewerMap.Width:=1;
  ViewerMap.Height:=1;
  //
  ViewerMap.Visible:=true;
  ViewerMap.Repaint;
  Application.ProcessMessages;
  ViewerMap.Align:=alClient;
end;
//------------------------------------------------------------------------------
procedure TfmMap.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AsyncTimer1.Enabled:=false;
  f_image.Picture:=nil;
  f_image.Destroy;
  f_image:=nil;
  Action:=caFree;
end;
procedure TfmMap.FormCreate(Sender: TObject);
begin
  f_image:=TImage.Create(nil);
  if FileExists('Object3D.jpg') then
    f_image.Picture.LoadFromFile('Object3D.jpg')
  else
    SHowMessage('Файл не найден! (Object3D.jpg)');

  f_image.Proportional:=true;
  f_bound[0]:=0;
  f_bound[1]:=0;
  f_bound[2]:=imgMain.Width;
  f_bound[3]:=imgMain.Height;
  f_multiplier:=0;
end;

//------------------------------------------------------------------------------
procedure TfmMap.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
//  cameraMain.AdjustDistanceToTarget(Power(1.1, WheelDelta/120));

  if WheelDelta>0 then
    f_multiplier:= f_multiplier - 10
  else
    f_multiplier:= f_multiplier + 10;

  if f_multiplier<0  then   f_multiplier:=0;
   

end;
procedure TfmMap.FormShow(Sender: TObject);
begin
 xx:=100;
 yy:=300;
{ CheckBox1.Checked:=true;
 CheckBox1Click(nil);
 }
end;

procedure TfmMap.imgMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  f_pick.X:=X;
  f_pick.Y:=Y;
end;

procedure TfmMap.Panel2Resize(Sender: TObject);
begin
  f_image.Width:= imgMain.Width;
  f_image.Height:= imgMain.Height;
  f_bound[0]:=0;
  f_bound[1]:=0;
  f_bound[2]:=imgMain.Width;
  f_bound[3]:=imgMain.Height;
end;

//------------------------------------------------------------------------------
procedure TfmMap.ViewerMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 // запоминание координат мыши при нажатии кнопок мыши
 mdx:=x; mdy:=y;
end;
//------------------------------------------------------------------------------
procedure TfmMap.ViewerMapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
	dx, dy : Integer;
	v : TVector;
        pick : TGLCustomSceneObject;


begin

 // calculate delta since last move or last mousedown
 dx:=mdx-x; dy:=mdy-y;
 mdx:=x; mdy:=y;
 if Shift=[ssRight] then
  begin
  // right button changes camera angle
  // (we're moving around the parent and target dummycube)
   cameraMain.MoveAroundTarget(dy, dx);
  end
   else if Shift=[ssLeft] then begin
   // left button moves our target and parent dummycube
    v:=cameraMain.ScreenDeltaToVectorXY(dx, -dy,
                0.12*cameraMain.DistanceToTarget/cameraMain.FocalLength);
    dcMainCameraContainer.Position.Translate(v);
    // notify camera that its position/target has been changed
    cameraMain.TransformationChanged;
   end;


end;

//------------------------------------------------------------------------------
end.
