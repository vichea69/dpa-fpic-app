import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class SearchLoading extends SearchState {
  const SearchLoading();

  @override
  List<Object> get props => [];
}

class SearchLoadingFailure extends SearchState {}

class SearchLoadingSuccess extends SearchState {

  final List<dynamic> data;

  const SearchLoadingSuccess(this.data);

  @override
  List<Object> get props => [];
}