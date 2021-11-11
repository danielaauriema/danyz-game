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

unit Monstros;

interface

uses
  Windows, SysUtils, Classes, DxUtils, jpeg, ImgList, Controls, ExtCtrls,
  Menus, Forms, Dises, Graphics;

type
  TdmMonstros = class(TDataModule)
    smMonstro: TDxSpriteManager;
    smBuble: TDxSpriteManager;
    skMonstro: TDxSkin;
    skBuble: TDxSkin;
    procedure smMonstroLoad(Sender: TDxCustomSprite);
    procedure smMonstroExecute(Sender: TDxSprite);
    procedure smMonstroDefaultExecute(Sender: TDxCustomSprite);
    procedure smMonstroFireTerminate(Sender: TDxCustomSprite);
    procedure smMonstroDeadStart(Sender: TDxCustomSprite);
    procedure smMonstroDeadTerminate(Sender: TDxCustomSprite);
    procedure smMonstrosmMegaColision(Sender, Sprite: TDxSprite;
      const R: TRect);
    procedure smMonstrosmFireColision(Sender, Sprite: TDxSprite;
      const R: TRect);
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  dmMonstros: TdmMonstros;
const
  ACT_DEFAULT = 0;
  ACT_FIRE    = 1;
  ACT_DEAD    = 2;

implementation
uses Game01, Megaman, DxAI;

{$R *.dfm}

procedure TdmMonstros.smMonstroLoad(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
    Accel.ValueY:= 600;
end;

procedure TdmMonstros.smMonstroExecute(Sender: TDxSprite);
begin
  WatchMirrors (Sender as TDxSprite, dmMegaman.sMega, True, False);
end;

procedure TdmMonstros.smMonstroDefaultExecute(Sender: TDxCustomSprite);
begin
  if Random (50) = 1 then
    with Sender as TDxSprite do
      LoadAction (ACT_FIRE);
end;

procedure TdmMonstros.smMonstroFireTerminate(Sender: TDxCustomSprite);
var
  Fire: TDxSprite;
begin
  Fire:= TDxSprite.Create (Self, smBuble, skBuble);
  Fire.VeloX:= 200;
  AddRectSprite(Sender as TDxSprite, Fire, 30, -4);
  TDxSprite (Sender).LoadAction (ACT_DEFAULT);
end;

procedure TdmMonstros.smMonstroDeadStart(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
  begin
    Enabled:= False;
    Y:= Y + 5;
  end;
end;

procedure TdmMonstros.smMonstroDeadTerminate(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
    Kill;
end;

procedure TdmMonstros.smMonstrosmMegaColision(Sender, Sprite: TDxSprite;
  const R: TRect);
begin
  dmMegaman.SpriteDamage(Sprite, 1);
end;

procedure TdmMonstros.smMonstrosmFireColision(Sender, Sprite: TDxSprite;
  const R: TRect);
begin
  if Sender.Action.Index <> ACT_DEAD then
    Sender.LoadAction (ACT_DEAD);
end;

procedure TdmMonstros.DataModuleCreate(Sender: TObject);
begin
  skMonstro.Load;
  skBuble.Load;
end;

end.
