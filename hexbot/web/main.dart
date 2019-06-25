import 'dart:async';
import 'dart:html' as html;
import 'lib/hexbot.dart';
import 'package:stagexl/stagexl.dart';
import 'dart:math';

Future<Null> main() async {
  StageOptions options = StageOptions()
    ..backgroundColor = HexBot().getColor();
    ..renderEngine = RenderEngine.WebGL;

  var canvas = html.querySelector('#stage');
  var stage = Stage(canvas, width: 1280, height: 800, options: options);

  var renderLoop = RenderLoop();
  renderLoop.addStage(stage);

  var resourceManager = ResourceManager();
  resourceManager.addBitmapData("dart", "images/dart@1x.png");

  await resourceManager.load();

  var logoData = resourceManager.getBitmapData("dart");
  var logo = Sprite();
  var textField = new TextField();
  var textFormat = new TextFormat('Helvatica,Arial', 24, Color.Black, bold:true, italic:true);
  textField.defaultTextFormat = textFormat;
  textField.text = "Mahtab Tadayon Chaharsoughi";
  logo.addChild(textField);

  logo.pivotX = logoData.width;
  logo.pivotY = logoData.height;

  // Place it at top center.
  logo.x = 1280 / 2;
  logo.y = 0;

  stage.addChild(logo);

  // And let it fall.
  var tween = stage.juggler.addTween(logo, 3, Transition.easeOutBounce);
  tween.animate.y.to(800 / 2);

  // Add some interaction on mouse click.
  Tween rotation;
  logo.onMouseClick.listen((MouseEvent e) {
    // Don't run more rotations at the same time.
    if (rotation != null) return;
    rotation = stage.juggler.addTween(logo, 0.5, Transition.easeInOutCubic);
    rotation.animate.rotation.by(2 * pi);
    rotation.onComplete = () => rotation = null;
  });
  logo.mouseCursor = MouseCursor.POINTER;

  // See more examples:
  // https://github.com/bp74/StageXL_Samples
}
