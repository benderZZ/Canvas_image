object fmMap: TfmMap
  Left = 0
  Top = 0
  Caption = #1050#1072#1088#1090#1072' '#1086#1073#1098#1077#1082#1090#1072
  ClientHeight = 373
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  DesignSize = (
    765
    373)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 16
    Top = 24
    Width = 201
    Height = 193
    Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1072#1094#1080#1103' '#1082#1072#1088#1090#1099' '#1086#1073#1098#1077#1082#1090#1072'..'
    ParentBackground = False
    TabOrder = 0
    object ViewerMap: TGLSceneViewer
      Left = 24
      Top = 0
      Width = 199
      Height = 191
      Camera = cameraMain
      FieldOfView = 87.362808227539060000
      Visible = False
      OnMouseDown = ViewerMapMouseDown
      OnMouseMove = ViewerMapMouseMove
    end
  end
  object Panel2: TPanel
    Left = 245
    Top = 2
    Width = 516
    Height = 367
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    OnResize = Panel2Resize
    object imgMain: TImage
      Left = 1
      Top = 1
      Width = 514
      Height = 365
      Align = alClient
      Proportional = True
      OnMouseDown = imgMainMouseDown
      ExplicitWidth = 638
      ExplicitHeight = 618
    end
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 304
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object GLScene1: TGLScene
    Top = 8
    object dcMainCameraContainer: TGLDummyCube
      CubeSize = 1.000000000000000000
      object cameraMain: TGLCamera
        DepthOfView = 100000.000000000000000000
        FocalLength = 100.000000000000000000
        SceneScale = 2.000000000000000000
        TargetObject = dcMainCameraContainer
        Position.Coordinates = {000000000000A0410000A0410000803F}
        Direction.Coordinates = {0000803F000000000000000000000000}
        Up.Coordinates = {00000080000000000000803F00000000}
        object lightMainCamera: TGLLightSource
          ConstAttenuation = 1.000000000000000000
          SpotCutOff = 180.000000000000000000
        end
      end
      object dcCameraTarget: TGLDummyCube
        Direction.Coordinates = {00000000000080BF0000000000000000}
        ShowAxes = True
        Up.Coordinates = {00000000000000000000803F00000000}
        CubeSize = 1.000000000000000000
      end
    end
    object Plane: TGLPlane
      Material.FrontProperties.Diffuse.Color = {ACC8483EACC8483ECDCC4C3F0000803F}
      Material.MaterialOptions = [moNoLighting]
      Height = 1.000000000000000000
      Width = 1.000000000000000000
      NoZWrite = False
    end
    object PlaneFF: TGLFreeForm
      MaterialLibrary = GLMaterialLibrary1
    end
    object ProxyObject: TGLProxyObject
    end
  end
  object GLMaterialLibrary1: TGLMaterialLibrary
    Left = 48
    Top = 8
  end
  object AsyncTimer1: TAsyncTimer
    Interval = 40
    OnTimer = AsyncTimer1Timer
    ThreadPriority = tpNormal
    Left = 32
    Top = 248
  end
end
