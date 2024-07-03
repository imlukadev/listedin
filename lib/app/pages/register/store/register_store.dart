import 'package:flutter/material.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/user.dart';
import 'package:listedin/app/data/repositories/user_repository.dart';

class RegisterInfo{
  String? name;
  String? email;
  String? password;

  RegisterInfo({this.name, this.email, this.password});
}

class RegisterStore{
  final UserRepository userRepository = UserRepository(HttpClient());

  final ValueNotifier<RegisterInfo> registerState = ValueNotifier<RegisterInfo>(RegisterInfo());
  final ValueNotifier<String> error = ValueNotifier("");
  final ValueNotifier<String> success = ValueNotifier("");
  final ValueNotifier<User?> userLogged = ValueNotifier(null);

  void updateEmail(String value) {
    registerState.value.email = value;
  }

  void updateName(String value) {
    registerState.value.name = value;
  }

  void updatePassword(String value) {
    registerState.value.password = value;
  }

    Future<bool> register() async {
    try {
      if(!verifyPassword()){
        error.value = "Senha Inválida";
        return false;
      }else if(!verifyEmail()){
        error.value = "Nome Inválido";
        return false;
      }else if(!verifyEmail()){
        error.value = "Email Inválido";
        return false;
      }

      User result = await  userRepository.createUser(registerState.value.name!, registerState.value.email!, registerState.value.password!);
      userLogged.value = result;
      success.value = "Usuário criado com sucesso!";
      return true;
    } catch (e) {
      error.value = e.toString();
      return false;
    }
  }

  verifyPassword(){
    return (registerState.value.password != null && registerState.value.password!.length>=6);
  }

  verifyName(){
    return (registerState.value.name != null);
  }

  verifyEmail(){
    return (registerState.value.email != null && registerState.value.email!.contains("@") && registerState.value.email!.contains("."));
  }

  RegisterStore();
}

