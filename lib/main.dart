import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_posts_redux/localizations.dart';
import 'package:flutter_posts_redux/redux/app/app_actions.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/store.dart';
import 'package:flutter_posts_redux/ui/dashboard/dashboard.dart';
import 'package:flutter_posts_redux/ui/login/login.dart';
import 'package:flutter_posts_redux/ui/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store = createStore();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
            theme: new ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('es', ''),
            ],
            localeResolutionCallback:
                (Locale locale, Iterable<Locale> supportedLocales) {
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            /*routes: <String, WidgetBuilder> {
             '/': (BuildContext context) => SplashScreen(),
              LoginScreen.route : (BuildContext context) => LoginScreen(),
              DashboardScreen.route : (BuildContext context) => DashboardScreen()
            },*/
            home:

            StoreConnector<AppState, _SessionStateViewModel>(
                converter: _SessionStateViewModel.fromStore,
                onInit: (store) { store.dispatch(SessionStarted());},
                // need to pass the context from the builder, so we can show snackbar
                // which doesnt work with the same context that the created the scaffold
                builder: (context, vm) => _showScreen(vm)

            )));
  }

  Widget _showScreen(_SessionStateViewModel vm) {
    if (vm.sessionState == SessionState.Uninitialized) {
      return SplashScreen();
    }

    if (vm.sessionState == SessionState.UnAuthenticated) {
      return LoginScreen();
    }

    if (vm.sessionState == SessionState.Authenticated) {
      return DashboardScreen();
    }
  }
}

class _SessionStateViewModel {
  final SessionState sessionState;

  _SessionStateViewModel(this.sessionState);

  static _SessionStateViewModel fromStore(Store<AppState> store) {
    return _SessionStateViewModel(store.state.sessionState);
  }

}
