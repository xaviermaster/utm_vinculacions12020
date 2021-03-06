import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BannerWidget extends CustomPainter {

  final Color color;

  BannerWidget(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = new Paint();

    painter.color = color;
    painter.style = PaintingStyle.fill;
    painter.strokeWidth = 1.0;

    final path = new Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    // path.quadraticBezierTo(size.width*0.1, size.height, size.width*0.4, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);

    canvas.drawPath(path, painter);
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}