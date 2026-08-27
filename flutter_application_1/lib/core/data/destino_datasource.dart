import '../../entities/destino.dart';

class DestinoDatasource {
  static final List<Destino> destinos = [
    Destino(
      nombre: 'Bariloche',
      descripcion: 'Ciudad patagónica a orillas del Nahuel Huapi, famosa por sus paisajes de montaña, el chocolate y los deportes de invierno.',
      imagenes: [
        'https://picsum.photos/id/1015/600/400',
        'https://picsum.photos/id/1016/600/400',
        'https://picsum.photos/id/1018/600/400',
      ],
    ),
    Destino(
      nombre: 'Cataratas del Iguazú',
      descripcion: 'Una de las siete maravillas naturales del mundo, con más de 270 saltos de agua en plena selva misionera.',
      imagenes: [
        'https://picsum.photos/id/1039/600/400',
        'https://picsum.photos/id/1043/600/400',
        'https://picsum.photos/id/1044/600/400',
      ],
    ),
    Destino(
      nombre: 'Mendoza',
      descripcion: 'Tierra del sol y del buen vino, al pie de la cordillera de los Andes. Ideal para bodegas, montañismo y gastronomía.',
      imagenes: [
        'https://picsum.photos/id/1050/600/400',
        'https://picsum.photos/id/1052/600/400',
        'https://picsum.photos/id/1056/600/400',
      ],
    ),
    Destino(
      nombre: 'El Calafate',
      descripcion: 'Puerta de entrada al glaciar Perito Moreno, uno de los pocos glaciares del mundo que sigue avanzando.',
      imagenes: [
        'https://picsum.photos/id/1060/600/400',
        'https://picsum.photos/id/1061/600/400',
        'https://picsum.photos/id/1063/600/400',
      ],
    ),
  ];
}
