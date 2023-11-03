import 'dart:math';

import 'package:flutter/material.dart';

// class _ExampleState extends StatefulWidget {
//   const _ExampleState({super.key});
//
//   @override
//   State<_ExampleState> createState() => _ExampleStateState();
// }
//
// class _ExampleStateState extends State<_ExampleState> {
//   @override
//   Widget build(BuildContext context) {
//     return const RadialPercentWidget(child: null,);
//   }
// }

// fillColor: Colors.blue,
// lineColor: Colors.red,
// freeColor: Colors.yellow,

class RadialPercentWidget extends StatelessWidget {
  const RadialPercentWidget(
      {super.key,
      required this.child,
      required this.percent,
      required this.fillColor,
      required this.lineColor,
      required this.freeColor,
      required this.lineWidth});

  final Widget child;

  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      CustomPaint(
        painter: MyPainter(
            percent: percent,
            fillColor: fillColor,
            lineColor: lineColor,
            freeColor: freeColor,
            lineWidth: lineWidth),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(child: child),
      )
    ]);
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  MyPainter(
      {required this.percent,
      required this.fillColor,
      required this.lineColor,
      required this.freeColor,
      required this.lineWidth});


  @override
  void paint(Canvas canvas, Size size) {
    Rect arcRect = calculateArcsRect(size);
    final radiantPercent = percent / 100;
    drawBackground(canvas, size);

    drawFreeArc(canvas, arcRect, radiantPercent);

    drawFiledArc(canvas, arcRect, radiantPercent);
  }

  void drawFiledArc(Canvas canvas, Rect arcRect, radiantPercent) {
    final paint = Paint();
    paint.color = lineColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, -pi / 2, pi * 2 * radiantPercent, false, paint);
  }

  void drawFreeArc(Canvas canvas, Rect arcRect, radiantPercent) {
    final paint = Paint();
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;

    canvas.drawArc(arcRect, pi * 2 * radiantPercent - (pi / 2),
        pi * 2 * (1.0 - radiantPercent), false, paint);
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    const lineMargin = 3;
    final offcet = lineWidth / 2 + lineMargin;
    final arcRect = Offset(offcet, offcet) & Size(size.width - offcet * 2, size.height - offcet * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
