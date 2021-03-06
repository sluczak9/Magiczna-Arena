unit u_MagicznaArena;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, shellapi, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Menus, Vcl.Imaging.pngimage, u_Arena, u_Statystyki,
  u_OProgramie,
  Data.DB,
  Data.Win.ADODB, Vcl.DBCtrls;

type
  TfrmMagicznaArena = class(TForm)
    grpbTworzeniaPostaci: TGroupBox;
    grpbKartaPostaci: TGroupBox;
    lblIdKlasy: TLabel;
    lblAtak: TLabel;
    lblObrona: TLabel;
    edtObrona: TEdit;
    imgAvatar: TImage;
    btnPrzeliczStat: TButton;
    btnZatwierdzStat: TButton;
    LabelZycie: TLabel;
    labelAtak: TLabel;
    labelObrona: TLabel;
    lblPktZycia: TLabel;
    lblPktAtaku: TLabel;
    lblPktObrony: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    edtAtak: TEdit;
    grpbZapisNaWalke: TGroupBox;
    btnPoka¿Statystyki: TButton;
    imgWrogow: TImage;
    rdgPoziomTrudnosci: TRadioGroup;
    grpbKartaWroga: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblPktZyciaWroga: TLabel;
    lblPktAtakuWroga: TLabel;
    lblPktObronyWroga: TLabel;
    imgWalcz: TImage;
    btnPrzeliczStatWroga: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Pomoc1: TMenuItem;
    Instrukcja1: TMenuItem;
    N2: TMenuItem;
    Oprogramie1: TMenuItem;
    ADOConDoStatystyk: TADOConnection;
    ADOTStatystyki: TADOTable;
    DataSource1: TDataSource;
    pnlPowitalny: TPanel;
    lblNazwaUzytkownika: TLabel;
    lblWitaj: TLabel;
    ADOQStatystyki: TADOQuery;
    btnWyloguj: TButton;
    ADOTKlasy: TADOTable;
    ADOTPrzeciwnicy: TADOTable;
    DataSourceKlasyStat: TDataSource;
    DataSourcePrzeciwnicyStat: TDataSource;
    DBcmbxKlasa: TDBLookupComboBox;
    DBcmbxListaWrogow: TDBLookupComboBox;
    procedure btnPrzeliczStatClick(Sender: TObject);
    procedure imgWalczClick(Sender: TObject);
    procedure btnPrzeliczStatWrogaClick(Sender: TObject);
    procedure btnPoka¿StatystykiClick(Sender: TObject);
    procedure btnZatwierdzStatClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Zapiszjako1Click(Sender: TObject);

    procedure Wczytajzapis1Click(Sender: TObject);
    procedure Oprogramie1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Instrukcja1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnWylogujClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBcmbxKlasaChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    // funkcje
    idUzytkownika: integer;

    // procedury
    procedure KontrolkiStart;
    procedure KontrolkiZatwierdzStat;
  end;

var
  frmMagicznaArena: TfrmMagicznaArena;

implementation

resourcestring
  strKomunikatZam = 'Czy na pewno chcesz opuciæ Magiczn¹ Arenê?';
  strKomunikatZatwierdzenia =
    'Czy chcesz zatwierdziæ klasê i jej statystyki? Po ich zatwierzeniu nie bêdzie mo¿liwa ich edycja';
{$R *.dfm}

procedure TfrmMagicznaArena.btnPoka¿StatystykiClick(Sender: TObject);
begin

  frmStatystyki.ShowModal;

end;

procedure TfrmMagicznaArena.btnPrzeliczStatClick(Sender: TObject);
var
  pktAtaku, pktObrony, pktZycia: double;
  BonusAtaku, zmAtak, BonusObrony, zmObrony, zycieZaBonusy: double;
begin

  with ADOQStatystyki do
  begin
    Close;
    SQL.Clear; // czyci piolecenie sql jeli istnieje
    SQL.Add('select * from TBL_Klasy where idKlasy=' +
      inttostr(DBcmbxKlasa.KeyValue));
    Open;
  end;
  // ShowMessage('Current directory = '+dir);
  imgAvatar.Picture := nil;
  if (DBcmbxKlasa.KeyValue = 1) then
  begin
    pktZycia := ADOQStatystyki.FieldByName('PktZycia').AsFloat;
    pktAtaku := ADOQStatystyki.FieldByName('PktAtaku').AsFloat;
    pktObrony := ADOQStatystyki.FieldByName('PktObrony').AsFloat;

    lblPktZycia.Caption := FloatToStr(pktZycia);
    imgAvatar.Picture.LoadFromFile('Grafika\Avatar\Mag.png');

  end
  else if (DBcmbxKlasa.KeyValue = 2) then
  begin
    pktZycia := ADOQStatystyki.FieldByName('PktZycia').AsFloat;
    pktAtaku := ADOQStatystyki.FieldByName('PktAtaku').AsFloat;
    pktObrony := ADOQStatystyki.FieldByName('PktObrony').AsFloat;

    lblPktZycia.Caption := FloatToStr(pktZycia);
    imgAvatar.Picture.LoadFromFile('Grafika\Avatar\Wojownik.png');
  end
  else if (DBcmbxKlasa.KeyValue = 3) then
  begin
    pktZycia := ADOQStatystyki.FieldByName('PktZycia').AsFloat;
    pktAtaku := ADOQStatystyki.FieldByName('PktAtaku').AsFloat;
    pktObrony := ADOQStatystyki.FieldByName('PktObrony').AsFloat;

    lblPktZycia.Caption := FloatToStr(pktZycia);
    imgAvatar.Picture.LoadFromFile('Grafika\Avatar\Lotrzyk.png');
  end
  else
  begin
    pktZycia := ADOQStatystyki.FieldByName('PktZycia').AsFloat;
    pktAtaku := ADOQStatystyki.FieldByName('PktAtaku').AsFloat;
    pktObrony := ADOQStatystyki.FieldByName('PktObrony').AsFloat;
    lblPktZycia.Caption := FloatToStr(pktZycia);
    imgAvatar.Picture.LoadFromFile('Grafika\Avatar\DlaNowychKlas.png');
  end;

  // Przeliczanie bonusu
  zmAtak := strtofloat(edtAtak.Text);
  zmObrony := strtofloat(edtObrona.Text);
  BonusAtaku := zmAtak * 4;
  BonusObrony := zmObrony * 2;
  zycieZaBonusy := zmAtak * 5 + zmObrony * 3;

  // Dodanie pkt do statystyk
  // pktAtaku := pktAtaku + StrToFloat(edtAtak.text);
  pktAtaku := pktAtaku + BonusAtaku;
  // pktObrony := pktObrony + StrToFloat(edtObrona.text);
  pktObrony := pktObrony + BonusObrony;
  pktZycia := pktZycia - zycieZaBonusy;

  // Przedstawienie statystyk
  lblPktAtaku.Caption := FloatToStr(pktAtaku);
  lblPktObrony.Caption := FloatToStr(pktObrony);
  lblPktZycia.Caption := FloatToStr(pktZycia);

  // Przes³anie statystyk
  frmArena.lblPktZycia.Caption := frmMagicznaArena.lblPktZycia.Caption;
  frmArena.lblPktAtaku.Caption := frmMagicznaArena.lblPktAtaku.Caption;
  frmArena.lblPktObrony.Caption := frmMagicznaArena.lblPktObrony.Caption;
  frmArena.imgAvatar.Picture := frmMagicznaArena.imgAvatar.Picture;
  // edtDelta.Text := FloatToStr(d)
  // cmbxKlasa.

  btnZatwierdzStat.Enabled := true;
end;

// Zatwierdzenie przeciwnika
procedure TfrmMagicznaArena.btnPrzeliczStatWrogaClick(Sender: TObject);
var
  pktAtakuW, pktObronyW, pktZyciaW: double;

begin
  imgWrogow.Picture := nil;

    with ADOQStatystyki do
  begin
    Close;
    SQL.Clear; // czyci piolecenie sql jeli istnieje
    SQL.Add('select * from TBL_Przeciwnicy where idPrzeciwnika=' +
      inttostr(DBcmbxListaWrogow.KeyValue));
    Open;
  end;

  //with ADOQStatystyki do
  //begin
    //Close;
    //SQL.Clear; // czyci piolecenie sql jeli istnieje
    //SQL.Add('select * from TBL_Przeciwnicy where idPrzeciwnika=' +
      //inttostr(DBcmbxKlasa.KeyValue));
    //Open;
  //end;

  if (DBcmbxListaWrogow.KeyValue = 1) then
  begin
    pktZyciaW := ADOQStatystyki.FieldByName('PktZyciaW').AsFloat;
    pktAtakuW := ADOQStatystyki.FieldByName('PktAtakuW').AsFloat;
    pktObronyW := ADOQStatystyki.FieldByName('PktObronyW').AsFloat;
    imgWrogow.Picture.LoadFromFile('Grafika\Wrog\Ork.png');
  end
  else if (DBcmbxListaWrogow.KeyValue = 2) then
  begin
    pktZyciaW := ADOQStatystyki.FieldByName('PktZyciaW').AsFloat;
    pktAtakuW := ADOQStatystyki.FieldByName('PktAtakuW').AsFloat;
    pktObronyW := ADOQStatystyki.FieldByName('PktObronyW').AsFloat;
    imgWrogow.Picture.LoadFromFile('Grafika\Wrog\Krasnolud.png');
  end
  else if (DBcmbxListaWrogow.KeyValue = 3) then
  begin
    pktZyciaW := ADOQStatystyki.FieldByName('PktZyciaW').AsFloat;
    pktAtakuW := ADOQStatystyki.FieldByName('PktAtakuW').AsFloat;
    pktObronyW := ADOQStatystyki.FieldByName('PktObronyW').AsFloat;
    imgWrogow.Picture.LoadFromFile('Grafika\Wrog\Smok.png');

  end
  else if (DBcmbxListaWrogow.KeyValue = 4) then
  begin
    pktZyciaW := ADOQStatystyki.FieldByName('PktZyciaW').AsFloat;
    pktAtakuW := ADOQStatystyki.FieldByName('PktAtakuW').AsFloat;
    pktObronyW := ADOQStatystyki.FieldByName('PktObronyW').AsFloat;
    imgWrogow.Picture.LoadFromFile('Grafika\Wrog\Wilkolak.png');

  end
  else if (DBcmbxListaWrogow.KeyValue = 5) then
  begin
    pktZyciaW := ADOQStatystyki.FieldByName('PktZyciaW').AsFloat;
    pktAtakuW := ADOQStatystyki.FieldByName('PktAtakuW').AsFloat;
    pktObronyW := ADOQStatystyki.FieldByName('PktObronyW').AsFloat;
    imgWrogow.Picture.LoadFromFile('Grafika\Wrog\Szkielet.png');
  end
  else
  begin
    pktZyciaW := ADOQStatystyki.FieldByName('PktZyciaW').AsFloat;
    pktAtakuW := ADOQStatystyki.FieldByName('PktAtakuW').AsFloat;
    pktObronyW := ADOQStatystyki.FieldByName('PktObronyW').AsFloat;

    //Wczytywanie obrazaka dla nowych wrogow
    imgWrogow.Picture.LoadFromFile('Grafika\Wrog\DlaNowychWrogow.png');
  end;

  // Przeliczniki poziomu trudnoci
  if (rdgPoziomTrudnosci.ItemIndex = 0) then
  begin
    lblPktZyciaWroga.Caption := FloatToStr(pktZyciaW + 0);
    lblPktAtakuWroga.Caption := FloatToStr(pktAtakuW + 0);
    lblPktObronyWroga.Caption := FloatToStr(pktObronyW + 0);
  end
  else if (rdgPoziomTrudnosci.ItemIndex = 1) then
  begin
    lblPktZyciaWroga.Caption := FloatToStr(pktZyciaW + 10);
    lblPktAtakuWroga.Caption := FloatToStr(pktAtakuW + 5);
    lblPktObronyWroga.Caption := FloatToStr(pktObronyW + 5);
  end
  else
  begin
    lblPktZyciaWroga.Caption := FloatToStr(pktZyciaW + 20);
    lblPktAtakuWroga.Caption := FloatToStr(pktAtakuW + 10);
    lblPktObronyWroga.Caption := FloatToStr(pktObronyW + 10);
  end;

  frmArena.lblPktZyciaWroga.Caption :=
    frmMagicznaArena.lblPktZyciaWroga.Caption;
  frmArena.lblPktAtakuWroga.Caption :=
    frmMagicznaArena.lblPktAtakuWroga.Caption;
  frmArena.lblPktObronyWroga.Caption :=
    frmMagicznaArena.lblPktObronyWroga.Caption;
  frmArena.imgWrogow.Picture := frmMagicznaArena.imgWrogow.Picture;

  imgWalcz.Visible := true;
  imgWalcz.Enabled := true;
end;

procedure TfrmMagicznaArena.btnWylogujClick(Sender: TObject);
var
  i: integer;
begin
  WinExec(PansiChar(application.exename), EWX_Force);
  //application.Terminate;
  Self.Close;
  application.Run;

end;

procedure TfrmMagicznaArena.btnZatwierdzStatClick(Sender: TObject);
var
  i: integer;
begin
  ADOTStatystyki.Active := true;
  i := MessageDlg(strKomunikatZatwierdzenia, mtInformation, mbYesNo, 0, mbNo);
  if i = mrYes then
  begin
    with ADOQStatystyki do
    begin
      Close;
      SQL.Clear; // czyci piolecenie sql jeli istnieje
      //SQL.Add('select * from TBL_Uzytkownicy where idUzytkownika=' +
        //inttostr(idUzytkownika));
        ADOQStatystyki.SQL.Add('UPDATE TBL_Uzytkownicy SET IdKlasy =' +
        inttostr(DBcmbxKlasa.KeyValue) +
        ' WHERE IdUzytkownika=' + inttostr(idUzytkownika) + ' ');
      ADOQStatystyki.ExecSQL;
      //Open;
    end;

    KontrolkiZatwierdzStat;
    btnZatwierdzStat.Enabled := false;

    begin
      //ADOQStatystyki.Append;
      // ADOQStatystyki['IdKlasy'] := DBcmbxKlasa.Items[0];
      //ADOQStatystyki['IdKlasy'] := inttostr(DBcmbxKlasa.KeyValue);
      //ADOQStatystyki['PktObrony'] := lblPktObrony.Caption;
      //ADOQStatystyki['PktAtaku'] := lblPktAtaku.Caption;
      //ADOQStatystyki['PktZycia'] := lblPktZycia.Caption;
      (*
        ADOQStatystyki['Wygrane'] :=
        u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption;
        ADOQStatystyki['Przegrane'] :=
        u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption;
      *)
      //ADOQStatystyki.Post;
    end;
    ShowMessage('Uda³o siê poprawnie wys³aæ dane na serwer');

  end
  else

end;

procedure TfrmMagicznaArena.Button1Click(Sender: TObject);
begin
  // ShowMessage(DBcmbxKlasa.Items[0] + '');
end;

procedure TfrmMagicznaArena.DBcmbxKlasaChange(Sender: TObject);
begin

end;

// Zakniêcie programu

procedure TfrmMagicznaArena.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  (* var
    wygrane, przegrane: Integer;
    begin

    wygrane := StrToInt(u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption);
    przegrane := StrToInt(u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption);
    ADOTStatystyki.Active := TRUE ;

    with ADOQStatystyki do
    begin
    Close;
    SQL.Clear; // czyci piolecenie sql jeli istnieje
    SQL.Add('select * from TBL_Statystyk where IdUzytkownika=' +
    IntToStr(idUzytkownika));
    Open;
    end;

    if ADOQStatystyki.RecordCount = 1 then
    begin
    with ADOConDoStatystyk do
    begin
    ADOQStatystyki.Close;
    ADOQStatystyki.SQL.Clear;
    ADOQStatystyki.SQL.Add('UPDATE TBL_Statystyk SET Wygrane =' + IntToStr(wygrane)
    + ',Przegrane = ' + IntToStr(przegrane)
    + ' WHERE IdUzytkownika=' + IntToStr(idUzytkownika) + ' ');
    ADOQStatystyki.ExecSQL;
    end;
    ShowMessage('Uda³o siê zaktualizowaæ zapis');
    end
    else
    begin
    ADOTStatystyki.Append;
    ADOTStatystyki['IdKlasy'] := cmbxKlasa.ItemIndex;
    ADOTStatystyki['IdUzytkownika'] := idUzytkownika;
    ADOTStatystyki['PktObrony'] := lblPktObrony.Caption;
    ADOTStatystyki['PktAtaku'] := lblPktAtaku.Caption;
    ADOTStatystyki['PktZycia'] := lblPktZycia.Caption;
    ADOTStatystyki['Wygrane'] :=  u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption;
    ADOTStatystyki['Przegrane'] := u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption;
    ADOTStatystyki.Post;
    ShowMessage('Uda³o siê poprawnie wys³aæ dane na serwer');
    end;
  *)
end;

procedure TfrmMagicznaArena.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);

var
  i: integer;
begin
  i := MessageDlg(strKomunikatZam, mtInformation, mbYesNo, 0, mbNo);
  if i = mrYes then
  begin
    u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption := '0';
    u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption := '0';
    imgAvatar.Picture.LoadFromFile('Grafika\BrakIkony.png');
    imgWalcz.Enabled := false;
    imgWalcz.Visible := false;
    imgWrogow.Picture.LoadFromFile('Grafika\BrakIkony.png');
    // DBcmbxKlasa.ItemIndex := 0;
    edtAtak.Text := '0';
    edtObrona.Text := '0';
    lblPktZycia.Caption := '0';
    lblPktObrony.Caption := '0';
    lblPktAtaku.Caption := '0';
    lblPktAtakuWroga.Caption := '0';
    lblPktZyciaWroga.Caption := '0';
    lblPktObronyWroga.Caption := '0';
    CanClose := true;
  end
  else if i = mrNo then
  begin
    CanClose := false;
    ShowMessage('Dobra decyzja!')
  end;
end;

procedure TfrmMagicznaArena.FormCreate(Sender: TObject);
begin

  // KontrolkiStart;
end;

// Przycisk walcz
procedure TfrmMagicznaArena.imgWalczClick(Sender: TObject);
var
  pktAtakuW, pktObronyW, pktZyciaW: double;
  pktAtaku, pktObrony, pktZycia: double;
begin
  // frmArena.lblPktZycia:= frmMagicznaArena.lblPktZycia;
  // Statystyki Gracza
  frmArena.lblPktZycia.Caption := frmMagicznaArena.lblPktZycia.Caption;
  frmArena.lblPktAtaku.Caption := frmMagicznaArena.lblPktAtaku.Caption;
  frmArena.lblPktObrony.Caption := frmMagicznaArena.lblPktObrony.Caption;
  frmArena.imgAvatar.Picture := frmMagicznaArena.imgAvatar.Picture;

  // statystyki Wroga
  frmArena.lblPktZyciaWroga.Caption :=
    frmMagicznaArena.lblPktZyciaWroga.Caption;
  frmArena.lblPktAtakuWroga.Caption :=
    frmMagicznaArena.lblPktAtakuWroga.Caption;
  frmArena.lblPktObronyWroga.Caption :=
    frmMagicznaArena.lblPktObronyWroga.Caption;
  frmArena.imgWrogow.Picture := frmMagicznaArena.imgWrogow.Picture;

  frmArena.lblPktObrazenGracz.Caption := '0';
  frmArena.lblPktObrazenWroga.Caption := '0';

  frmArena.imgKostka.Picture.LoadFromFile('Grafika\Kostka\KOSTKA DO GRY.png');
  frmArena.imgKostkaW.Picture.LoadFromFile
    ('Grafika\Kostka\KOSTKA DO GRY WROGA.png');

  // PRZEKAZANIE DO ARENYY
  // Przekzanie Id do Areny
  u_Arena.frmArena.idUzytkownika := idUzytkownika;
  u_Arena.frmArena.idPrzeciwnika := DBcmbxListaWrogow.KeyValue;

  frmArena.ShowModal;
end;

procedure TfrmMagicznaArena.Instrukcja1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'Pomoc\Pomoc.chm', nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMagicznaArena.KontrolkiStart;
begin

  grpbTworzeniaPostaci.Enabled := true;
  edtAtak.Enabled := true;
  edtObrona.Enabled := true;
  btnPrzeliczStat.Enabled := true;
  btnPoka¿Statystyki.Enabled := false;
  btnZatwierdzStat.Enabled := false;

  grpbZapisNaWalke.Enabled := false;
  DBcmbxListaWrogow.Enabled := false;
  rdgPoziomTrudnosci.Enabled := false;
  btnPrzeliczStatWroga.Enabled := false;
  imgWalcz.Enabled := false;
end;

procedure TfrmMagicznaArena.KontrolkiZatwierdzStat;
begin

  grpbTworzeniaPostaci.Enabled := false;
  edtAtak.Enabled := false;
  edtObrona.Enabled := false;
  btnPrzeliczStat.Enabled := false;
  btnPoka¿Statystyki.Enabled := true;

  grpbZapisNaWalke.Enabled := true;
  DBcmbxListaWrogow.Enabled := true;
  rdgPoziomTrudnosci.Enabled := true;
  btnPrzeliczStatWroga.Enabled := true;

end;

// Wywitlanie okna o programie
procedure TfrmMagicznaArena.Oprogramie1Click(Sender: TObject);
begin
  frmOProgramie.ShowModal;
end;

// Wczytanie danych
procedure TfrmMagicznaArena.Wczytajzapis1Click(Sender: TObject);
var
  plik: TextFile;
  Staty: TStringlist;
begin
  if OpenDialog1.Execute then
    if FileExists(OpenDialog1.FileName) = false then
      ShowMessage('Plik o takiej nazwie nie istnieje')
    else
    begin

      Staty := TStringlist.Create;
      try
        // Staty.LoadFromFile('Zapisy\statystyki.txt',TEncoding.UTF8);
        Staty.LoadFromFile(OpenDialog1.FileName, TEncoding.UTF8);
        // Staty.LoadFromFile(StrToInt(cmbxKlasa.ItemIndex));
        // ------poprawic
        // DBcmbxKlasa.ItemIndex := StrToInt(Staty[0]);
        lblPktZycia.Caption := Staty[1];
        lblPktAtaku.Caption := Staty[2];
        lblPktObrony.Caption := Staty[3];
        edtAtak.Text := Staty[4];
        edtObrona.Text := Staty[5];
        u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption := Staty[6];
        u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption := Staty[7];
        ShowMessage('Odczyt pliku wykonano prawidlowo');
        CloseFile(plik);
        // finally
      except
      end;

      // Od/blokowanie przycisków
      KontrolkiZatwierdzStat;

      // wczytanie obrazka avatara
      if (strtoint(DBcmbxKlasa.KeyField) = 1) then
      begin
        imgAvatar.Picture.LoadFromFile('Grafika\Avatar\Mag.png');
      end
      else if (strtoint(DBcmbxKlasa.KeyField) = 1) then
      begin
        imgAvatar.Picture.LoadFromFile('Grafika\Avatar\Wojownik.png');
      end
      else if (strtoint(DBcmbxKlasa.KeyField) = 1) then
      begin
        imgAvatar.Picture.LoadFromFile('Grafika\Avatar\Lotrzyk.png');
      end
      else
      begin
        imgAvatar.Picture.LoadFromFile('Grafika\Avatar\DlaNowychKlas.png');
      end;
    end;

  // Staty.Free;

end;

// Zapis do pliku
procedure TfrmMagicznaArena.Zapiszjako1Click(Sender: TObject);
// PRÓBA ZAPISU DO BAZY
var
  wygrane, przegrane: integer;
begin

  wygrane := strtoint(u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption);
  przegrane := strtoint
    (u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption);
  ADOTStatystyki.Active := true;

  with ADOQStatystyki do
  begin
    Close;
    SQL.Clear; // czyci piolecenie sql jeli istnieje
    SQL.Add('select * from TBL_Statystyk where IdUzytkownika=' +
      inttostr(idUzytkownika));
    Open;
  end;

  if ADOQStatystyki.RecordCount = 1 then
  begin
    with ADOConDoStatystyk do
    begin
      ADOQStatystyki.Close;
      ADOQStatystyki.SQL.Clear;
      ADOQStatystyki.SQL.Add('UPDATE TBL_Statystyk SET Wygrane =' +
        inttostr(wygrane) + ',Przegrane = ' + inttostr(przegrane) +
        ' WHERE IdUzytkownika=' + inttostr(idUzytkownika) + ' ');
      ADOQStatystyki.ExecSQL;
    end;
    ShowMessage('Uda³o siê zaktualizowaæ zapis');
  end
  else
  begin
    ADOTStatystyki.Append;
    // ADOTStatystyki['IdKlasy'] := DBcmbxKlasa.ItemIndex;
    ADOTStatystyki['IdUzytkownika'] := idUzytkownika;
    ADOTStatystyki['PktObrony'] := lblPktObrony.Caption;
    ADOTStatystyki['PktAtaku'] := lblPktAtaku.Caption;
    ADOTStatystyki['PktZycia'] := lblPktZycia.Caption;
    ADOTStatystyki['Wygrane'] :=
      u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption;
    ADOTStatystyki['Przegrane'] :=
      u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption;
    ADOTStatystyki.Post;
    ShowMessage('Uda³o siê poprawnie wys³aæ dane na serwer');
  end;

end;

end.
