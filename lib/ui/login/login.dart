import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posts_redux/localizations.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/login/login_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;

  Widget _pageToDisplay(BuildContext context, Store store, _LoginViewModel vm) {
    if (vm.isLoading) {
      return _loadingView;
    } else {
      return Form(
          key: _formKey,
          child: _loginView(
              context, store, vm) // We'll build this out in the next steps!
          );
    }
  }

  Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget _loginView(BuildContext context, Store store, _LoginViewModel vm) {
    return SafeArea(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.instance.text('login_username'),
                    hintText:
                        AppLocalizations.instance.text('login_username_hint'),
                  ),
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.instance.text('login_enter_username')
                      : null,
                  onSaved: (val) => _username = val),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.instance.text('login_password'),
                  hintText:
                      AppLocalizations.instance.text('login_password_hint'),
                ),
                validator: (val) => val.isEmpty
                    ? AppLocalizations.instance.text('login_enter_password')
                    : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment(0.0, 1.0),
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            vm.onLoginPressed(context, _username, _password);
                          }
                        },
                        child: Text(
                            AppLocalizations.instance.text('login_button')),
                      )))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // hide the back
          title: Text(
            AppLocalizations.instance.text('login_title'),
          ),
        ),
        body: StoreConnector<AppState, _LoginViewModel>(
          converter: _LoginViewModel.fromStore,
          // need to pass the context from the builder, so we can show snackbar
          // which doesnt work with the same context that the created the scaffold
          builder: (context, vm) => _pageToDisplay(context, store, vm),
        ));
  }
}

class _LoginViewModel {
  final bool isLoading;
  final Function(BuildContext, String, String) onLoginPressed;

  _LoginViewModel({
    @required this.isLoading,
    @required this.onLoginPressed,
  });

  static _LoginViewModel fromStore(Store<AppState> store) {
    return _LoginViewModel(
        isLoading: store.state.loginState.isLoading,
        onLoginPressed:
            (BuildContext context, String username, String password) {
          Completer<dynamic> completer = Completer<dynamic>();

          store.dispatch(
              LogIn(context, username, password, completer: completer));

          completer.future.then((error) {
            if (error != null) {
              Scaffold.of(context)
                  .showSnackBar(new SnackBar(content: new Text(AppLocalizations.instance.text('login_error'))));
            }
          });
        });
  }
}
