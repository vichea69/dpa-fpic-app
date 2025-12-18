import 'package:bloc/bloc.dart';
import 'package:fpic_app/bloc/search_event.dart';
import 'package:fpic_app/bloc/search_state.dart';
import 'package:fpic_app/data/repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required Repository repository})
      : assert(repository != null),
        _repository = repository,
        super(SearchLoading());

  final Repository _repository;

  @override
  SearchState get initialState => SearchLoading();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchRequested) {
      var query = event.query;
      yield* _mapSearchRequestedToState(query);
    }
  }

  Stream<SearchState> _mapSearchRequestedToState(String query) async* {
    yield SearchLoading();

    try {
      var data = []; //await _repository.searchData(query);
      yield SearchLoadingSuccess(data);
    } catch (e) {
      yield SearchLoadingFailure();
    }
  }
}
