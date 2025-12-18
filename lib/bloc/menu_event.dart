import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class MenuRequested extends MenuEvent {
  const MenuRequested();

  @override
  List<Object> get props => [];
}
