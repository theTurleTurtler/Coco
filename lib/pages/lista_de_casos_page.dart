import 'package:coco/blocs/casos/casos_bloc.dart';
import 'package:coco/widgets/casos/casos_abiertos_component.dart';
import 'package:flutter/material.dart';
import 'package:coco/enums/tipo_page_casos_list.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/casos/casos_con_requerim_enviados_component.dart';
import 'package:coco/widgets/casos/filtros.dart';
import 'package:coco/widgets/header_bar/header_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListaDeCasosPage extends StatefulWidget {

  static final String routeCasosAbiertos = 'casos_abiertos';
  static final String routeCasosConRequerimientosAbiertos = 'casos_requerimientos_enviados';

  final TiposDePageCasosList _tipoDePage;

  ListaDeCasosPage.casosAbiertos()
  : _tipoDePage = TiposDePageCasosList.CASOS_ABIERTOS
    ;
  
  ListaDeCasosPage.casosConReqEnviados()
  : _tipoDePage = TiposDePageCasosList.CASOS_REQUERIMIENTOS_ENVIADOS
    ;

  @override
  _ListaDeCasosPageState createState() => _ListaDeCasosPageState();
}

class _ListaDeCasosPageState extends State<ListaDeCasosPage> {
  SizeUtils _sizeUtils;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
       body:  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderBar(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _createComponenteSegunCargaDeCasos(),
            SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
            Filtros()
          ],
        ),
      )
    );
  }

  Widget _createComponenteSegunCargaDeCasos(){
    return BlocBuilder<CasosBloc, CasosState>(
      builder: (BuildContext context, CasosState state){
        if(state.estanCargados){
          return _createComponenteCasosSegunTipoPage();
        }else{
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).secondaryHeaderColor,
          );
        }
      },
    );
  }

  // ignore: missing_return
  Widget _createComponenteCasosSegunTipoPage(){
    switch(widget._tipoDePage){
      case TiposDePageCasosList.CASOS_ABIERTOS:
        return CasosAbiertosComponent(heightPercentaje: 0.8);
      break;
      case TiposDePageCasosList.CASOS_REQUERIMIENTOS_ENVIADOS:
        return CasosConRequerimEnviadosComponent(heightPercentaje: 0.8);
      break;
    }
  }

  
  void _initInitialConfiguration(BuildContext context){
    _sizeUtils = SizeUtils();
  }

}