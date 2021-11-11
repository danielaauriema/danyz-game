object dmMegaman: TdmMegaman
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 287
  Width = 359
  object smMega: TDxSpriteManager
    Actions = <
      item
        Name = 'Default'
        FrameDelay = 2000
        FrameSize = 4
        OnKeyDown = smMegaDefaultKeyDown
        OnStart = smMegaDefaultStart
        OnExecute = smMegaDefaultExecute
      end
      item
        Name = 'Run'
        FirstFrame = 4
        FrameSize = 4
        OnKeyDown = smMegaRunKeyDown
        OnExecute = smMegaRunExecute
      end
      item
        Name = 'JumpUp'
        FirstFrame = 12
        FrameSize = 3
        FrameCount = 3
        OnKeyDown = smMegaJumpUpKeyDown
        OnStart = smMegaJumpUpStart
        OnTerminate = smMegaJumpUpTerminate
        OnColision = smMegaJumpColision
        OnExecute = smMegaJumpExecute
      end
      item
        Name = 'Jump'
        FirstFrame = 14
        OnKeyDown = smMegaJumpKeyDown
        OnColision = smMegaJumpColision
        OnExecute = smMegaJumpExecute
      end
      item
        Name = 'JumpDw'
        FirstFrame = 15
        OnKeyDown = smMegaJumpDwKeyDown
        OnColision = smMegaJumpColision
        OnExecute = smMegaJumpExecute
      end
      item
        Audio = fxFire
        Options = [amCountReset]
        Name = 'FireRun'
        FirstFrame = 8
        FrameSize = 4
        FrameCount = 2
        OnTerminate = smMegaFireRunTerminate
      end
      item
        Audio = fxFire
        Name = 'Fire'
        FirstFrame = 20
        FrameSize = 2
        FrameCount = 2
        OnKeyDown = smMegaFireKeyDown
        OnTerminate = smMegaFireTerminate
      end
      item
        Audio = fxFire
        Name = 'FireUp'
        FirstFrame = 16
        FrameSize = 3
        FrameCount = 2
        OnTerminate = smMegaFireJumpTerminate
      end
      item
        Audio = fxFire
        Name = 'FireJump'
        FirstFrame = 18
        FrameCount = 2
        OnTerminate = smMegaFireJumpTerminate
      end
      item
        Audio = fxFire
        Name = 'FireDw'
        FirstFrame = 19
        FrameCount = 2
        OnTerminate = smMegaFireDwTerminate
      end
      item
        Audio = fxDamage
        Name = 'Damage'
        FirstFrame = 22
        FrameDelay = 40
        FrameSize = 2
        FrameCount = 10
        OnStart = smMegaDamageStart
        OnTerminate = smMegaDamageTerminate
        OnExecute = smMegaDamageExecute
      end
      item
        Audio = fxDead
        Name = 'Dead'
        FrameCount = 30
        OnStart = smMegaDeadStart
        OnTerminate = smMegaDeadTerminate
      end>
    Clip.Mode = cmFrame
    ClipOut = [bsTop, bsBottom]
    Optimize = False
    Colisions = <>
    MapColision = mcDefault
    OnKeyUp = smMegaKeyUp
    OnKeyDown = smMegaKeyDown
    OnLoad = smMegaLoad
    OnExecute = smMegaExecute
    OnSpriteClip = smMegaSpriteClip
    Left = 24
    Top = 8
  end
  object smFire: TDxSpriteManager
    Actions = <
      item
        Name = 'Default'
      end>
    Clip.Kill = True
    Clip.Mode = cmMargin
    ClipOut = [bsLeft, bsTop, bsRight, bsBottom]
    MarginX = 50
    Colisions = <>
    MapColision = mcKill
    Left = 176
    Top = 8
  end
  object fxFire: TDxAudio
    Mode = amStop
    FileName = 'laser.mp3'
    Enabled = False
    Left = 96
    Top = 8
  end
  object sMega: TDxSprite
    Skin = skMega
    Shared = True
    Manager = smMega
    Left = 24
    Top = 120
  end
  object skMega: TDxSkin
    Options = [soMirrorX]
    Images = 'Images\Dany.bmp'
    Mode = rmFine
    Width = 50
    Height = 70
    Transparent = True
    Left = 24
    Top = 64
  end
  object skFire: TDxSkin
    Images = 'Images\Fire.bmp'
    Mode = rmFine
    Width = 10
    Height = 10
    Transparent = True
    Left = 176
    Top = 64
  end
  object smExplode: TDxSpriteManager
    Actions = <
      item
        Name = 'Default'
        FrameCount = 5
        OnTerminate = smExplodeDefaultTerminate
      end>
    Clip.Kill = True
    Clip.Mode = cmFrame
    Colisions = <>
    Left = 248
    Top = 8
  end
  object fxDead: TDxAudio
    Mode = amStop
    FileName = 'sound24.mp3'
    Enabled = False
    Left = 96
    Top = 120
  end
  object fxDamage: TDxAudio
    Mode = amStop
    FileName = 'sound14.mp3'
    Enabled = False
    Left = 96
    Top = 64
  end
end
