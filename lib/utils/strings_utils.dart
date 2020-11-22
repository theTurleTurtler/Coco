import 'package:coco/pages/crear_caso_page.dart';
import 'package:coco/pages/home_page.dart';

final String homeTextoPrincipal = 'Solicita a través de ### respuestas sobre temas de interés en tu comunidad a entidades del estado.';
final String homeTextoSecundario = 'Las peticiones serán realizadas a nombre de #### y se omitirán los datos de los ciudadanos que aporten y participen en los casos.';

final String aperturaExitosaTextoPrincipal = '¡Muchas garcias!';
final String aperturaExitosaTextoSecundario = 'Su caso ha sido abierto.';
final String aperturaExitosaTextoTerciario = 'Le notificaremos los aportes realizados (si los hay) por otros ciudadanos y el momento en que se envíe la solicitud a la entidad correspondiente, al igual que toda respuesta recibida a este caso.';

final List<Map<String, dynamic>> navigationMenuItems = [
  {
    'name':'Crear Caso',
    'route':CrearCasoPage.route
  },
  {
    'name':'Casos Abiertos',
    'route':HomePage.route
  },
  {
    'name':'Consultar Casos',
    'route':HomePage.route
  },
  {
    'name':'Mis Casos',
    'route':HomePage.route
  },
  {
    'name':'Salir',
    'route':HomePage.route
  }
];

List<String> tiposDeSolicitud = [
  'Derecho de petición',
  'otra más',
  'la última'
];