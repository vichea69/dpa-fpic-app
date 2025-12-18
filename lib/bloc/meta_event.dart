import 'package:equatable/equatable.dart';

abstract class MetaEvent extends Equatable {
  const MetaEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class MetaRequested extends MetaEvent {
  const MetaRequested();

  @override
  List<Object> get props => [];
}
