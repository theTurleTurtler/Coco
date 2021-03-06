import 'package:coco/blocs/multimedia_container/multimedia_container_bloc.dart';
import 'package:flutter/material.dart';
import 'package:coco/blocs/casos/casos_bloc.dart';
import 'package:coco/blocs/map/map_bloc.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/pages/apertura_exitosa_de_caso_page.dart';
import 'package:coco/pages/caso_detail_page.dart';
import 'package:coco/pages/casos_home_page.dart';
import 'package:coco/pages/lista_de_casos_page.dart';
import 'package:coco/pages/modificar_caso/modificar_caso_page.dart';
import 'package:coco/pages/login_page.dart';
import 'package:coco/pages/register_dashboard_page.dart';
import 'package:coco/pages/register_page.dart';
import 'package:coco/pages/validacion_codigo_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(create: (_)=>MapBloc()),
        BlocProvider<UserBloc>(create: (_)=>UserBloc()),
        BlocProvider<CasosBloc>(create: (_)=>CasosBloc()),
        BlocProvider<MultimediaContainerBloc>(create: (_)=>MultimediaContainerBloc())
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: CasosHomePage.route,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(14, 130, 167, 1),
          backgroundColor: Color.fromRGBO(245, 245, 245, 1),
          primaryColorDark: Color.fromRGBO(9, 115, 148, 1),
        ),
        routes: {
          LoginPage.route: (_)=>LoginPage(),
          RegisterDashBoardPage.route: (_)=>RegisterDashBoardPage(),
          RegisterPage.route: (_)=>RegisterPage(),       
          ValidacionCodigo.route: (_)=>ValidacionCodigo(),
          CasosHomePage.route: (_)=>CasosHomePage(),
          ListaDeCasosPage.routeCasosAbiertos: (_)=>ListaDeCasosPage.casosAbiertos(),
          ListaDeCasosPage.routeCasosConRequerimientosAbiertos: (_)=> ListaDeCasosPage.casosConReqEnviados(),
          CasoDetailPage.route: (_)=>CasoDetailPage(),
          ModificarCasoPage.routeCrear: (_)=>ModificarCasoPage.crear(),
          ModificarCasoPage.routeEditar: (_)=>ModificarCasoPage.editar(),
          ModificarCasoPage.routeAportar: (_)=>ModificarCasoPage.proponer(),
          AperturaExitosaDeCasoPage.route: (_)=>AperturaExitosaDeCasoPage(),
        },
      ),
    );
  }
}