import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/bloc/meta_bloc.dart';
import 'package:fpic_app/bloc/meta_event.dart';
import 'package:fpic_app/bloc/meta_state.dart';

abstract class LifecycleWatcherState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        BlocProvider.of<MetaBloc>(context).add(const MetaRequested());
        BlocProvider.of<MetaBloc>(context).stream.listen((MetaState state) {
          if (state is MetaLoadingSuccess) {
            if (mounted) {
              Navigator.popUntil(
                  context, (Route<dynamic> route) => route.isFirst);
            }
          }
        });
        break;
      default:
    }
  }
}
