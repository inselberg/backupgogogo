program backupgogogo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'backupgogogo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
