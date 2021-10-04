program MP3Rec;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  Bass in 'BASS\Core\Bass.pas',
  BassEnc in 'BASS\Add-ons\BassEnc.pas',
  BassEnc_MP3 in 'BASS\Add-ons\BassEnc_MP3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
