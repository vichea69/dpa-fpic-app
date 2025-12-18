import 'package:equatable/equatable.dart';

abstract class MetaState extends Equatable {
  const MetaState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class MetaLoading extends MetaState {
  const MetaLoading();

  @override
  List<Object> get props => [];
}

class MetaLoadingFailure extends MetaState {}

class MetaLoadingSuccess extends MetaState {
  const MetaLoadingSuccess();

  // final List<dynamic> data;

  @override
  List<Object> get props => [];
}
