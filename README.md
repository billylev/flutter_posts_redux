# Redux Demo

This project uses the redux pattern to save the application state.

It demonstrates logging in/out and loading a list of posts.

A video of the app running can be found [here](https://youtu.be/Xk5b-5eMol0).

This is a modified version of the flutter-redux-starter found [here](https://github.com/hillelcoren/flutter-redux-starter).

If you interested in comparison between Redux and Bloc, have a look the the [flutter_post_bloc](https://github.com/billylev/flutter_posts_bloc) project, that implements this exact same app using the Bloc pattern.

# Getting Started

## built_value

The build_value package is used. This generates the xxxx.g.dart files from the coresponding xxxx.dart file.

Open a command prompt and run

```
$ flutter packages pub run build_runner watch
```

# Overview

![redux-overview](assets/redux_overview.png)

In the redux pattern, you define a state that maybe shown on your view. Your views can make a change to that state by dispatching an action. Actions get processed by the middleware or the reducers (or both). The middleware may dispatch further actions. When an action is processed by a reducer it will update the state, which causes your view to rebuild so the new state is displayed.

### Top Level

At the top level code is divided into the follow folders to separate out the responsibilities.

```
+-- lib
    +-- api
    +-- model
    +-- redux
    +-- ui
```

* api folder holds the classes to call our http api
* model folder holds our models
* redux folder holds the files related to the redux pattern
* ui folder holds our ui code

### Models

```
+-- lib
    +-- model
      +-- posts.dart
      +-- sessions.dart
```

(Note in the model folder you will see .g.dart files, these files are generated by the build_value package for us.)

In Session.dart we just define the 3 parameters we interested in from the login response.

In Posts.dart have to define 2 classes, one to hold the list of posts, and one to define the post contents itself.

Whenever you define a model or a state class, you need to add it to the serializers.dart declarations, so that it becomes serializable.

```
@SerializersFor(const [
  LoginState,
  Session,
  Posts,
  Post,
  PostsState
])
final Serializers serializers =
(_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
```

### Redux

In the redux folder the store is declared in store.dart.

To create a store, we provide it with a reducer, an initial state, and optionally a number of middleware reducers.

* **Reducers** change the app state.
* **Middleware**, pauses the action pipeline and allows an action to do some async work, e.g calling an api, or caching the data.

Although the store takes one reducer, its cleaner to define a reducer for each feature, along with state and middleware. The states are then all defined in AppState, and the appReducer passes the actions on to them.

A **Reducer** is simply just taking a action and working out what function it should call to handle that action.

Actions get passed along. e.g if we dispatched a LogIn action, it gets processed by the login_middleware as it needs to make an api call to authenticate the user. Once done it will also be passed onto the reducer.

```
+-- lib
    +-- redux
      +-- app
      +-- login
      +-- posts
```

* app folder holds the app state
* login folder holds the login state
* posts folder holds the posts state

### App State

The app state defines a SessionState. This state is used to decide which screen to display at the route. There are 3 main states.

* Uninitialized
* Unauthenticated
* Authenticated

In an **Uninitialized** state the app shows the SplashScreen.
In an **Unauthenticated** state the app shows the LoginScreen.
In an **Authenticated** state the app shows the Dashboard.

### Login

To login, we need to get the username & password, call an api to authenticate the user, show a busy status whilst that happens, then if successful allow the user into the app, if unsuccessful show an error message.

To do this we define the following actions :-

* LogIn
* LogOut
* LogInRequested
* LogInSuccessful
* LogInFailed

LogIn and LogOut goto the auth_middleware. It makes the api calls and dispatches further actions.

In the LogIn handler, it first checks that we where not already trying to do a login, and goes onto dispatching a LogInRequested action. LogInRequested gets processed by login_reducer, which sets the isLoading flag. That causes the UI to update, and it shows the loading indicator.


```
+-- lib
    +-- redux
      +-- login
       +-- login_actions.dart
       +-- login_middleware.dart
       +-- login_reducer.dart
       +-- login_state.dart
```

![redux-overview](https://www.websequencediagrams.com/cgi-bin/cdraw?lz=dGl0bGUgTG9naW4gU2VxdWVuY2UKCgALBVNjcmVlbi0-bG9naW5NaWRkbGV3YXJlOiBMb2dJTgoACA8AIQdSZWR1Y2VyAB8GblJlcXVlc3RlZAAoBgAWBy0-AFoGdGF0ZTogaXNMb2FkaW5nID0gdHJ1ZQBHEgCBGQVBcGk6IHIASgYgbG9nSW4AgSAGQXBpAIEQE1Nlc3Npb24AgQAlU3VjY2Vzc2Z1bACBQhJhcHAAgUkJAE0HQXV0aGVudGljYXRlZAoAFwotPkFwcABxBzogcwB7BgCBXwUgPSAAJw4AgWcmZmFsc2UKCgoKCg&s=napkin)
### Posts

Posts are already added, but the process of adding them was :-

1. Add a model for the post
2. Add the Posts model to the serialization
3. Add the posts state
4. Define the actions
    - LoadPosts : async call to fetch the posts via http
    - LoadPostsRequested : update the state to show the posts are being fetched
    - LoadPostsSuccessful : posts loaded, store them in our model
    - LoadPostsFail : posts failed to load
5. Define the middleware handler functions
6. Define the reducer handler functions
7. Add the Posts state to the AppState
8. Add the Posts middleware to the store
9. Add UI to display the Posts

### ViewModels

We have got our store, and we can dispatch functions to change the store state. Now we need to bind the store to the UI, so when the state changes the UI updates.

We have the AppState that holds the entire apps state. But on any given screen we may only need to bind to some of that state. To do that, we define a ViewModel. 

Example ViewModel :-

```
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
```

In the login screen, when isLoading gets set, a loading a page is displayed.

The static factory function fromStore takes the store as a parameter and binds the isLoading from the loginState to our ViewModel isLoading member.

In flutter, everythings is a Widget, so where you would normally provide a widget to show you UI, you just wrap it in a builder, which will create the ViewModel and bind the model and the UI together.

```
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
  ```


### Time Travel

One interesting side affect of the redux pattern is time travel.
Do soe reading up on DevToolsStore, which can be used in place of Store, in store.dart.
DevToolsStore enables time travel between states, can be useful for debugging.
