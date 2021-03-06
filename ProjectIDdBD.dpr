program ProjectIDdBD;

uses
  Vcl.Forms,
  MagicznaArenaIDdBD in 'MagicznaArenaIDdBD.pas' {LoginRejestracja},
  u_MagicznaArena in 'u_MagicznaArena.pas' {frmMagicznaArena},
  u_Arena in 'u_Arena.pas' {frmArena},
  u_OProgramie in 'u_OProgramie.pas' {frmOProgramie},
  u_Statystyki in 'u_Statystyki.pas' {frmStatystyki},
  u_SplashScreen in 'u_SplashScreen.pas' {frmSplashScreen},
  SysUtils,
  u_PanelAdministratora in 'u_PanelAdministratora.pas' {frmPanelAdministratora};

{$R *.res}

begin
  Application.Initialize;

  with u_SplashScreen.TfrmSplashScreen.Create(nil) do
    try
      Application.MainFormOnTaskBar := true;
      prgb.Max := 100;
      Show;
      Update;

      prgb.StepBy(10);
      lblinfo.Caption := 'Sprz?tanie areny';
      Update;
      Sleep(500);

      prgb.StepBy(25);
      lblinfo.Caption := 'Sprzedawanie bilet?w';
      Update;
      Sleep(500);

      prgb.StepBy(45);
      lblinfo.Caption := 'Czyszczenie broni';
      Update;
      Sleep(500);

      Application.CreateForm(TLoginRejestracja, LoginRejestracja);
  Application.CreateForm(TfrmMagicznaArena, frmMagicznaArena);
  Application.CreateForm(TfrmArena, frmArena);
  Application.CreateForm(TfrmOProgramie, frmOProgramie);
  Application.CreateForm(TfrmStatystyki, frmStatystyki);
  Application.CreateForm(TfrmSplashScreen, frmSplashScreen);
  Application.CreateForm(TfrmPanelAdministratora, frmPanelAdministratora);
  prgb.StepBy(20);
      lblinfo.Caption := 'Ostanie przygotowania';
      Update;
      Sleep(500);

    finally
      Free;
    end;

  Application.MainFormOnTaskBar := true;
  Application.Run;

end.
