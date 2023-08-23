import 'package:flutter/material.dart';

class AreaPage extends StatefulWidget {
  const AreaPage({Key? key}) : super(key: key);

  @override
  _AreaPageState createState() => _AreaPageState();
}

double _positonX = 0;
double _positonY = 0;

int tapCount = 0;

List<Offset?> tapPositions = [null, null];

class _AreaPageState extends State<AreaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          setState(
            () {
              if (tapPositions[0] != null && tapPositions[1] != null) {
                tapPositions = [null, null];
              }
              if (tapPositions[0] == null) {
                tapPositions[0] = details.globalPosition;
              } else {
                tapPositions[1] = details.globalPosition;
              }
            },
          );
          tapCount++;
          if (tapCount == 2 && tapPositions[1] != null) {
            tapCount = 0;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Center(
                child: Text(
                    "面積 : ${((tapPositions[0]!.dx - tapPositions[1]!.dx) * ((tapPositions[0]!.dy - tapPositions[1]!.dy))).abs().toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 30)),
              ),
              duration: const Duration(seconds: 1),
            ));
          }
        },
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Text('タップしてください'),
          ),
        ),
      ),
    );
  }
}
