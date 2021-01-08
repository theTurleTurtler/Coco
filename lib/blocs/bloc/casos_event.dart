part of 'casos_bloc.dart';

@immutable
abstract class CasosEvent {}

class SetCasos extends CasosEvent{
  final List<Caso> casos;
  SetCasos({
    @required this.casos
  });
}
