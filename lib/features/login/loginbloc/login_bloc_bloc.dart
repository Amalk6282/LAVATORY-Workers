import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginEvent, LoginBlocState> {
  LoginBlocBloc() : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoginLoadingState());
        AuthResponse authResponse =
            await Supabase.instance.client.auth.signInWithPassword(
          password: event.password,
          email: event.email,
        );

        emit(LoginSuccessState());
      } catch (e, s) {
        Logger().e('$e\n$s');

        if (e is AuthException) {
          emit(LoginFailureState(message: e.message));
        } else {
          emit(LoginFailureState());
        }
      }
    });
  }
}
