import 'package:flutter/material.dart';
import 'package:flutter_posts_redux/localizations.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/login/login_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DashboardPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            child: FlatButton(
              onPressed: ()  {store.dispatch(LogOut());},
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.instance.text('login_out'),
                    textAlign: TextAlign.left,
                  ))
            ))
      ],
    );
  }
}
