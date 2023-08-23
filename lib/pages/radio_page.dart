import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  int? _selectedIndex;
  final List<String> _bloodType = const ['A', 'B', 'AB', 'O'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('血液型をチェックしてください'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _selectedIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedIndex = value as int;
                          });
                        },
                      ),
                      const Text('A'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _selectedIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedIndex = value as int;
                          });
                        },
                      ),
                      const Text('B'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _selectedIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedIndex = value as int;
                          });
                        },
                      ),
                      const Text('AB'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: _selectedIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedIndex = value as int;
                          });
                        },
                      ),
                      const Text('O'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text(
                              _selectedIndex != null
                                  ? "${_bloodType[_selectedIndex!]}型"
                                  : "血液型を選択してください",
                              style: const TextStyle(fontSize: 24)),
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text('choice', style: TextStyle(fontSize: 20)))
            ],
          )
        ],
      )),
    );
  }
}
