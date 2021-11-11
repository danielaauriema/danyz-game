{ ********************************************************************** }
{  Game 01 - DEMO Dises Game Engine 2008 by Daniela Auriema              }
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

unit Megaman;

interface

uses
  Windows, SysUtils, Classes, DxUtils, jpeg, ImgList, Controls, ExtCtrls,
  Menus, Forms, Dises, Graphics;

type

  TdmMegaman = class(TDataModule)
    smMega: TDxSpriteManager;
    smFire: TDxSpriteManager;
    fxFire: TDxAudio;
    sMega: TDxSprite;
    skMega: TDxSkin;
    skFire: TDxSkin;
    smExplode: TDxSpriteManager;
    fxDead: TDxAudio;
    fxDamage: TDxAudio;
    procedure smMegaKeyDown(Sender: TDxSprite; Key: TDxKey;
      KeySet: TDxKeySet);
    procedure smMegaKeyUp(Sender: TDxSprite; Key: TDxKey;
      KeySet: TDxKeySet);
    procedure smMegaSpriteClip(Sender: TDxSprite);
    procedure smMegaLoad(Sender: TDxCustomSprite);
    procedure smMegaDefaultKeyDown(Sender: TDxSprite; const Key: TDxKey;
      const KeySet: TDxKeySet);
    procedure smMegaDefaultExecute(Sender: TDxCustomSprite);
    procedure smMegaDefaultStart(Sender: TDxCustomSprite);
    procedure smMegaRunExecute(Sender: TDxCustomSprite);
    procedure smMegaRunKeyDown(Sender: TDxSprite; const Key: TDxKey;
      const KeySet: TDxKeySet);
    procedure smMegaFireTerminate(Sender: TDxCustomSprite);
    procedure smMegaFireKeyDown(Sender: TDxSprite; const Key: TDxKey;
      const KeySet: TDxKeySet);
    procedure smMegaJumpUpStart(Sender: TDxCustomSprite);
    procedure smMegaJumpUpKeyDown(Sender: TDxSprite; const Key: TDxKey;
      const KeySet: TDxKeySet);
    procedure smMegaJumpColision(out ColisionResult: TDxColisionResult;
      Sender: TDxSprite; const Info: TDxColisionData);
    procedure smMegaJumpExecute(Sender: TDxCustomSprite);
    procedure smMegaJumpKeyDown(Sender: TDxSprite; const Key: TDxKey;
      const KeySet: TDxKeySet);
    procedure smMegaJumpDwKeyDown(Sender: TDxSprite; const Key: TDxKey;
      const KeySet: TDxKeySet);
    procedure smMegaFireRunTerminate(Sender: TDxCustomSprite);
    procedure smMegaJumpUpTerminate(Sender: TDxCustomSprite);
    procedure smMegaFireJumpTerminate(Sender: TDxCustomSprite);
    procedure smMegaFireDwTerminate(Sender: TDxCustomSprite);
    procedure smMegaDeadStart(Sender: TDxCustomSprite);
    procedure smMegaDeadTerminate(Sender: TDxCustomSprite);
    procedure smExplodeDefaultTerminate(Sender: TDxCustomSprite);
    procedure smMegaDamageExecute(Sender: TDxCustomSprite);
    procedure smMegaDamageStart(Sender: TDxCustomSprite);
    procedure smMegaDamageTerminate(Sender: TDxCustomSprite);
    procedure DataModuleCreate(Sender: TObject);
    procedure smMegaExecute(Sender: TDxSprite);
  private
    procedure CheckVeloX (Sender: TDxSprite);
    procedure Explode (ASprite: TDxSprite);
    function CheckJump (Sender: TDxSprite): Boolean;
    function CheckFall (Sender: TDxSprite): Boolean;
    procedure SimpleFire(Sender: TDxCustomSprite);
  public
    Life: Byte;
    procedure SpriteDamage (Sprite: TDxSprite; const Value: Byte);
  end;

var
  dmMegaman: TdmMegaman;

const
  MaxLife = 3;
  DefAccel = 600;
  ExpVeloc = 300;
  Fire4Veloc = 300;

  kJump = kBtnC;
  kFire = kBtnD;


  ACT_DEFAULT = 00;
  ACT_RUN     = 01;
  ACT_JUMPUP  = 02;
  ACT_JUMP    = 03;
  ACT_JUMPDW  = 04;
  ACT_FIRE    = 05;
  ACT_FIRERUN = 06;
  ACT_FIREUP  = 07;
  ACT_FIREJUMP= 08;
  ACT_FIREDW  = 09;
  ACT_DAMAGE  = 10;
  ACT_DEAD    = 11;


implementation
uses DxAI, Game01, Types;

{$R *.dfm}

{ Global Procedures }

function TdmMegaman.CheckFall(Sender: TDxSprite): Boolean;
begin
  Result:= Sender.VeloY > 200;
  if Result then
    Sender.LoadAction (ACT_JUMPDW);
end;

procedure TdmMegaman.CheckVeloX(Sender: TDxSprite);
begin
  with Sender do
    if kLeft in Keys then
      Veloc.ValueX:= -200
    else if kRight in Keys then
      Veloc.ValueX:= 200
    else
      Veloc.ValueX:= 0;
end;

function TdmMegaman.CheckJump(Sender: TDxSprite): Boolean;
begin
  Result:= True;
end;

procedure TdmMegaman.SimpleFire(Sender: TDxCustomSprite);
var
  s: TDxSprite;
  Fire: TDxSprite;
begin
  s:= Sender as TDxSprite;
  Fire:= TDxSprite.Create (Self, smFire, skFire);
  Fire.VeloX:= 300;
  AddRectSprite (s, Fire, 20, -10);
end;

procedure TdmMegaman.Explode (ASprite: TDxSprite);
var
  i: Integer;
  s: TDxSprite;
begin
  ASprite.Visible:= False;
  for i:= 1 to 8 do
  begin
    s:= TDxSprite.Create (Self, smExplode, skFire);
    s.Center:= ASprite.Center;
    case i of
      1,2,8: s.VeloX:= +ExpVeloc;
      4,5,6: s.VeloX:= -ExpVeloc;
    end;
    case i of
     2,3,4: s.VeloY:= -ExpVeloc;
      6,7,8: s.VeloY:= +ExpVeloc;
    end;
    ASprite.Stage.AddSprite (s);
  end;
end;

procedure TdmMegaman.SpriteDamage(Sprite: TDxSprite; const Value: Byte);
begin
  with Sprite do
  begin
    Dec (Life, Value);
    if Life <= 0 then
    begin
      LoadAction (ACT_DEAD);
      Explode(Sprite)
    end else
      LoadAction (ACT_DAMAGE);
  end;
end;

{ Sprite Manager Procedures }

procedure TdmMegaman.smMegaKeyDown(Sender: TDxSprite; Key: TDxKey;
  KeySet: TDxKeySet);
begin
  with Sender do
    case Key of
      kLeft:  MirrorX:= True;
      kRight: MirrorX:= False;
    end;
end;

procedure TdmMegaman.smMegaKeyUp(Sender: TDxSprite; Key: TDxKey;
  KeySet: TDxKeySet);
begin
  Sender.RemoveKey (Key);
end;

procedure TdmMegaman.smMegaSpriteClip(Sender: TDxSprite);
begin
  with Sender do
    if (bsBottom in ClipSides) and (Life > 0) then
    begin
      Life:= 0;
      LoadAction (ACT_DEAD);
    end;
end;

procedure TdmMegaman.smMegaLoad(Sender: TDxCustomSprite);
begin
  Life:= MaxLife;
  with Sender as TDxSprite do
  begin
    Accel.ValueY:= DefAccel;
    Enabled:= True;
    FrameEnabled:= True;
    LoadAction(ACT_DEFAULT);
  end;
end;

{ Default Action }

procedure TdmMegaman.smMegaDefaultKeyDown(Sender: TDxSprite;
  const Key: TDxKey; const KeySet: TDxKeySet);
begin
  smMega.OnKeyDown(Sender, Key, KeySet);
  with Sender do
    case Key of
      kFire: LoadAction (ACT_FIRE);
      kJump:
        if CheckJump(Sender) then
          LoadAction (ACT_JUMPUP);
    end;
end;

procedure TdmMegaman.smMegaDefaultExecute(Sender: TDxCustomSprite);
begin
  if not CheckFall(Sender as TDxSprite) then
    with Sender as TDxSprite do
      if (kLeft in Keys) or (kRight in Keys) then
        LoadAction (ACT_RUN);
end;

procedure TdmMegaman.smMegaDefaultStart(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
  begin
    VeloX:= 0;
    Accel.ValueY:= DefAccel;
  end;
end;

procedure TdmMegaman.smMegaExecute(Sender: TDxSprite);
begin

end;

{ Run Action }

procedure TdmMegaman.smMegaRunExecute(Sender: TDxCustomSprite);
begin
  CheckVeloX (Sender as TDxSprite);
  if not CheckFall(Sender as TDxSprite) then
    with Sender as TDxSprite do
      if VeloX = 0 then LoadAction (ACT_DEFAULT);
end;

procedure TdmMegaman.smMegaRunKeyDown(Sender: TDxSprite; const Key: TDxKey;
  const KeySet: TDxKeySet);
begin
  smMega.OnKeyDown(Sender, Key, KeySet);
  with Sender do
    case Key of
      kFire: LoadAction (ACT_FIRERUN);
      kJump:
        if CheckJump (Sender) then
          LoadAction (ACT_JUMPUP);
    end;
end;

{ Fire Action }

procedure TdmMegaman.smMegaFireTerminate(Sender: TDxCustomSprite);
begin
  SimpleFire (Sender);
  TDxSprite (Sender).LoadAction ('Default');
end;

procedure TdmMegaman.smMegaFireKeyDown(Sender: TDxSprite;
  const Key: TDxKey; const KeySet: TDxKeySet);
begin
  if (Key = kJump) and CheckJump (Sender) then
    Sender.LoadAction(ACT_JUMPUP);
end;

{ Jump Action }

procedure TdmMegaman.smMegaJumpUpStart(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
  begin
    if VeloX <> 0 then
      Veloc.ValueY:= -400
    else
      Veloc.ValueY:= -270;
    Accel.ValueY:= DefAccel;
  end;
end;

procedure TdmMegaman.smMegaJumpUpTerminate(Sender: TDxCustomSprite);
begin
  TDxSprite (Sender).LoadAction (ACT_JUMP)
end;

procedure TdmMegaman.smMegaJumpColision(
  out ColisionResult: TDxColisionResult; Sender: TDxSprite;
  const Info: TDxColisionData);
begin
  if Info.Side = bsBottom then
  begin
    if (kLeft in Sender.Keys) or (kRight in Sender.Keys)  then
      Sender.LoadAction (ACT_RUN)
    else
      Sender.LoadAction (ACT_DEFAULT)
  end;
end;

procedure TdmMegaman.smMegaJumpExecute(Sender: TDxCustomSprite);
begin
  CheckVeloX(Sender as TDxSprite);
  CheckFall(Sender as TDxSprite);
end;

procedure TdmMegaman.smMegaJumpKeyDown(Sender: TDxSprite;
  const Key: TDxKey; const KeySet: TDxKeySet);
begin
  smMega.OnKeyDown(Sender, Key, KeySet);
  if Key = kFire then
    Sender.LoadAction(ACT_FIREJUMP);
end;

procedure TdmMegaman.smMegaJumpUpKeyDown(Sender: TDxSprite;
  const Key: TDxKey; const KeySet: TDxKeySet);
begin
  smMega.OnKeyDown(Sender, Key, KeySet);
  if Key = kFire then
    Sender.LoadAction(ACT_FIREUP);
end;

procedure TdmMegaman.smMegaJumpDwKeyDown(Sender: TDxSprite;
  const Key: TDxKey; const KeySet: TDxKeySet);
begin
  smMega.OnKeyDown(Sender, Key, KeySet);
  if Key = kFire then
    Sender.LoadAction(ACT_FIREDW);
end;

{ Fire Action }

procedure TdmMegaman.smMegaFireRunTerminate(Sender: TDxCustomSprite);
begin
  SimpleFire (Sender);
  TDxSprite (Sender).LoadAction(ACT_RUN, [amCountReset]);
end;

procedure TdmMegaman.smMegaFireJumpTerminate(Sender: TDxCustomSprite);
begin
  SimpleFire (Sender);
  TDxSprite (Sender).LoadAction (ACT_JUMP);
end;

procedure TdmMegaman.smMegaFireDwTerminate(Sender: TDxCustomSprite);
begin
  SimpleFire (Sender);
  TDxSprite (Sender).LoadAction (ACT_JUMPDW);
end;

{ Dead/Explode Actions }

procedure TdmMegaman.smMegaDeadStart(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
  begin
    Enabled:= False;
    Veloc.Reset;
    Accel.Reset;
  end;
end;

procedure TdmMegaman.smMegaDeadTerminate(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
    dmDEMO_01.DxMachine.ReloadStage;
end;

procedure TdmMegaman.smExplodeDefaultTerminate(Sender: TDxCustomSprite);
begin
  with Sender as TDxSprite do
    Kill;
end;

{ Damage Actions }
var
  OldAct: TDxActionItem;

procedure TdmMegaman.smMegaDamageStart(Sender: TDxCustomSprite);
begin
  with TDxSprite (Sender) do
    if Action.Index <> ACT_DAMAGE then
      OldAct:= TDxSprite (Sender).Action;
end;

procedure TdmMegaman.smMegaDamageExecute(Sender: TDxCustomSprite);
begin
  CheckVeloX(Sender as TDxSprite);
end;

procedure TdmMegaman.smMegaDamageTerminate(Sender: TDxCustomSprite);
begin
  with TDxSprite (Sender) do
    if OldAct.Index in [ACT_JUMPUP, ACT_FIREUP] then
      LoadAction (ACT_JUMP)
    else
      LoadAction (OldAct);
end;

procedure TdmMegaman.DataModuleCreate(Sender: TObject);
begin
  skFire.Load;
  skMega.Load;
end;

end.
