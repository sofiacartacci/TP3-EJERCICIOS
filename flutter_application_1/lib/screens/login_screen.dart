import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<Map<String, String>> _mockUsers = const [
    {'username': 'juan', 'password': 'juan123'},
    {'username': 'maria', 'password': 'maria456'},
    {'username': 'sofiacartacci', 'password': '1234'}
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _login() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text;

    if (username.isEmpty) {
      _showMessage('Debe completar el campo Usuario');
      return;
    }

    if (password.isEmpty) {
      _showMessage('Debe completar el campo Contraseña');
      return;
    }

    final matches = _mockUsers.where(
      (user) => user['username'] == username && user['password'] == password,
    );

    if (matches.isEmpty) {
      _showMessage('Usuario o contraseña incorrectos');
      return;
    }

    Navigator.pushNamed(context, '/home', arguments: matches.first['username']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              onSubmitted: (_) => _login(),
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}