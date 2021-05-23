import 'package:bloc/bloc.dart';

class MainBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');

    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    print('${bloc.runtimeType} $bloc');

    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    print('${bloc.runtimeType} $error $stacktrace');

    super.onError(bloc, error, stacktrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('${bloc.runtimeType} $event');

    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');

    super.onTransition(bloc, transition);
  }
}
