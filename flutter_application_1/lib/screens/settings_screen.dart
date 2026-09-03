import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificaciones = true;
  bool _aceptaTerminos = false;
  String _tema = 'claro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Notificaciones'),
            subtitle: const Text('Recibir avisos de la app'),
            value: _notificaciones,
            onChanged: (value) => setState(() => _notificaciones = value),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Tema', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          RadioGroup<String>(
            groupValue: _tema,
            onChanged: (value) => setState(() => _tema = value!),
            child: const Column(
              children: [
                RadioListTile(value: 'claro', title: Text('Claro')),
                RadioListTile(value: 'oscuro', title: Text('Oscuro')),
                RadioListTile(value: 'sistema', title: Text('Sistema')),
              ],
            ),
          ),
          const Divider(),
          CheckboxListTile(
            title: const Text('Acepto los términos y condiciones'),
            value: _aceptaTerminos,
            onChanged: (value) =>
                setState(() => _aceptaTerminos = value ?? false),
          ),
        ],
      ),
    );
  }
}