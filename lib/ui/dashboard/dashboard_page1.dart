import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_posts_redux/localizations.dart';
import 'package:flutter_posts_redux/model/posts.dart';
import 'package:flutter_posts_redux/redux/app/app_actions.dart';
import 'package:flutter_posts_redux/redux/app/app_state.dart';
import 'package:flutter_posts_redux/redux/posts/posts_actions.dart';
import 'package:flutter_posts_redux/ui/login/login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class DashboardPage1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, _PostsViewModel>(
      converter: _PostsViewModel.fromStore,
      // need to pass the context from the builder, so we can show snackbar
      // which doesnt work with the same context that the created the scaffold
      builder: (context, vm) => _PostsList(viewModel: vm),
    );
  }
}

class _PostsList extends StatelessWidget {
  final _PostsViewModel viewModel;

  _PostsList({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => viewModel.onRefreshed(context),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.postList.length,
          itemBuilder: (BuildContext context, index) {
            return Column(children: <Widget>[
              Text(viewModel.postList[index].title),
              Text(viewModel.postList[index].description),
              Divider(
                height: 1.0,
              ),
            ]);
          }),
    );
  }
}

class _PostsViewModel {
  final bool isLoading;
  final List<Post> postList;
  final Function(BuildContext) onRefreshed;

  _PostsViewModel(this.isLoading, this.postList, this.onRefreshed);

  static _PostsViewModel fromStore(Store<AppState> store) {

    Future<String> _handleRefresh(BuildContext context) {
      final Completer<String> completer = Completer<String>();
      store.dispatch(LoadPosts(completer));
      return completer.future.then((error) {
        // no-op
      });

    }

    return _PostsViewModel(store.state.postsState.isLoading,
        store.state.postsState.list.asList(), _handleRefresh);
  }
}