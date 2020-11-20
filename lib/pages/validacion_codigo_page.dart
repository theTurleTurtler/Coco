import 'package:coco/utils/size_utils.dart';
import 'package:flutter/material.dart';

class ValidacionCodigo extends StatelessWidget {
  static final route = 'validacion_codigo';
  BuildContext _context;
  SizeUtils _sizeUtils;
  TextEditingController _codeController;


  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: _crearComponentes(),
      )
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _context = context;
    final Size size = MediaQuery.of(_context).size;
    _sizeUtils = SizeUtils();
    _sizeUtils.initUtil(size);
    _codeController = new TextEditingController();
  }

  Widget _crearComponentes(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _sizeUtils.largeHorizontalScaffoldPadding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: _sizeUtils.xasisSobreYasis * 0.4),
            _crearTitulo(),
            SizedBox(height: _sizeUtils.normalSizedBoxHeigh),
            _crearCodeInput()
          ],
        ),
      ),
    );
  }

  Widget _crearTitulo(){
    return Center(
      child: Text(
        'Código de validación',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: _sizeUtils.titleSize
        ),
      ),
    );
  }

  Widget _crearCodeInput(){
    return TextField(
      controller: _codeController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder()
      ),
    );
  }
}