import 'package:coco/blocs/casos/casos_services_manager.dart';
import 'package:coco/blocs/user/user_bloc.dart';
import 'package:coco/enums/account_step.dart';
import 'package:coco/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coco/blocs/casos/casos_bloc.dart';
import 'package:coco/models/caso.dart';
import 'package:coco/pages/lista_de_casos_page.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/widgets/casos/caso_card.dart';
import 'package:coco/enums/casos_types.dart';

// ignore: must_be_immutable
class MuestraCasos extends StatelessWidget {
  final CasosTypes _casoType;
  final String _titulo;
  final String _rutaDeNavegacionEnBotonMas;

  List<Caso> _casos;
  BuildContext _context;
  SizeUtils _sizeUtils;
  CasosServicesManager _casosServicesManager;

  MuestraCasos.abiertos()
      : _casoType = CasosTypes.Abierto,
        _titulo = "CASOS ABIERTOS",
        _rutaDeNavegacionEnBotonMas = ListaDeCasosPage.routeCasosAbiertos;

  MuestraCasos.requerimientosEnviados()
      : _casoType = CasosTypes.RequerimientosEnviados,
        _titulo = "REQUERIMIENTOS ENVIADOS",
        _rutaDeNavegacionEnBotonMas =
            ListaDeCasosPage.routeCasosConRequerimientosAbiertos;

  @override
  Widget build(BuildContext appContext) {
    _initInitialElements(appContext);
    return Container(
      child: Column(
        children: [
          _crearTitulo(),
          SizedBox(height: _sizeUtils.littleSizedBoxHeigh),
          _crearCasosCards(),
          _crearBotonVerMas()
        ],
      ),
    );
  }

  void _initInitialElements(BuildContext appContext) {
    _context = appContext;
    _sizeUtils = SizeUtils();
    _casosServicesManager = CasosServicesManager(appContext: appContext);
  }

  Widget _crearTitulo() {
    return Center(
      child: Text(
        _titulo,
        style: TextStyle(fontSize: _sizeUtils.titleSize, color: Colors.black54),
      ),
    );
  }

  Widget _crearCasosCards() {
    return BlocBuilder<CasosBloc, CasosState>(
      builder: (BuildContext context, CasosState state) {
        if(state.estanCargados) {
          final List<CasoCard> casosWidgets = _definirCasosWidgets(state);
          return Container(
            height: _sizeUtils.xasisSobreYasis * 0.38,
            width: double.infinity,
            child: ListView(
              children: casosWidgets,
            )
          );
        }else {
          _casosServicesManager.loadPublicCasos();
          return _createEspacioVacio();
        }
      },
    );
  }

  Widget _createEspacioVacio(){
    return Container(
      height: _sizeUtils.xasisSobreYasis * 0.38,
      width: double.infinity,
      color: Theme.of(_context).secondaryHeaderColor,
    );
  }

  List<CasoCard> _definirCasosWidgets(CasosState state) {
    _casos = state.casos;
    List<CasoCard> _casosWidgets = [];
    for (int i = 0; i < 2; i++) {
      final Caso caso = _casos[i];
      final CasoCard casoCard = CasoCard(caso: caso);
      _casosWidgets.add(casoCard);
    }
    return _casosWidgets;
  }

  Widget _crearBotonVerMas() {
    return FlatButton(
      child: Text(
        'Más...',
        style: TextStyle(fontSize: _sizeUtils.subtitleSize),
      ),
      onPressed: () {
        final UserBloc userBloc = BlocProvider.of<UserBloc>(_context);
        if(userBloc.state.accountStep == AccountStep.LOGGED)
          Navigator.of(_context).pushNamed(_rutaDeNavegacionEnBotonMas);
        else
          Navigator.of(_context).pushNamed(LoginPage.route);
      },
    );
  }
}
