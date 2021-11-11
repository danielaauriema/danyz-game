object frmConfig: TfrmConfig
  Left = 483
  Top = 244
  BorderStyle = bsSingle
  Caption = 'DEMO DANYZ 1.0b   ---> by Dany Star'
  ClientHeight = 369
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 394
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 104
      Top = 8
      Width = 81
      Height = 25
      Caption = '&Close'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      ModalResult = 3
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 394
    Height = 49
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 34
      Height = 13
      Caption = 'Input:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbInput: TComboBox
      Left = 56
      Top = 16
      Width = 281
      Height = 19
      Style = csOwnerDrawFixed
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbInputChange
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 49
    Width = 394
    Height = 279
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Demo Danyz 1.0 Beta - Dises Game Engine'
      '2008 by Daniela Auriema'
      ''
      'This program is free software: you can redistribute it '
      'and/or modify it under the terms of the GNU General '
      'Public License as published by the Free Software '
      'Foundation, either version 3 of the License, or any later '
      'version.'
      ''
      'This program is distributed in the hope that it will be '
      'useful, but WITHOUT ANY WARRANTY; without even the '
      'implied warranty of MERCHANTABILITY or FITNESS FOR '
      'A PARTICULAR PURPOSE. See the GNU General Public '
      'License for more details. (www.gnu.org)'
      ''
      '========================================='
      'Danyz'
      'contato@danyz.com'
      'www.danyz.com'
      '========================================='
      ''
      'Objetivo do Jogo:'
      'Matar todos os aliens.'
      ''
      '========================================='
      ''
      'COMANDOS'
      ''
      'ESC/ENTER: Menu'
      ''
      'Keyboard:'
      'Seta Direita: Move para a direita'
      'Seta Esquerda: Move para a esquerda'
      'Tecla A: Salta'
      'Tecla S: Disparo'
      ''
      'Joystick:'
      'Axis 1: Movimenta para Direita/Esquerda'
      'Botao 1: Salta'
      'Botao 2: Disparo'
      ''
      '========================================='
      ''
      'Jogo desenvolvido em Delphi 6'
      'CPU de teste:'
      '  AMD Athlon XP 1700+ (1.47Ghz)'
      '  256MB de RAM'
      '  M'#233'dia de 66 fps'
      ''
      '========================================='
      'https://github.com/danielaauriema/Danyz10b'
      '=========================================')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
