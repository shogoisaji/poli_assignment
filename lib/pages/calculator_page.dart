import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:politec_assignment/featrue/calculator.dart';
import 'package:politec_assignment/featrue/count_up.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  double result = 0;
  int count = 0;
  String insertText = '';

  @override
  void deactivate() {
    super.deactivate();
  }

  void controllerReset() {
    _controller1.text = '';
    _controller2.text = '';
    result = 0;
  }

  @override
  Widget build(BuildContext context) {
    Calculator calculator = Calculator();
    CountUp countUp = CountUp();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
// calculator
            Container(
              width: 350,
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 176, 220, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '数値1 :',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _controller1,
                          decoration: const InputDecoration(
                            labelText: ' 数値1',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '数値2 :',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _controller2,
                          decoration: const InputDecoration(
                            labelText: ' 数値2',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            double? value1 = double.tryParse(_controller1.text);
                            double? value2 = double.tryParse(_controller2.text);
                            if (value1 != null && value2 != null) {
                              setState(() {
                                result = calculator.add(value1, value2);
                              });
                            }
                          },
                          child:
                              const Text('+', style: TextStyle(fontSize: 28))),
                      ElevatedButton(
                          onPressed: () {
                            double? value1 = double.tryParse(_controller1.text);
                            double? value2 = double.tryParse(_controller2.text);
                            if (value1 != null && value2 != null) {
                              setState(() {
                                result = calculator.sub(value1, value2);
                              });
                            }
                          },
                          child:
                              const Text('-', style: TextStyle(fontSize: 28))),
                      ElevatedButton(
                          onPressed: () {
                            double? value1 = double.tryParse(_controller1.text);
                            double? value2 = double.tryParse(_controller2.text);
                            if (value1 != null && value2 != null) {
                              setState(() {
                                result = calculator.mul(value1, value2);
                              });
                            }
                          },
                          child:
                              const Text('x', style: TextStyle(fontSize: 28))),
                      ElevatedButton(
                          onPressed: () {
                            double? value1 = double.tryParse(_controller1.text);
                            double? value2 = double.tryParse(_controller2.text);
                            if (value1 != null && value2 != null) {
                              setState(() {
                                result = calculator.div(value1, value2);
                              });
                            }
                          },
                          child:
                              const Text('÷', style: TextStyle(fontSize: 28))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          controllerReset();
                        });
                      },
                      child: const Text('Reset')),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('答え : ', style: TextStyle(fontSize: 20)),
                        Text(
                          result.toString(),
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
// countUp
            Container(
                width: 350,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 176, 220, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: 100,
                              // margin: const EdgeInsets.only(top: 100),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                count.toString(),
                                style: TextStyle(fontSize: 32),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      count = countUp.decrement(count);
                                    });
                                  },
                                  child: const Text('-',
                                      style: TextStyle(fontSize: 32))),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      count = countUp.resetCount(count);
                                    });
                                  },
                                  child: const Text('Reset',
                                      style: TextStyle(fontSize: 24))),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      count = countUp.increment(count);
                                    });
                                  },
                                  child: const Text('+',
                                      style: TextStyle(fontSize: 32))),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
// String Insert
            Container(
                width: 350,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 176, 220, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text('ボタンタップによる文字列入力'),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    insertText = '${insertText}1';
                                  });
                                },
                                child: const Text('1',
                                    style: TextStyle(fontSize: 32))),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    insertText = '${insertText}2';
                                  });
                                },
                                child: const Text('2',
                                    style: TextStyle(fontSize: 32))),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    insertText = '${insertText}3';
                                  });
                                },
                                child: const Text('3',
                                    style: TextStyle(fontSize: 32))),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 150,
                                // margin: const EdgeInsets.only(top: 100),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  insertText,
                                  style: TextStyle(fontSize: 32),
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    insertText = '';
                                  });
                                },
                                child: const Text('clear',
                                    style: TextStyle(fontSize: 24))),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
            const SizedBox(
              height: 40,
            ),
          ],
        )),
      ),
    );
  }
}
