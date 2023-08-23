import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String name = '';
  int? age;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('入力フォーム'),
                          content: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('氏名'),
                                    SizedBox(
                                      width: 180,
                                      child: TextField(
                                        controller: _nameController,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('年齢'),
                                    SizedBox(
                                      width: 180,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: _ageController,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _nameController.clear();
                                    _ageController.clear();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('cancel',
                                      style: TextStyle(fontSize: 20)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_nameController.text == '' ||
                                        _ageController.text == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Center(
                                          child: Text("未入力の項目があります",
                                              style: TextStyle(fontSize: 30)),
                                        ),
                                        duration: Duration(seconds: 1),
                                      ));
                                      return;
                                    }
                                    setState(() {
                                      name = _nameController.text;
                                      age = int.parse(_ageController.text);
                                    });
                                    _nameController.clear();
                                    _ageController.clear();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('save',
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                },
                child: const Text(
                  '入力画面',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              Row(
                children: [
                  const Text('確定氏名 : ', style: TextStyle(fontSize: 26)),
                  Text(name, style: const TextStyle(fontSize: 26))
                ],
              ),
              Row(
                children: [
                  const Text('確定年齢 : ', style: TextStyle(fontSize: 26)),
                  Text(age != null ? age.toString() : '',
                      style: const TextStyle(fontSize: 26))
                ],
              )
            ]),
      ),
    );
  }
}
