unit MagicznaArenaIDdBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, u_MagicznaArena,
  u_PanelAdministratora,
  u_Statystyki;

type
  TLoginRejestracja = class(TForm)
    PageControl1: TPageControl;
    Rejestracja: TTabSheet;
    Logowanie: TTabSheet;
    Login: TLabel;
    Has?o: TLabel;
    lblEmail: TLabel;
    edtLoginR: TEdit;
    chkbxPokazHasloR: TCheckBox;
    edtEmailR: TEdit;
    lblLogin: TLabel;
    BtnRejestracja: TButton;
    edtLoginL: TEdit;
    lblHasloL: TLabel;
    edtHasloL: TEdit;
    btnZaloguj: TButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ChkbxPokazHasloL: TCheckBox;
    edtHasloR: TEdit;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    ADOTStatystyki: TADOTable;
    ADOQStatystyki: TADOQuery;
    ADOTable2: TADOTable;
    procedure btnZalogujClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkbxPokazHasloRClick(Sender: TObject);
    procedure ChkbxPokazHasloLClick(Sender: TObject);
    procedure BtnRejestracjaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginRejestracja: TLoginRejestracja;

implementation

{$R *.dfm}

// rejestracja
procedure TLoginRejestracja.BtnRejestracjaClick(Sender: TObject);
begin
  ADOTable1.Active := TRUE;

  with ADOQuery1 do
  begin
    Close;
    SQL.Clear; // czy?ci piolecenie sql je?li istnieje
    SQL.Add('select * from TBL_Uzytkownicy where Login=' +
      QuotedStr(edtLoginR.Text));
    Open;
  end;

  if ADOQuery1.RecordCount = 1 then
  begin
    Application.MessageBox('Podany login ju? istnieje, zmie? nazw?', 'Error',
      MB_OK or MB_ICONERROR)
  end
  else
  begin
    ADOTable1.Append;
    ADOTable1['Login'] := edtLoginR.Text;
    ADOTable1['Haslo'] := edtHasloR.Text;
    ADOTable1['Email'] := edtEmailR.Text;
    ADOTable1['CzyAdmin'] := 0;

    ADOTable1.Post;

    edtLoginR.Text := '';
    edtHasloR.Text := '';
    edtEmailR.Text := '';

    ShowMessage('Uda?o si? poprawnie utworzy? konto');
  end;

end;

// logowanie
procedure TLoginRejestracja.btnZalogujClick(Sender: TObject);
begin
  with ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from TBL_Uzytkownicy where Login=' +
      QuotedStr(edtLoginL.Text));
    Open;
  end;

  if ADOQuery1.RecordCount = 0 then
    Application.MessageBox('Z?y login!', 'Information',
      MB_OK or MB_ICONINFORMATION)
  else
  begin
    if ADOQuery1.FieldByName('Haslo').AsString <> edtHasloL.Text then
    begin
      Application.MessageBox
        ('Podany login i has?o s? niepoprawne, sprawd? je jeszcze raz', 'Error',
        MB_OK or MB_ICONERROR);
    end

    else if ADOQuery1.FieldByName('CzyAdmin').AsBoolean = TRUE then
    begin
      u_PanelAdministratora.frmPanelAdministratora.Show;
      Hide;
    end
    else
    begin
      u_MagicznaArena.frmMagicznaArena.Show;
      Hide;
      u_MagicznaArena.frmMagicznaArena.idUzytkownika :=
        ADOQuery1.FieldByName('IdUzytkownika').AsInteger; // lblNazwaUzytkownika

      u_MagicznaArena.frmMagicznaArena.lblNazwaUzytkownika.Caption :=
        ADOQuery1.FieldByName('Login').AsString;

      // Przekazanie Id do u_Statystyki
      u_Statystyki.frmStatystyki.idUzytkownika :=
        ADOQuery1.FieldByName('IdUzytkownika').AsInteger;

      // -------------------------------------------------
      ADOTStatystyki.Active := TRUE;

      with ADOQStatystyki do
      begin
        Close;
        SQL.Clear; // czy?ci piolecenie sql je?li istnieje
        // SQL.Add('select * from TBL_Statystyk as s, TBL_Uzytkownicy as u where s.IdUzytkownika = u.IdUzytkownika and u.IdUzytkownika=' +
        // IntToStr(u_MagicznaArena.frmMagicznaArena.idUzytkownika));
        SQL.Add('select u.IdUzytkownika, k.IdKlasy, k.PktZycia, k.PktAtaku, k.PktObrony,s.Wygrane, s.Przegrane from TBL_Uzytkownicy as u '
          + 'inner join TBL_Statystyk as s on s.IdUzytkownika=u.IdUzytkownika '
          + 'inner join TBL_Klasy as k on u.IdKlasy=k.IdKlasy ' +
          'where u.IdUzytkownika = ' +
          IntToStr(u_MagicznaArena.frmMagicznaArena.idUzytkownika));
        Open;
      end;
      // ShowMessage(ADOQStatystyki.FieldByName('PktAtaku').ToString);
      if ADOQStatystyki.RecordCount = 1 then
      begin

        u_MagicznaArena.frmMagicznaArena.KontrolkiZatwierdzStat;
        u_MagicznaArena.frmMagicznaArena.btnZatwierdzStat.Enabled := false;
        // Pobiera z bazy statystyki i historie, jednak nie wrzuca ich do programu
        // ADOQStatystyki.Append;
        u_MagicznaArena.frmMagicznaArena.DBcmbxKlasa.KeyValue :=
          ADOQStatystyki.FieldByName('IdKlasy').AsInteger;
        u_MagicznaArena.frmMagicznaArena.idUzytkownika :=
          ADOQStatystyki.FieldByName('IdUzytkownika').AsInteger;
        u_MagicznaArena.frmMagicznaArena.lblPktObrony.Caption :=
          ADOQStatystyki.FieldByName('PktObrony').AsString;
        u_MagicznaArena.frmMagicznaArena.lblPktAtaku.Caption :=
          ADOQStatystyki.FieldByName('PktAtaku').AsString;
        u_MagicznaArena.frmMagicznaArena.lblPktZycia.Caption :=
          ADOQStatystyki.FieldByName('PktZycia').AsString;
        u_Statystyki.frmStatystyki.lblLiczbaWygranych.Caption :=
          ADOQStatystyki.FieldByName('Wygrane').AsString;
        u_Statystyki.frmStatystyki.lblLiczbaPrzegranych.Caption :=
          ADOQStatystyki.FieldByName('Przegrane').AsString;
        // ADOQStatystyki.Exec.SQL;

        // wczytanie obrazka avatara
        if (u_MagicznaArena.frmMagicznaArena.DBcmbxKlasa.KeyValue = 1) then
        begin
          u_MagicznaArena.frmMagicznaArena.imgAvatar.Picture.LoadFromFile
            ('Grafika\Avatar\Mag.png');
        end
        else if (u_MagicznaArena.frmMagicznaArena.DBcmbxKlasa.KeyValue = 2) then
        begin
          u_MagicznaArena.frmMagicznaArena.imgAvatar.Picture.LoadFromFile
            ('Grafika\Avatar\Wojownik.png');
        end
        else if (u_MagicznaArena.frmMagicznaArena.DBcmbxKlasa.KeyValue = 3) then
        begin
          u_MagicznaArena.frmMagicznaArena.imgAvatar.Picture.LoadFromFile
            ('Grafika\Avatar\Lotrzyk.png');
        end
        else
        begin
          u_MagicznaArena.frmMagicznaArena.imgAvatar.Picture.LoadFromFile
            ('Grafika\Avatar\DlaNowychKlas.png');
        end;

        ShowMessage('Dane wczytane');

      end
      else
      begin
        u_MagicznaArena.frmMagicznaArena.KontrolkiStart;
      end;

      // "refresh tabeli"
      u_MagicznaArena.frmMagicznaArena.DBcmbxListaWrogow.ListSource.
        DataSet.Close;
      u_MagicznaArena.frmMagicznaArena.DBcmbxListaWrogow.ListSource.
        DataSet.Open;
    end
  end;

  // u_MagicznaArena.frmMagicznaArena.OnCreate(Sender);

end;

procedure TLoginRejestracja.ChkbxPokazHasloLClick(Sender: TObject);
begin
  if ChkbxPokazHasloL.Checked then
  begin
    edtHasloL.PasswordChar := #0
  end
  else
  begin
    edtHasloL.PasswordChar := '*'
  end;
end;

// Pokaz haslo
procedure TLoginRejestracja.chkbxPokazHasloRClick(Sender: TObject);
begin

  if chkbxPokazHasloR.Checked then
  begin
    edtHasloR.PasswordChar := #0
  end
  else
  begin
    edtHasloR.PasswordChar := '*'
  end;

end;

// Modu? rejestracji
procedure TLoginRejestracja.FormCreate(Sender: TObject);
var
  s: Char;
  dbaddress: WideString;
begin

  begin
    s := '*';
    edtLoginL.Text := '';
    edtHasloL.PasswordChar := s;
    edtHasloL.Text := '';
    dbaddress := ExtractFilePath(Application.ExeName) + 'data.mdb';
    with ADOConnection1 do
    begin
      Connected := false;
      LoginPrompt := false;
      Mode := cmShareDenyNone;
      // ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + alamatdb + ';Persist Security Info=False';
    end;
    ADOConnection1.Connected := TRUE;
  end;
end;

end.
