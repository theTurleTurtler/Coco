import 'package:coco/pages/casos_abiertos_page.dart';
import 'package:coco/pages/casos_requerimientos_enviados_page.dart';
import 'package:coco/pages/crear_caso_page.dart';
import 'package:coco/pages/home_page.dart';

final List<Map<String, dynamic>> navigationMenuItems = [
  {
    'name':'Crear Caso',
    'route':CrearCasoPage.route
  },
  {
    'name':'Casos Abiertos',
    'route':CasosAbiertosPage.route
  },
  {
    'name':'Consultar Casos',
    'route':CasosRequerimientosEnviadosPage.route
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