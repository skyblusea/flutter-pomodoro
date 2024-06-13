import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    double pickerWidth = 300;
    double pickerHeight = 60;

    final color = Theme.of(context).colorScheme.onPrimary;

    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Center(
              child: CustomPaint(
                size: Size(pickerWidth, pickerHeight),
                painter: TimePickerPainter(scaleColor: color),
              ),
            );
          } else {
            return SizedBox(
              width: pickerWidth / 2,
              height: pickerHeight,
            );
          }
        });
  }
}

class TimePickerPainter extends CustomPainter {
  final Color scaleColor;
  TimePickerPainter({required this.scaleColor});

  final scaleWidth = 3.0; // 눈금 두께 설정

  final subScaleCountPerScale = 5; // 한 눈금에 몇개의 작은 눈금을 그릴지 설정
  final subScaleWidth = 12; // 작은 눈금의 간격 설정
  final minValue = 0;
  final step = 1;
  final maxValue = 60;
  final scaleTextWidth = 16.0; // 눈금 숫자의 크기 설정

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..isAntiAlias = true // 그래픽 이미지를 부드럽게
      ..strokeWidth = scaleWidth
      ..style = PaintingStyle.stroke
      ..color = scaleColor;

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    void drawLine(Canvas canvas, Size size) {
      int index = 0;

      for (double x = 0; x <= size.width; x += subScaleWidth) {
        if (index % subScaleCountPerScale == 0) {
          canvas.drawLine(
            Offset(x, size.height / 8 * 0),
            Offset(x, size.height / 8 * 4.5),
            linePaint,
          );
        } else {
          canvas.drawLine(
            Offset(x, size.height / 8 * 4.5),
            Offset(x, size.height / 8 * 2),
            linePaint,
          );
        }
        index++;
      }
    }

    void drawNum(Canvas canvas, Size size) {
      canvas.save();
      canvas.translate(0, 0);

      double offsetX = (subScaleWidth * subScaleCountPerScale).toDouble();
      int index = 0;

      for (double x = 0; x <= size.width; x += offsetX) {
        textPainter.text = TextSpan(
          text: "${minValue + index * step * subScaleCountPerScale}",
          style: TextStyle(color: scaleColor, fontSize: scaleTextWidth),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            -textPainter.width / 2,
            size.height - textPainter.height,
          ),
        );
        index++;
        canvas.translate(offsetX, 0);
      }
      canvas.restore();
    }

    drawLine(canvas, size);
    drawNum(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
