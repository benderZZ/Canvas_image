program Project2;

uses
  Forms,
  ufrmMap in 'ufrmMap.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMap, fmMap);
  Application.Run;
end.
