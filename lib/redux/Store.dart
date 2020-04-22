import 'package:redux/redux.dart';
import 'package:the_app/redux/AppReducer.dart';
import 'package:the_app/redux/AppState.dart';

Store<AppState> store = Store<AppState>(
  appReducer,
  initialState: AppState.initialState()
);