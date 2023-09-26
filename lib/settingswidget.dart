import 'package:flutter/material.dart';
import 'package:mathtest/data.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key, required this.settingsdData});

  final SettingsData settingsdData;

  @override
  Widget build(BuildContext context) {
    final TextEditingController durationController =
        TextEditingController(text: settingsdData.duration.toString());
    final TextEditingController questionsController =
        TextEditingController(text: settingsdData.questions.toString());
    final TextEditingController orderController =
        TextEditingController(text: settingsdData.order.toString());
    return  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           const Card(child: Text("Настройки тестов",textScaleFactor: 3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(child: Text("Длительность теста:",textScaleFactor: 2.0)),
              Flexible(
                  child: DropdownMenu<String>(
                controller: durationController,
                hintText: "сек.",
                initialSelection: settingsdData.duration.toString(),
                onSelected: (value) =>
                    {settingsdData.duration = int.parse(value ?? durationController.text)},
                dropdownMenuEntries: ["30", "90", "180", "300", "600"]
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                      value: value, label: value);
                }).toList(),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(child: Text("Количество примеров:",textScaleFactor: 2.0)),
              Flexible(
                  child: DropdownMenu<String>(
                controller: questionsController,
                hintText: "кол.",
                initialSelection: settingsdData.questions.toString(),
                onSelected: (value) =>
                    {settingsdData.questions = int.parse(value ?? questionsController.text)},
                dropdownMenuEntries: ["5", "10", "25", "50", "100"]
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                      value: value, label: value);
                }).toList(),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(child: Text("Порядок чисел:",textScaleFactor: 2.0)),
              Flexible(
                  child: DropdownMenu<String>(
                controller: orderController,
                hintText: "кол.",
                initialSelection: settingsdData.order.toString(),
                onSelected: (value) =>
                    {settingsdData.order = int.parse(value ?? orderController.text)},
                dropdownMenuEntries: ["1", "2", "3", "4", "5"]
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                      value: value, label: value);
                }).toList(),
              ))
            ],
          ),
        ],
    );
  }
}
