import 'package:flutter/material.dart';

import '../core/data/destino_datasource.dart';
import '../entities/destino.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Copia mutable: así podemos eliminar sin tocar la lista original
  final List<Destino> _destinos = List.of(DestinoDatasource.destinos);

  void _confirmarEliminar(Destino destino) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar'),
        content: Text('¿Querés eliminar "${destino.nombre}" de la lista?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _destinos.remove(destino));
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido/a ${widget.username}')),
      body: ListView.builder(
        itemCount: _destinos.length,
        itemBuilder: (context, index) {
          final destino = _destinos[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(destino.imagenes.first),
            ),
            title: Text(destino.nombre),
            onTap: () =>
                Navigator.pushNamed(context, '/detail', arguments: destino),
            onLongPress: () => _confirmarEliminar(destino),
          );
        },
      ),
    );
  }
}
