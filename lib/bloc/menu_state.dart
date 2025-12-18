import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class MenuLoading extends MenuState {
  const MenuLoading();

  @override
  List<Object> get props => [];
}

class MenuLoadingFailure extends MenuState {}

class MenuLoadingSuccess extends MenuState {
  const MenuLoadingSuccess();

  // final List<dynamic> data;

  @override
  List<Object> get props => [];
}
