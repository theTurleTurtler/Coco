import 'package:flutter/material.dart';
import 'package:coco/utils/size_utils.dart';
import 'package:coco/utils/static_data/strings_utils.dart' as strings;

class Filtros extends StatefulWidget {

  @override
  _FiltrosState createState() => _FiltrosState();
}

class _FiltrosState extends State<Filtros> {
  SizeUtils _sizeUtils;
  String _currentFiltro;
  String _currentOrden;

  @override
  Widget build(BuildContext context) {
    _initInitialConfiguration(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _sizeUtils.xasisSobreYasis * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _crearSelectFiltro(),
          _crearSelectOrden()
        ],
      ),
    );
  }

  void _initInitialConfiguration(BuildContext context){
    _sizeUtils = SizeUtils();
  }

  Widget _crearSelectFiltro(){
    final List<String> items = strings.casosFiltros;
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createLabel('Filtrar por'),
              _crearSelect(items, 0)
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearSelectOrden(){
    final List<String> items = strings.casosOrdenes;
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createLabel('Orden'),
              _crearSelect(items, 1)
            ],
          ),
        ],
      ),
    );
  }

  Widget _createLabel(String text){
    return Text(
      text,
      style: TextStyle(
        fontSize: _sizeUtils.subtitleSize
      ),
    );
  }

  Widget _crearSelect(List<String> itemsNames, int indexFiltro){
    String value = (indexFiltro == 0)? _currentFiltro : _currentOrden;
    List<DropdownMenuItem<String>> items = _createSelectItems(itemsNames);
    return DropdownButton<String>(
      value: value,
      items: items,
      onChanged: (String newValue){
        if(indexFiltro == 0){
          _currentFiltro = newValue;
        }else if(indexFiltro == 1){
          _currentOrden = newValue;
        }
        setState(() {
          
        });
      },
      hint: _createSelectHint(indexFiltro)
    );
  }

  List<DropdownMenuItem<String>> _createSelectItems(List<String> itemsNames){
    List<DropdownMenuItem<String>> items = [];
    itemsNames.forEach((String currentName) {
      DropdownMenuItem<String> currentItem = DropdownMenuItem<String>(
        value: currentName,
        child: Text(
          currentName
        ),
      );
      items.add(currentItem);
    });
    return items;
  }

  Widget _createSelectHint(int indexFiltro){
    return Container(
      width: _sizeUtils.xasisSobreYasis * 0.19,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Text((indexFiltro == 0? _currentFiltro : _currentOrden)??''),
        ],
      ),
    );
  }
}