object dmMonstros: TdmMonstros
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 187
  Width = 201
  object smMonstro: TDxSpriteManager
    Actions = <
      item
        Name = 'Default'
        FirstFrame = 10
        FrameSize = 6
        OnExecute = smMonstroDefaultExecute
      end
      item
        Name = 'Fire'
        FrameSize = 10
        FrameCount = 10
        OnTerminate = smMonstroFireTerminate
      end
      item
        Name = 'Dead'
        FirstFrame = 16
        FrameDelay = 200
        FrameSize = 4
        FrameCount = 4
        OnStart = smMonstroDeadStart
        OnTerminate = smMonstroDeadTerminate
      end>
    AutoFreeze = True
    MarginX = 1280
    MarginY = 480
    Optimize = False
    Colisions = <
      item
        Name = 'smMega'
        Colision = dmMegaman.smMega
        OnColision = smMonstrosmMegaColision
      end
      item
        Name = 'smFire'
        Colision = dmMegaman.smFire
        Mode = scKillSprite
        OnColision = smMonstrosmFireColision
      end>
    MapColision = mcDefault
    OnLoad = smMonstroLoad
    OnExecute = smMonstroExecute
    Left = 40
    Top = 24
  end
  object smBuble: TDxSpriteManager
    Actions = <
      item
        Name = 'Default'
        FrameDelay = 0
        FrameSize = 5
      end>
    Clip.Kill = True
    Clip.Mode = cmFrame
    ClipOut = [bsLeft, bsRight]
    MarginX = 700
    Colisions = <
      item
        Name = 'smMega'
        Colision = dmMegaman.smMega
        Mode = scKillSender
        OnColision = smMonstrosmMegaColision
      end>
    MapColision = mcKill
    Left = 112
    Top = 24
  end
  object skMonstro: TDxSkin
    Options = [soMirrorX]
    Images = 'Images\Monstro.bmp'
    Mode = rmFine
    Width = 70
    Height = 90
    Transparent = True
    Left = 40
    Top = 80
  end
  object skBuble: TDxSkin
    Options = [soMirrorX]
    Images = 'Images\Bolha.bmp'
    Mode = rmFine
    Width = 40
    Height = 40
    Transparent = True
    Left = 112
    Top = 80
  end
end
