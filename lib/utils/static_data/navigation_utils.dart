import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/pages/lista_de_casos_page.dart';
import 'package:coco/pages/login_page.dart';
import 'package:coco/pages/modificar_caso/modificar_caso_page.dart';

final List<Map<String, dynamic>> navigationMenuItems = [
  {
    'index':0,
    'name':'Crear Caso',
    'route':ModificarCasoPage.routeCrear
  },
  {
    'index':1,
    'name':'Casos Abiertos',
    'route':ListaDeCasosPage.routeCasosAbiertos
  },
  {
    'index':2,
    'name':'Consultar Casos',
    'route':ListaDeCasosPage.routeCasosConRequerimientosAbiertos
  },
  {
    'index':3,
    'name':'Mis Casos',
    'route':CasosHomePage.route
  },
  {
    'index':4,
    'name':'Salir',
    'route':LoginPage.route
  }
];