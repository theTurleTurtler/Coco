import 'package:coco/pages/apertura_exitosa_de_caso_page.dart';
import 'package:coco/pages/caso_detail_page.dart';
import 'package:coco/pages/casos_abiertos_page.dart';
import 'package:coco/pages/casos_page.dart';
import 'package:coco/pages/casos_requerimientos_enviados_page.dart';
import 'package:coco/pages/crear_caso_page.dart';
import 'package:coco/pages/home_page.dart';
import 'package:coco/pages/login_page.dart';
import 'package:coco/pages/register_page.dart';
import 'package:coco/pages/validacion_codigo_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: CasosPage.route,
      routes: {
        HomePage.route: (_)=>HomePage(),
        RegisterPage.route: (_)=>RegisterPage(),
        LoginPage.route: (_)=>LoginPage(),
        ValidacionCodigo.route: (_)=>ValidacionCodigo(),
        CasosPage.route: (_)=>CasosPage(),
        CasosAbiertosPage.route:(_)=>CasosAbiertosPage(),
        CasosRequerimientosEnviadosPage.route: (_)=>CasosRequerimientosEnviadosPage(),
        CasoDetailPage.route: (_)=>CasoDetailPage(),
        CrearCasoPage.route: (_)=>CrearCasoPage(),
        AperturaExitosaDeCasoPage.route: (_)=>AperturaExitosaDeCasoPage(),
      },
    );
  }
}