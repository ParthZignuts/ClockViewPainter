import 'dart:async';
import 'dart:math';
import '../../view.dart';

class ClockViewScreen extends StatefulWidget {
  const ClockViewScreen({Key? key}) : super(key: key);

  @override
  State<ClockViewScreen> createState() => _ClockViewScreenState();
}

class _ClockViewScreenState extends State<ClockViewScreen> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    //Paint Brush
    var fillBrush = Paint()..color = const Color(0xFF444974);
    var outLineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;
    var centerFillBrush = Paint()..color = const Color(0xFFEAECFF);
    var secHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.orange[300]!
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    var minHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader = const RadialGradient(colors: [Colors.blue, Colors.white])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;
    var hourHandBrush = Paint()
      ..strokeCap = StrokeCap.round
      ..shader = const RadialGradient(colors: [Colors.pinkAccent, Colors.white])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 13
      ..style = PaintingStyle.stroke;

    var dashBrush = Paint()
      ..strokeWidth = 1
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    //draw on canvas
    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outLineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outeerCircleRadius = radius;
    var innerCircleRadius = radius - 20;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outeerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outeerCircleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
