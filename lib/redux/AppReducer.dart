import 'package:the_app/pages/login/actions/Actions.dart';
import 'package:the_app/redux/AppState.dart';

AppState appReducer(AppState state, dynamic action){

  if(action is AnimationStatusLoginChange){
    return state.copyWith(
      animationStatusLogin: action.animationStatusLogin
    );
  }

  return state;
}