import 'package:coco/models/caso.dart';

final List<Caso> casosAbiertos = [
  Caso.fromJson(
    json: {
      'titulo':'Venta de celulares robados en la av. cll 68 con cra 15',
      'descripcion':'Venden celulares a un precio sospechosamente bajo. Los ladrones llegan a las 2:30AM a dejar la nueva mercancía cada viernes.',
      'fecha_publicacion':DateTime(2020,2,1),
      'ciudad':'Bogotá',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'Compras ilegales por uniformados en bosa la estación',
      'descripcion':'A la casa mostrada en la imágen, constantemente llegan uniformados a comprar empanadas de manera ilegal, a medianas horas de la madrugada.',
      'fecha_publicacion':DateTime(2020, 5, 20),
      'ciudad':'Bogotá',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'Bullicia desmedida por metaleros en Sabaneta',
      'descripcion':'De lunes a viernes, a las 2AM, se reunen en esa casa, con camisetas de metallica y acdc, compran una cantidad absurda de licor, ponen amplificadores de concierto, y se ponen a ver pasión de gavilanes a todo volúmen.',
      'fecha_publicacion':DateTime(2020, 6, 5),
      'ciudad':'Medellin',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'Restaurante chino sirviendo comidas de dudable procedencia en cll 20 con cra 18',
      'descripcion':'Desde que llegó ese restaurante, las ratas del vecindario se comenzaron a desaparecer. Antes se veía pasar un ratón de vez en vez. Ahora, temo que la fauna del área esté demasiado degenerada.',
      'fecha_publicacion':DateTime(2020, 6, 25),
      'ciudad':'Cali',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'Se exporta droga en las lechonas',
      'descripcion':'Se hace una lechona cada 2 días, desde la ventana se puede ver claramente cómo se llena de cocaína.',
      'fecha_publicacion':DateTime(2020, 7, 10),
      'ciudad':'Cali',
      'estado':'abierto'
    }
  )
];

final List<Caso> casosConRequerimientosEnviados = [
  Caso.fromJson(
    json: {
      'titulo':'Venta de computadores robados',
      'descripcion':'Venden computadores a un precio sospechosamente bajo. Los ladrones llegan a las 2:30AM a dejar la nueva mercancía cada viernes.',
      'fecha_publicacion':DateTime(2020,2,1),
      'ciudad':'Bogotá',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'Compras ilegales por uniformados',
      'descripcion':'A la casa mostrada en la imágen, constantemente llegan uniformados a comprar tamales de manera ilegal, a medianas horas de la madrugada.',
      'fecha_publicacion':DateTime(2020, 5, 20),
      'ciudad':'Bogotá',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'Extorsión a vendedores en la cll 15 con cra 20',
      'descripcion':'Hay un tipo y una tipa que vienen un día a la semana a cobrar una cuota a los vendedores que se ubican en toda la cuadra.',
      'fecha_publicacion':DateTime(2020, 6, 5),
      'ciudad':'Medellin',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'robos constantes en la esquna de la cuadra de la cll 50 con cra 30',
      'descripcion':'Hay un tipo que viene a robar en la esquina de la cuadra cada cierto número de días, por lo general en horas de la tarde.',
      'fecha_publicacion':DateTime(2020, 6, 25),
      'ciudad':'Cali',
      'estado':'abierto'
    }
  ),
  Caso.fromJson(
    json: {
      'titulo':'Venta de animales ilegales en la cra 30 con cll 15',
      'descripcion':'Se vende todo tipo de animales ilegales. Desde guacamayas, hasta caimanes.',
      'fecha_publicacion':DateTime(2020, 7, 10),
      'ciudad':'Cali',
      'estado':'abierto'
    }
  )
];