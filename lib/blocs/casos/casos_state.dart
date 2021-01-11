part of 'casos_bloc.dart';

@immutable
class CasosState {
  final bool estanCargados;
  final List<Caso> casos;

  CasosState({
    bool estanCargados,
    List<Caso> casos
  }):
    this.estanCargados = estanCargados??false,
    this.casos = casos??null
    ;

  CasosState copyWith({
    bool estanCargados,
    List<Caso> casos
  }) => CasosState(
    estanCargados: estanCargados??this.estanCargados,
    casos: casos??this.casos
  );
}
