import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth fauth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try{
      UserCredential result = await fauth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return UserMeth.fromFirebase(user);
    }catch(e){
      print("Sing Error ============");
      print(e);
      return null;
    }
  }

  Future register(String email, String password) async {
    try{
      UserCredential result = await fauth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return UserMeth.fromFirebase(user);
    }catch(e){
      print("Register Error ============");
      print(e);
      return null;
    }
  }

  Future loyaut()async{
    await fauth.signOut();
  }

  Stream<UserMeth?> get currentUser{
    return fauth.authStateChanges().map((dynamic user)=> user != null ? UserMeth.fromFirebase(user):null);
  }
}

class UserMeth{
  String? id;
  UserMeth.fromFirebase(dynamic user){
    this.id = user.uid;
  }
}