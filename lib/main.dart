import 'package:flutter/material.dart';
import 'package:mathtest/data.dart';
import 'package:mathtest/mathtestwidget.dart';
import 'package:mathtest/settingswidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тесты по математике',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Математика'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SettingsData settingsData = SettingsData();
  TextEditingController answerController = TextEditingController();
  int a = 1;
  int b = 1;
  bool setup = true;
  Widget body = const Scaffold();

  @override
  Widget build(BuildContext context) {
    setup
        ? body = SettingsWidget(settingsdData: settingsData)
        : body = MathTestWidget(
            settingsData: settingsData,
          );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          setup
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("Настройки"))
              : Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () => {_editSettings()},
                      child: const Icon(Icons.settings)))
        ],
      ),
      body: body,
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            setup
                ? ElevatedButton(
                    onPressed: () => {_saveSettings()},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent)),
                    child: const Text(
                      "Начать тест",
                      textScaleFactor: 3.0,
                    ))
                : const Text("")
          ],
        )
      ], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _editSettings() {
    setState(() {
      setup = true;
    });
  }

  _saveSettings() {
    setState(() {
      setup = false;
    });
  }
}
