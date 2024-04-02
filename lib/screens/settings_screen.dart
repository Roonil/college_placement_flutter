import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 4,
                color: Colors.blue,
                onSelectFocus: false,
                onSelect: () {
                  showColorPickerDialog(
                    context,
                    Colors.red,
                    wheelDiameter: 155,
                    wheelSquareBorderRadius: 12,
                    wheelWidth: 10,
                    wheelHasBorder: true,
                    wheelSquarePadding: 8,
                    pickersEnabled: const <ColorPickerType, bool>{
                      ColorPickerType.primary: false,
                      ColorPickerType.accent: false,
                      ColorPickerType.wheel: true,
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
