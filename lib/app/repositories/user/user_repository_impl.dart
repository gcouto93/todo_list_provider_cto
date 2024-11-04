import 'package:cto_todo_list_provider/app/exception/auth_exception.dart';
import 'package:cto_todo_list_provider/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositoryImpl implements UserRepository{
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;
  
  @override
  Future<User?> register(String email, String password) async {

    try {
  var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
    email: email,
     password: password);
  return userCredential.user;
} on FirebaseAuthException catch (e) {
  if(e.code == 'email-already-in-use'){
    throw AuthException(message: 'E-mail já cadastrado, por favor, escolha outro e-mail');
  } else {
    throw AuthException(message: 'Erro ao registrar usuário');
    }
    }    
    }
    
      @override
      Future<User?> login(String email, String password) async {
        try {
  final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
    email: email, password: password);
    return userCredential.user;
} on PlatformException catch (e) {
  throw AuthException(message: e.message ?? 'Erro ao realizar login');
}on FirebaseAuthException catch (e) {
  if(e.code == 'wrong-password') {
    throw AuthException(message: 'Login ou senha inválidos');
  }
  throw AuthException(message: e.message ?? 'Erro ao realizar login');
}
      }
      
        @override
        Future<void> forgotPassword(String email) async {
          try {
  await _firebaseAuth.sendPasswordResetEmail(email: email); 
} on Exception catch (e) {
  throw AuthException(message: e.toString());
}
        }
        
          @override
          Future<User?> googleLogin() async {
            try {
  final googleSignIn= GoogleSignIn();
  final googleUser = await googleSignIn.signIn();
  // if(googleUser != null) {
  //   final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
  //   if(loginMethods.contains('password')){
  //     throw AuthException(message: 
  //     'Você utilizou o e-mail para cadastro, caso tenha esquecido a senha clique em "Esqueci minha senha"');
  //   } else {
  
  //   }
  if(googleUser != null) {
    final googleAuth = await googleUser.authentication;
    final firebaseProvider = GoogleAuthProvider.credential(
      accessToken:googleAuth.accessToken,
      idToken:  googleAuth.idToken);
      var userCredential = await _firebaseAuth.signInWithCredential(firebaseProvider);
  }
} on FirebaseAuthException catch (e,s) {
  if(e.code == 'account-exists-with-different-credential') {
    throw AuthException(message: 'Login inválido você ja se registrou nesse aplicativo');
  } else{
    throw AuthException(message: 'Erro ao realizar login');
  }
}
}

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
        

