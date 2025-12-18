import 'package:bloc/bloc.dart';

import '../main.dart';

class LocalizationCubit extends Cubit<Localization> {
  // Default app language set to Khmer
  LocalizationCubit() : super(Localization.Khmer);

  final Localization _localization = Localization.Khmer;

  void setLocalization(Localization localization) => emit(localization);

  Localization getLocalization() => _localization;
}
