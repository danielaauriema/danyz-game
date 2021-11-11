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

unit GAME01;

interface

uses
  Windows, SysUtils, Classes, DxUtils, jpeg, ImgList, Controls, ExtCtrls,
  Menus, Forms, Graphics, Dises, Dialogs, AppEvnts, Config;

type
  TdmDEMO_01 = class(TDataModule)
    Stage1: TDxStage;
    Map1: TDxMap;
    Splash1: TDxSplash;
    imgSplash1: TDxImage;
    smPlat: TDxSpriteManager;
    rsPlat: TDxRotateSkin;
    Bkg1: TDxImage;
    smPickup: TDxSpriteManager;
    skPickup: TDxSkin;
    DxBar: TDxImage;
    DxMachine: TDxMachine;
    Audio1: TDxAudio;
    DxTiles: TDxTiles;
    appEvents: TApplicationEvents;
    StageE: TDxStage;
    imgSplashE: TDxImage;
    SplashE: TDxSplash;
    AudioE: TDxAudio;
    fxHealt: TDxAudio;
    Stage2: TDxStage;
    Map2: TDxMap;
    Splash2: TDxSplash;
    imgSplash2: TDxImage;
    Bkg2: TDxImage;
    Stage3: TDxStage;
    Map3: TDxMap;
    Splash3: TDxSplash;
    imgSplash3: TDxImage;
    Bkg3: TDxImage;
    procedure Stage1Execute(Sender: TObject);
    procedure smPlatColisions0Colision(Sender, Sprite: TDxSprite;
      const R: TRect);
    procedure Stage1DrawScreen(Sender: TDxStage; AScreen,
      AFrame: TBitmap);
    procedure MyClose (Sender: TObject; var Action: TCloseAction);
    procedure DxStageSprites11Load(Sender: TDxSprite);
    procedure appEventsActivate(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure smPickupHealtColision(Sender, Sprite: TDxSprite;
      const R: TRect);
    procedure Stage2Sprites21Load(Sender: TDxSprite);
    procedure smPlatHorzColision(out ColisionResult: TDxColisionResult;
      Sender: TDxSprite; const Info: TDxColisionData);
    procedure smPlatVertColision(out ColisionResult: TDxColisionResult;
      Sender: TDxSprite; const Info: TDxColisionData);
    procedure Stage2Sprites22Load(Sender: TDxSprite);
    procedure Stage2Sprites23Load(Sender: TDxSprite);
    procedure Stage2Sprites24Load(Sender: TDxSprite);
    procedure smPlatVertExecute(Sender: TDxCustomSprite);
    procedure Stage2Sprites25Load(Sender: TDxSprite);
    procedure Stage2Sprites26Load(Sender: TDxSprite);
    procedure Stage2Sprites27Load(Sender: TDxSprite);
    procedure Stage2Sprites28Load(Sender: TDxSprite);
    procedure Stage3Sprites21Load(Sender: TDxSprite);
    procedure Stage3Sprites23Load(Sender: TDxSprite);
    procedure Stage3Sprites22Load(Sender: TDxSprite);
    procedure Stage3Sprites25Load(Sender: TDxSprite);
    procedure Stage3Sprites24Load(Sender: TDxSprite);
    procedure Stage3Sprites26Load(Sender: TDxSprite);
    procedure Stage3Sprites27Load(Sender: TDxSprite);
    procedure Stage3Sprites28Load(Sender: TDxSprite);
    procedure Stage3Sprites29Load(Sender: TDxSprite);
    procedure Stage1Sprites14Load(Sender: TDxSprite);
    procedure DxMachineKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Stage3Execute(Sender: TObject);
    procedure StageEAfterLoad(Sender: TObject);
    procedure Stage1Unload(Sender: TObject);
    procedure Stage1AfterLoad(Sender: TObject);
  public
    function Config (Inicio: Boolean): Integer;
  end;

  TPlatParm = class (TObject)
  private
    FMax, FMin: Integer;
  public
    constructor Create (AMin, AMax: Integer);
    property Min: Integer read FMin;
    property Max: Integer read FMax;
  end;

var
  DxForm: TDxForm;
  dmDEMO_01: TdmDEMO_01;
  cfg: boolean = False;

implementation
uses DxAI, Megaman, Monstros;

{$R *.dfm}

{ TPlatParm }

constructor TPlatParm.Create(AMin, AMax: Integer);
begin
  inherited Create;
  FMin:= AMin;
  FMax:= AMax;
end;

{ TdmDEMO_01 }

{ Global Procedures }

procedure TdmDEMO_01.DataModuleCreate(Sender: TObject);
begin
  AppDir:= ExtractFilePath (Application.ExeName);
  skPickup.Load;
  rsPlat.Load;
  DxBar.Load;
end;

procedure TdmDEMO_01.appEventsActivate(Sender: TObject);
begin
  if not cfg then
  begin
    if Config (True) = mrOk then
    begin
      DxMachine.Load;
      DxForm.OnClose:= MyClose;
      DxForm.Machine:= DxMachine;
      DxForm.Recenter (True);

      //DxForm.BorderStyle:= bsSizeable;
      //DxForm.Width:= DxMachine.Screen.Width;
      //DxForm.Height:= DxMachine.Screen.Height;
      //DxForm.Recenter (False);

      DxMachine.LoadStage;
      DxMachine.Start;
      cfg:= True;
    end else
      Application.Terminate;
  end;
end;

procedure TdmDEMO_01.MyClose(Sender: TObject; var Action: TCloseAction);
begin
  if DxMachine.State = gsLoading then
    Action:= caNone
  else
  begin
    DxMachine.Stop;
    DxMachine.Unload;
  end;
end;

function TdmDEMO_01.Config (Inicio: Boolean): Integer;
var
  frm: TfrmConfig;
begin
  frm:= TfrmConfig.Create (Self);
  if not Inicio then
    frm.cbInput.ItemIndex:= DxMachine.MngPlayer1.JoyId + 1;
  Result:= frm.ShowModal;
  if Result = mrOK then
    try
      DxMachine.MngPlayer1.JoyId:= frm.cbInput.ItemIndex - 1;
    except
      DxMachine.MngPlayer1.JoyId:= - 1;
    end;
end;

procedure TdmDEMO_01.DxMachineKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmp: TDxStageManager;
begin
  with DxMachine do
    if (Key in [13, 27]) and (State = gsRunning) then
    begin
      Stop;
      with Stage do
        if Assigned (Audio) then
          Audio.Pause;
      MouseShowCursor (True);
      if Config (False) = mrAbort then
      begin
        Unload;
        Application.Terminate;
      end else
      begin
        MouseShowCursor (False);
        with Stage do
          if Assigned (Audio) then
            Audio.Play;
        DxMachine.Start;
      end;
    end;
  if Key = VK_DELETE then
    with DxMachine.Stage do
      if GetManager(tmp, dmMonstros.smMonstro) then
        tmp.ClearSprites;
end;

{ Controle de Plataformas }

procedure TdmDEMO_01.smPlatColisions0Colision(Sender, Sprite: TDxSprite;
  const R: TRect);
var
  side: TDxSide;
  Info: TDxColisionData;
  cr: TDxColisionResult;
begin
  side:= GetColisionSide(Sprite.Rect, R);
  if Side = bsBottom then
  begin
    cr:= crSkip;
    Info.Rect:= Sprite.Rect;
    OffsetRect(Info.Rect, -Sprite.X, -Sprite.Y);
    Info.Side:= bsBottom;
    Info.Area:= Sender.Rect;
    Sprite.Colision (Info, cr);
    Sender.AddJoin(Sprite, 10);
    Sprite.AddColision(Side);
  end;
  if ((bsBottom in Sprite.Colisions) and (bsTop in Sprite.Colisions)) or
     ((bsLeft in Sprite.Colisions) and (bsRight in Sprite.Colisions))
   then
     dmMegaman.SpriteDamage (Sprite, dmMegaman.Life);
end;

procedure TdmDEMO_01.smPlatHorzColision(
  out ColisionResult: TDxColisionResult; Sender: TDxSprite;
  const Info: TDxColisionData);
begin
  if Info.Side = bsLeft then
    Sender.VeloX:= Abs (Sender.VeloX)
  else if Info.Side = bsRight then
    Sender.VeloX:= -Abs (Sender.VeloX);
end;

procedure TdmDEMO_01.smPlatVertColision(
  out ColisionResult: TDxColisionResult; Sender: TDxSprite;
  const Info: TDxColisionData);
begin
  with Sender do
    if not Assigned (UserObj) then
    begin
      if Info.Side = bsBottom then
        VeloY:= -Abs (VeloY)
      else if Info.Side = bsTop then
        VeloY:= Abs (VeloY);
    end;
end;

procedure TdmDEMO_01.smPlatVertExecute(Sender: TDxCustomSprite);
begin
  with TDxSprite (Sender) do
    if Assigned (UserObj) then
    begin
      if Y <= TPlatParm (UserObj).Min then
        VeloY:= Abs (VeloY)
      else if Y >= TPlatParm (UserObj).Max then
        VeloY:= -Abs (VeloY);
    end;
end;

{ Pickups }

procedure TdmDEMO_01.smPickupHealtColision(Sender, Sprite: TDxSprite;
  const R: TRect);
begin
  with Sender do
    if Action.Index = 0 then//Healt
    begin
      fxHealt.Play (True);
      dmMegaman.Life:= MaxLife;
    end;
end;

{ Controle de Execução do Stage 1 }

procedure TdmDEMO_01.Stage1Execute(Sender: TObject);
var
  tmp: TDxStageManager;
begin
  with Sender as TDxStage do
    if not GetManager(tmp, dmMonstros.smMonstro) then
      DxMachine.LoadNextStage (True);
end;

procedure TdmDEMO_01.Stage1DrawScreen(Sender: TDxStage; AScreen,
  AFrame: TBitmap);
var
  bmp: TBitmap;
  tmp: TDxStageManager;
begin
  with AScreen.Canvas do
    try
      Lock;
      //Desenha o Frame
      Brush.Color:=  clBlack;
      FillRect (ClipRect);
      BitBlt(Handle, 0, 0,
        AFrame.Width, AFrame.Height,
        AFrame.Canvas.Handle, 0, 0, SRCCOPY);
      //Desenha a Barra
      Bmp:= DxBar.Bitmap;
      BitBlt (Handle, 0, 430, bmp.Width, bmp.Height,
        bmp.Canvas.Handle, 0, 0, SRCCOPY);
      //Desenha Energias
      if dmMegaman.Life >= 1 then
        skPickup.DxImage.DrawMasked(0, 15, 440, AScreen.Canvas);
      if dmMegaman.Life >= 2 then
        skPickup.DxImage.DrawMasked(0, 45, 440, AScreen.Canvas);
      if dmMegaman.Life >= 3 then
        skPickup.DxImage.DrawMasked(0, 75, 440, AScreen.Canvas);
      Brush.Style:= bsClear;
      Font.Color:= clBlack;
      Font.Name:= 'Arial';
      Font.Size:= 12;
      Font.Style:= [fsBold];
      DxMachine.Stage.GetManager(tmp, dmMonstros.smMonstro);
      if Assigned (tmp) then
        TextOut (550, 440, IntToStr (tmp.Count));
      //Display Info
      Font.Color:= clYellow;
      Font.Name:= 'System';
      Font.Size:= 20;
      Font.Style:= [];
      if DxMachine.AcDelay > 0 then
        TextOut(10, 10, 'FPS: ' + IntToStr (1000 div DxMachine.AcDelay))
      else
        TextOut(10, 10, 'FPS: ????');
      Brush.Style:= bsSolid;
    finally
      Unlock;
    end;
end;

procedure TdmDEMO_01.Stage1AfterLoad(Sender: TObject);
begin
  Audio1.Play (True);
end;

procedure TdmDEMO_01.Stage1Unload(Sender: TObject);
begin
  Audio1.Stop;
end;

{ Controle de Execução do Stage 3 }

procedure TdmDEMO_01.Stage3Execute(Sender: TObject);
var
  tmp: TDxStageManager;
begin
  with Sender as TDxStage do
    if not GetManager(tmp, dmMonstros.smMonstro) then
      DxMachine.LoadNextStage (False);
end;

{ Controle de Execução do Stage End }

procedure TdmDEMO_01.StageEAfterLoad(Sender: TObject);
begin
  MouseShowCursor (True);
  with DxMachine.Screen.Canvas do
  begin
    Brush.Color:= clBlack;
    FillRect(ClipRect);
  end;
  DxMachine.Display.DrawFrame;
  if Config (False) = mrAbort then
    Application.Terminate
  else
  begin
    MouseShowCursor (False);
    with DxMachine do
    begin
      StageE.Unload;
      LoadStage (Stage1);
      Start;
    end;
  end;
end;

{ Controle de Carga do Stage 1 }

procedure TdmDEMO_01.DxStageSprites11Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

procedure TdmDEMO_01.Stage1Sprites14Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (100, 400);
end;

{ Controles de Carga do Stage 2 }

procedure TdmDEMO_01.Stage2Sprites21Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

procedure TdmDEMO_01.Stage2Sprites22Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 350);
end;

procedure TdmDEMO_01.Stage2Sprites23Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 450);
end;

procedure TdmDEMO_01.Stage2Sprites24Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

procedure TdmDEMO_01.Stage2Sprites25Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 400);
end;

procedure TdmDEMO_01.Stage2Sprites26Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 450);
end;

procedure TdmDEMO_01.Stage2Sprites27Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 350);
end;

procedure TdmDEMO_01.Stage2Sprites28Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

{ Controle de Carga do Stage 3 }

procedure TdmDEMO_01.Stage3Sprites21Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

procedure TdmDEMO_01.Stage3Sprites23Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

procedure TdmDEMO_01.Stage3Sprites22Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

procedure TdmDEMO_01.Stage3Sprites25Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 300);
end;

procedure TdmDEMO_01.Stage3Sprites24Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (50, 650);
end;

procedure TdmDEMO_01.Stage3Sprites26Load(Sender: TDxSprite);
begin
  Sender.VeloX:= -100;
end;

procedure TdmDEMO_01.Stage3Sprites27Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 750);
end;

procedure TdmDEMO_01.Stage3Sprites28Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 750);
end;

procedure TdmDEMO_01.Stage3Sprites29Load(Sender: TDxSprite);
begin
  Sender.LoadAction (1);
  Sender.VeloY:= 100;
  Sender.UserObj:= TPlatParm.Create (150, 750);
end;

end.
