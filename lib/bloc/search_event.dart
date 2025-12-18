import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class SearchRequested extends SearchEvent {

  final String query;
  
  const SearchRequested(this.query);

  @override
  List<Object> get props => [this.query];
}