import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathtest/data.dart';

class MathTestWidget extends StatefulWidget {
  const MathTestWidget({super.key, required this.settingsData});

  final SettingsData settingsData;

  @override
  State<StatefulWidget> createState() => _StateMathTestWidget();
}

class _StateMathTestWidget extends State<MathTestWidget> {
  TextEditingController answerController = TextEditingController();
  int a = 1;
  int b = 1;

  int successful = 0;
  int failed = 0;

  bool endTest = false;

  int _remainingTime = 10; //initial time in seconds
  late Timer _timer;

  @override
  void initState() {
    _remainingTime = widget.settingsData.duration;
    _startTimer();
    a = Random().nextInt(pow(10, widget.settingsData.order).toInt() - 1)+1;
    b = Random().nextInt(pow(10, widget.settingsData.order).toInt() - 1)+1;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          endTest = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_remainingTime ~/ 60).toString();
    String seconds = (_remainingTime % 60).toString();
    return endTest
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Тест закончен", textScaleFactor: 5.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Длительность: ${widget.settingsData.duration} сек.   ",
                    textScaleFactor: 2.0),
                Text("Сложность: ${widget.settingsData.order}   ",
                    textScaleFactor: 2.0),
                Text("Примеров: ${widget.settingsData.questions}",
                    textScaleFactor: 2.0),
              ]),
              Text(
                  "Выполнен за: ${widget.settingsData.duration - _remainingTime} сек.",
                  textScaleFactor: 3.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Верно:",
                      textScaleFactor: 3.0,
                    ),
                    Card(
                        color: Colors.lightGreen,
                        child:
                            Text(successful.toString(), textScaleFactor: 5.0)),
                    const Text(
                      "Ошибок: ",
                      textScaleFactor: 3.0,
                    ),
                    Card(
                        color: Colors.redAccent,
                        child: Text(failed.toString(), textScaleFactor: 5.0))
                  ])
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Text(
                      minutes,
                      textScaleFactor: 5.0,
                    ),
                  ),
                  const Text(":",textScaleFactor: 6.0,),
                  Card(
                    child: Text(
                      seconds,
                      textScaleFactor: 5.0,
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Text(
                      expr(),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    )),
                    Flexible(
                        child: TextField(
                      controller: answerController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                      onEditingComplete: () => {
                        _proceedTest(context),
                        answerController.clear(),
                      },
                    ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.lightGreen,
                    child: Text(
                      successful.toString(),
                      textScaleFactor: 5.0,
                    ),
                  ),
                  Card(
                    color: Colors.redAccent,
                    child: Text(
                      failed.toString(),
                      textScaleFactor: 5.0,
                    ),
                  )
                ],
              ),
            ],
          );
  }

  void _proceedTest(BuildContext context) {
    int result = 0;
    try {
      result = int.parse(answerController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(duration: Duration(seconds: 1), content: Text("Пусто")),
      );
      return;
    }
    (a + b) == result
        ? {successful += 1}
        : {
            failed += 1,
          };
    (successful + failed) == widget.settingsData.questions
        ? {
            setState(() {
              endTest = true;
              _timer.cancel();
            })
          }
        : {
            setState(() {
              a = Random()
                  .nextInt(pow(10, widget.settingsData.order).toInt() - 1)+1;
              b = Random()
                  .nextInt(pow(10, widget.settingsData.order).toInt() - 1)+1;
            })
          };
  }

  String expr() => "$a + $b =";
}
