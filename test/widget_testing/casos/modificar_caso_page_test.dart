import 'package:coco/models/caso.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coco/pages/modificar_caso_page.dart';

final String _editarCasoPageDescription = 'Se testea el widget de editar caso.';
final Caso _testingCaso = Caso(
  titulo: 'Caso x',
  descripcion: 'Descripción del caso x',
  tipoDeSolicitud: 'Denuncia',
  conoceDatosDeEntidadDestino: false,
  estado: 'Abierto',
  fechaPublicacion: DateTime.now(),
  direccion: 'Bogotá, calle 40a # 13a-2 a 13a-66', 
  latitud:4.628900449318187, 
  longitud: -74.06815559290192,
  multimediaItems: []
);

class _ModificarCasoPageMock extends ModificarCasoPage{

  _ModificarCasoPageMock.crear()
  : super.crear()
    ;
  
  _ModificarCasoPageMock.editar()
  : super.editar()
    ;
  
  _ModificarCasoPageMock.proponer()
  : super.proponer()
    ;

  @override
  void _initCaso(){
    this.caso = _testingCaso;
  }
}

void main(){
  _testEditarCasoPage();
}

void _testEditarCasoPage(){
  testWidgets(_editarCasoPageDescription, (WidgetTester tester)async{
    await tester.pumpWidget(ModificarCasoPage.editar());

    expect(find.text('EDITAR CASO'), findsOneWidget);

  });
}