import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  final _host = Host().obs;
  Host? get host => _host.value;
  set host(Host? value) => _host.value = value!;

  Future<User?> checkStateUser() async {
 
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        Get.offAllNamed(AppRoutes.APP);
        log('User is signed in!');
      }
    });
    return _auth.currentUser;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      log('Error signing in: $e');
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      log('Password reset email sent');
    } catch (e) {
      log('Error sending password reset email: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      log('User signed out');
    } catch (e) {
      log('Error signing out: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkStateUser();
  }
}
