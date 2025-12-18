import 'package:bloc/bloc.dart';
import 'package:fpic_app/bloc/meta_event.dart';
import 'package:fpic_app/bloc/meta_state.dart';
import 'package:fpic_app/data/repository.dart';

class MetaBloc extends Bloc<MetaEvent, MetaState> {
  final Repository _repository;

  MetaBloc({required Repository repository})
      : assert(repository != null),
        _repository = repository,
        super(MetaLoading());

  @override
  MetaState get initialState => MetaLoading();

  @override
  Stream<MetaState> mapEventToState(MetaEvent event) async* {
    if (event is MetaRequested) {
      yield* _mapDataRequestedToState();
    }
  }

  Stream<MetaState> _mapDataRequestedToState() async* {
    yield MetaLoading();

    try {
      await _repository.loadMeta();
      yield MetaLoadingSuccess();
      await _repository.saveMetaOffline();
    } catch (e) {
      print(e);
      yield MetaLoadingFailure();
    }
  }
}
