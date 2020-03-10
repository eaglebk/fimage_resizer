import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ResizerImageWidget extends StatefulWidget {
  final VoidCallback onPress;
  final String title;
  const ResizerImageWidget({Key key, this.title, this.onPress})
      : super(key: key);

  @override
  _ResizerImageWidgetState createState() => _ResizerImageWidgetState();
}

class _ResizerImageWidgetState extends State<ResizerImageWidget> {
  ui.Image image;
  String title;

  bool isImageloaded = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    title = widget.title;
    final ByteData data = await rootBundle.load('assets/images/$title');
    image = await loadImage(Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageloaded) {
      return ClipRect(
        clipper: CustomRect(),
        child: Container(
          width: 1200,
          height: 1200,
          child: CustomPaint(
            painter: ImagePainter(image: image),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget build(BuildContext context) {
    Widget image = GestureDetector(
      onTap: () {
        widget.onPress();
      },
      child: _buildImage(),
    );
    return image;
  }
}

class ImagePainter extends CustomPainter {
  ImagePainter({this.image});

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCanvas(size, canvas);
  }

  Canvas _drawCanvas(Size size, Canvas canvas) {
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
    return canvas;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomRect extends CustomClipper<Rect> {
  double resizeRatio = 16 / 9;

  @override
  Rect getClip(Size size) {
    final inputImageAspectRatio = size.width / size.height;

    double outputWidth = size.width;
    double outputHeight = size.height;

    if (inputImageAspectRatio > resizeRatio) {
      outputWidth = size.height * resizeRatio;
    } else if (inputImageAspectRatio < resizeRatio) {
      outputHeight = size.width / resizeRatio;
    }

    Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: outputWidth / 2,
        height: outputHeight / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) {
    return false;
  }
}
