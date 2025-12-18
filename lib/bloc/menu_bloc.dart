import 'package:bloc/bloc.dart';
import 'package:fpic_app/bloc/menu_event.dart';
import 'package:fpic_app/bloc/menu_state.dart';
import 'package:fpic_app/data/repository.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc({required Repository repository})
      : assert(repository != null),
        _repository = repository,
        super(MenuLoading());

  final Repository _repository;

  @override
  MenuState get initialState => MenuLoading();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is MenuRequested) {
      yield* _mapDataRequestedToState();
    }
  }

  Stream<MenuState> _mapDataRequestedToState() async* {
    yield MenuLoading();

    try {
      await _repository.loadMenus();
      await _repository.loadPages();
      yield MenuLoadingSuccess();
      await _repository.saveOffline();
    } catch (e) {
      print(e);
      yield MenuLoadingFailure();
    }
  }
}
