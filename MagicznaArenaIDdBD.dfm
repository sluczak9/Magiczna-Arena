﻿object LoginRejestracja: TLoginRejestracja
  Left = 0
  Top = 0
  Caption = 'LoginRejestracja'
  ClientHeight = 370
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 372
    Height = 370
    ActivePage = Logowanie
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Rejestracja: TTabSheet
      Caption = 'Rejestracja'
      object Login: TLabel
        Left = 16
        Top = 24
        Width = 33
        Height = 18
        Caption = 'Login'
      end
      object Hasło: TLabel
        Left = 16
        Top = 106
        Width = 37
        Height = 18
        Caption = 'Has'#322'o'
      end
      object lblEmail: TLabel
        Left = 15
        Top = 192
        Width = 33
        Height = 18
        Caption = 'Email'
      end
      object edtLoginR: TEdit
        Left = 15
        Top = 53
        Width = 337
        Height = 26
        TabOrder = 0
      end
      object edtHasloR: TEdit
        Left = 16
        Top = 140
        Width = 337
        Height = 26
        PasswordChar = '*'
        TabOrder = 1
      end
      object chkbxPokazHasloR: TCheckBox
        Left = 240
        Top = 172
        Width = 129
        Height = 25
        Caption = 'Poka'#380' haslo'
        TabOrder = 2
        OnClick = chkbxPokazHasloRClick
      end
      object edtEmailR: TEdit
        Left = 15
        Top = 221
        Width = 337
        Height = 26
        TabOrder = 3
        Text = 'email@email.com'
      end
      object BtnRejestracja: TButton
        Left = 0
        Top = 264
        Width = 364
        Height = 73
        Align = alBottom
        Caption = 'Zarejestruj si'#281
        TabOrder = 4
        OnClick = BtnRejestracjaClick
      end
    end
    object Logowanie: TTabSheet
      Caption = 'Logowanie'
      ImageIndex = 1
      object lblLogin: TLabel
        Left = 16
        Top = 24
        Width = 33
        Height = 18
        Caption = 'Login'
      end
      object lblHasloL: TLabel
        Left = 16
        Top = 112
        Width = 35
        Height = 18
        Caption = 'Haslo'
      end
      object edtLoginL: TEdit
        Left = 16
        Top = 53
        Width = 337
        Height = 26
        TabOrder = 0
      end
      object edtHasloL: TEdit
        Left = 16
        Top = 141
        Width = 337
        Height = 26
        TabOrder = 1
      end
      object btnZaloguj: TButton
        Left = 0
        Top = 264
        Width = 364
        Height = 73
        Align = alBottom
        Caption = 'Zaloguj si'#281
        TabOrder = 2
        OnClick = btnZalogujClick
      end
      object ChkbxPokazHasloL: TCheckBox
        Left = 241
        Top = 173
        Width = 96
        Height = 19
        Caption = 'Poka'#380' haslo'
        TabOrder = 3
        OnClick = ChkbxPokazHasloLClick
      end
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=MagicznaArenaDB;Data Source' +
      '="";Initial File Name="";Server SPN=DESKTOP-BEHPBA2'
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    Left = 172
    Top = 10
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 280
  end
  object ADOTable1: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'TBL_Uzytkownicy'
    Left = 228
    Top = 5
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 340
    Top = 5
  end
  object ADOTStatystyki: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'TBL_Statystyk'
    Left = 308
    Top = 125
  end
  object ADOQStatystyki: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 204
    Top = 125
  end
  object ADOTable2: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'TBL_Historia'
    Left = 52
    Top = 245
  end
end
