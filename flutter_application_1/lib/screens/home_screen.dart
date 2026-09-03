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
  final List<Destino> _destinos = List.of(DestinoDatasource.destinos);
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    // Simulamos una carga de 3 segundos, como si viniera de un backend
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _cargando = false);
    });
  }

  // Doble confirmación para eliminar
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
              Navigator.pop(context);
              _confirmarEliminarDefinitivo(destino); // segundo check
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _confirmarEliminarDefinitivo(Destino destino) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Estás segura?'),
        content: Text(
            'Se va a eliminar "${destino.nombre}" definitivamente. Esta acción no se puede deshacer.'),
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
            child: const Text('Sí, eliminar'),
          ),
        ],
      ),
    );
  }

  // FAB: agregar un destino nuevo
  void _agregarDestino() {
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo destino'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final nombre = nombreController.text.trim();
              if (nombre.isEmpty) return;
              setState(() {
                _destinos.add(Destino(
                  nombre: nombre,
                  descripcion: descripcionController.text.trim(),
                  imagenes: [
                    'https://picsum.photos/seed/$nombre/600/400',
                    'https://picsum.photos/seed/${nombre}2/600/400',
                    'https://picsum.photos/seed/${nombre}3/600/400',
                  ],
                ));
              });
              Navigator.pop(context);
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido/a ${widget.username}')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Text(
                'Hola, ${widget.username}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => Navigator.pop(context), // ya estamos acá
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // cierra el drawer
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: _cargando
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando destinos...'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _destinos.length,
              itemBuilder: (context, index) {
                final destino = _destinos[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(destino.imagenes.first),
                  ),
                  title: Text(destino.nombre),
                  onTap: () => Navigator.pushNamed(context, '/detail',
                      arguments: destino),
                  onLongPress: () => _confirmarEliminar(destino),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarDestino,
        child: const Icon(Icons.add),
      ),
    );
  }
}