part of 'casos_bloc.dart';

@immutable
class CasosState {
  final bool cargados;
  final List<Caso> casos;

  CasosState({
    bool cargados,
    List<Caso> casos
  }):
    this.cargados = cargados??false,
    this.casos = casos??null
    ;

  CasosState copyWith({
    bool cargados,
    List<Caso> casos
  }) => CasosState(
    cargados: cargados??this.cargados,
    casos: casos??this.casos
  );
}
