import 'package:flutter/material.dart';

import '../entities/destino.dart';

class DetailScreen extends StatefulWidget {
  final Destino destino;

  const DetailScreen({super.key, required this.destino});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    final destino = widget.destino;

    return Scaffold(
      appBar: AppBar(title: Text(destino.nombre)),
      body: SingleChildScrollView(
        // ← NUEVO
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: destino.imagenes.length,
                onPageChanged: (index) => setState(() => _paginaActual = index),
                itemBuilder: (context, index) {
                  return Image.network(
                    destino.imagenes[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, progress) =>
                        progress == null
                        ? child
                        : const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                destino.imagenes.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _paginaActual == index ? 12 : 8,
                  height: _paginaActual == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _paginaActual == index
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                destino.descripcion,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ), // ← cierre del ScrollView
    );
  }
}
