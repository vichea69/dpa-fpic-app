import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/bloc/meta_bloc.dart';
import 'package:fpic_app/bloc/meta_state.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/data/repository.dart';
import 'package:fpic_app/screens/loading_screen.dart';
import 'package:fpic_app/screens/main_screen.dart';
import 'package:fpic_app/screens/root_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/menu_bloc.dart';
import 'bloc/menu_event.dart';
import 'bloc/meta_event.dart';
import 'data/menu.dart';
import 'data/menupage.dart';
import 'data/meta.dart';
import 'network_checker.dart';
import 'screens/error_screen.dart';

enum Localization { Unknown, Khmer, English }

class App {
  static late SharedPreferences localStorage;
  static late NetworkChecker checker;
  static List<Menu> menus = [];
  static Meta? meta;
  static List<MenuPage> pages = [];
  static ValueNotifier<int> tabIndex = ValueNotifier<int>(0);

  static Future<void> init() async {
    localStorage = await SharedPreferences.getInstance();
    checker = NetworkChecker();
    // Initialize other variables if necessary
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await App.init();

  runApp(FPICApp(repository: Repository()));
}

class FPICApp extends StatelessWidget {
  const FPICApp({super.key, required this.repository})
      : assert(repository != null);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    print(repository);
    return MultiBlocProvider(providers: [
      BlocProvider<MetaBloc>(
        create: (BuildContext context) =>
            MetaBloc(repository: repository)..add(const MetaRequested()),
      ),
      BlocProvider<MenuBloc>(
        create: (BuildContext context) => MenuBloc(repository: repository),
      ),
      BlocProvider<LocalizationCubit>(
          create: (BuildContext context) => LocalizationCubit())
    ], child: FPICAppView());
  }
}

class FPICAppView extends StatefulWidget {
  @override
  _FPICAppViewState createState() => _FPICAppViewState();
}

class _FPICAppViewState extends State<FPICAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<MetaBloc, MetaState>(
          builder: (BuildContext context, MetaState state) {
        if (state is MetaLoading) {
          BlocProvider.of<MenuBloc>(context).add(const MenuRequested());

          return LoadingScreen();
        }
        if (state is MetaLoadingSuccess) {
          return const RootScreen();
        }
        if (state is MetaLoadingFailure) {
          return ErrorScreen();
        }
        return Container();
      }),
    );
  }
}
