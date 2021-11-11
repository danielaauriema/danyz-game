{ ********************************************************************** }
{  DEMO 1.0b - Dises Game Engine 2008 by Daniela Auriema                 }
{                                                                        }
{  This program is free software: you can redistribute it and/or modify  }
{  it under the terms of the GNU General Public License as published by  }
{  the Free Software Foundation, either version 3 of the License, or     }
{  any later version.                                                    }
{                                                                        }
{  This program is distributed in the hope that it will be useful,       }
{  but WITHOUT ANY WARRANTY; without even the implied warranty of        }
{  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          }
{   GNU General Public License for more details. (www.gnu.org)           }
{                                                                        }
{  https://github.com/danielaauriema/Danyz10b                            }
{                                                                        }
{ ********************************************************************** }

unit Config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MMSystem, ComCtrls, Buttons, ExtCtrls;

type
  TfrmConfig = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    cbInput: TComboBox;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cbInputChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

const
  DevErr = 'Device Error';

procedure TfrmConfig.FormCreate(Sender: TObject);

  procedure InternalLoad;
  var
    i: Integer;
    c: cardinal;
    JoyCaps: TJoyCaps;
  begin
    { Carrega Inputbox }
    cbInput.Items.Clear; 
    cbInput.Items.Add ('Keyboard');
    c:= joyGetNumDevs;
    for i:= 0 to c - 1 do
    if joyGetDevCaps (i, @JoyCaps, SizeOf (JoyCaps)) = JOYERR_NOERROR then
      cbInput.Items.Add ('Joy ' + IntToStr (i) + ' - ' + JoyCaps.szPname);
    cbInput.ItemIndex:= 0;
  end;

begin
  InternalLoad;
  if cbInput.Items.Count = 1 then
    InternalLoad;
end;

procedure TfrmConfig.cbInputChange(Sender: TObject);
begin
  if cbInput.Items [cbInput.ItemIndex] = devErr then
    cbInput.ItemIndex:= 0;
end;

end.
