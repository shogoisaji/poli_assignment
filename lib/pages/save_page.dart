import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:politec_assignment/domain/user_data.dart';
import 'package:politec_assignment/featrue/save_functions.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'データ入力',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              inputText('氏名 : ', _nameController),
              inputText('年齢 : ', _ageController),
              inputText('メール : ', _mailController),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
// save
                  customButton('save', () async {
                    if (_nameController.text.isEmpty ||
                        _ageController.text.isEmpty ||
                        _mailController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('すべて入力してください'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'))
                              ],
                            );
                          });
                    } else {
                      final jsonData = await saveFunction(_nameController.text,
                          int.parse(_ageController.text), _mailController.text);
                      debugPrint(jsonData);
                      if (context.mounted) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '保存完了',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      '氏名 : ${_nameController.text}\n年齢 : ${_ageController.text}\nメール : ${_mailController.text}',
                                      style: const TextStyle(fontSize: 24)),
                                ],
                              ),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                      _nameController.clear();
                      _ageController.clear();
                      _mailController.clear();
                    }
                  }),
// clear
                  customButton('clear', () {
                    _nameController.clear();
                    _ageController.clear();
                    _mailController.clear();
                  }),
// load
                  customButton('load', () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: AlertDialog(
                            title: const Text('データ一覧'),
                            content: FutureBuilder<List<UserData>>(
                              future: checkPrefs(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<UserData>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  List<UserData> users = snapshot.data ?? [];
                                  return Column(
                                    children: users
                                        .map((user) => ListTile(
                                              tileColor: Colors
                                                  .teal[100 * (user.id % 9)],
                                              title: Text(user.name),
                                              subtitle:
                                                  Text("mail : ${user.mail}"),
                                              leading: const Icon(
                                                  Icons.account_circle),
                                              trailing: IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () async {
                                                  await deleteData(
                                                      "user${(user.id).toString()}");
                                                  debugPrint(
                                                      ("user${(user.id).toString()}"));
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Center(
                                                          child: Text(
                                                              '${user.name}のデータを削除しました',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          24)),
                                                        ),
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                      ),
                                                    );
                                                  }
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ))
                                        .toList(),
                                  );
                                }
                              },
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('back'))
                            ],
                          ),
                        );
                      },
                    );
                  }),
// delete
                  customButton('delete', () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('すべてのデータを削除しますか？'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('キャンセル')),
                              ElevatedButton(
                                  onPressed: () async {
                                    await deleteAll();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Center(
                                            child: Text('すべてのデータを削除しました',
                                                style: TextStyle(fontSize: 24)),
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('OK')),
                            ],
                          );
                        });
                  }),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
// animation
              Container(
                child: Lottie.asset(
                  'assets/Flow.json',
                  controller: _controller,
                  width: 200,
                  height: 200,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..repeat();
                  },
                ),
              )
                  .animate()
                  .scale(begin: Offset(0.01, 0.01), end: Offset(2, 2))
                  .shake(
                      duration: const Duration(days: 15),
                      hz: 0.2,
                      rotation: 0.4,
                      offset: const Offset(450, 120.5)),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget inputText(String label, TextEditingController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(label),
      SizedBox(
        width: 180,
        child: label == '年齢 : '
            ? TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: controller,
              )
            : TextField(
                controller: controller,
              ),
      )
    ],
  );
}

Widget customButton(String label, VoidCallback onPressed) {
  return ElevatedButton(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.purple),
    ),
    onPressed: onPressed,
    child: Text(label, style: const TextStyle(fontSize: 18)),
  );
}
