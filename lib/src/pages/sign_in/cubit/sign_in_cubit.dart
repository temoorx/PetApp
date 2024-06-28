import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:your_app_test/src/data/dto/base_response_dto.dart';
import 'package:your_app_test/src/data/dto/token_dto.dart';
import 'package:your_app_test/src/data/repository/firebase_repository.dart';
import 'package:your_app_test/src/domain/common/result.dart';
import 'package:your_app_test/src/domain/repository/api_repository.dart';
import 'package:your_app_test/src/util/logger_utils.dart';
part 'sign_in_cubit.freezed.dart';

class SignInCubit extends Cubit<SignInState> {
  FirebaseRepository apiRepository;

  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  SignInCubit(this.apiRepository) : super(const _Initial());

  Future<void> signIn() async {
    emit(const _Loading());
    try {
      await apiRepository
          .signInWithFirebase(
              email: emailController.text, password: passwordController.text)
          .then((value) => value.when(
                success: (data) {
                  emit(_Loaded(data));
                  LoggerUtil.logs('UserCredential: ${data.user}');
                  return Result.success(data);
                },
                failed: (error) {
                  emit(_Error(error.toString()));
                  return Result.failed(error);
                },
              ));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;

  const factory SignInState.loading() = _Loading;

  const factory SignInState.error(String message) = _Error;

  const factory SignInState.loaded(UserCredential userCredential) = _Loaded;
}
