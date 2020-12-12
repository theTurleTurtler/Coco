import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/pages/lista_de_casos_page.dart';
import 'package:coco/pages/login_page.dart';
import 'package:coco/pages/modificar_caso_page.dart';

final List<Map<String, dynamic>> navigationMenuItems = [
  {
    'name':'Crear Caso',
    'route':ModificarCasoPage.routeCrear
  },
  {
    'name':'Casos Abiertos',
    'route':ListaDeCasosPage.routeCasosAbiertos
  },
  {
    'name':'Consultar Casos',
    'route':ListaDeCasosPage.routeCasosConRequerimientosAbiertos
  },
  {
    'name':'Mis Casos',
    'route':CasosHomePage.route
  },
  {
    'name':'Salir',
    'route':LoginPage.route
  }
];