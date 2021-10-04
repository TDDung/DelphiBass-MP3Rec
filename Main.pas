{
TDDung - Vietnam, Oct 2021
}

unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Rectangle1: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses StrUtils, Bass, BassEnc, BassEnc_MP3;

var
  Channel: HRECORD;
  FilePath: string;

function RecordingCallback(Handle: HRECORD; buffer: Pointer; length: DWORD; user: Pointer): boolean; stdcall;
begin
	Result := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF ANDROID}
  if PermissionsService.IsPermissionGranted('android.permission.RECORD_AUDIO') then
    Button1.Enabled:= True
  else
    PermissionsService.RequestPermissions(['android.permission.RECORD_AUDIO'],
      procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
      begin
        if Length(AGrantResults) = 1 then
          case AGrantResults[0] of
            TPermissionStatus.Granted: Button1.Enabled:= True;
            TPermissionStatus.Denied:
              TDialogService.ShowMessage('Cannot record audio without the relevant permission being granted');
            TPermissionStatus.PermanentlyDenied:
              TDialogService.ShowMessage('If you decide you wish to use the audio recording feature of this app, please go to app settings and enable the microphone permission');
          end
        else
          TDialogService.ShowMessage('Something went wrong with the permission checking');
      end,
      procedure(const APermissions: TArray<string>; const APostRationaleProc: TProc)
      begin
        TDialogService.ShowMessage('We first need to be given permission to record audio with your device',
          procedure(const AResult: TModalResult)
          begin
            APostRationaleProc;
          end);
      end);
  {$ELSE}
  Button1.Enabled:= True;
  {$ENDIF}

  FilePath:= '';
  {$IF DEFINED(ANDROID) OR DEFINED(MACOS)}
  FilePath:= IncludeTrailingPathDelimiter(TPath.GetPublicPath);
  {$ENDIF}
  {$IF DEFINED(IOS)}
  FilePath:= IncludeTrailingPathDelimiter(TPath.GetHomePath) + 'Documents/';
  {$ENDIF}
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
	BASS_RecordFree;
	BASS_Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Enabled:= False;
  if BASS_IsAvailable and BassEncMP3_IsAvailable then
    Rectangle1.Enabled:= True
  else
    Button1.Text:= 'FAILED';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Button2.Enabled:= False;
  if not BASS_RecordInit(-1) then
    ShowMessage('Cannot start default recording device!')
  else
  begin
    Channel:= BASS_RecordStart(44100, 2, 0, @RecordingCallback, nil);
    if Channel = 0 then
      ShowMessage('Couldn''t start recording!')
    else
    begin
      BASS_Encode_MP3_StartFile(Channel, '', BASS_ENCODE_AUTOFREE or BASS_UNICODE, PChar(FilePath + 'MP3Rec.mp3'));
      Button3.Enabled:= True;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  BASS_ChannelStop(Channel);
  BASS_RecordFree;
  Button3.Enabled:= False;
  Button2.Enabled:= True;
end;

end.
