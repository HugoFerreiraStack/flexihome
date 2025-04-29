import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/login/data/login_repository_impl.dart';
import 'package:flexihome/src/features/login/domain/usecases/login_usecase.dart';
import 'package:flexihome/src/features/login/presentations/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage storage = GetStorage();

  Stream<User?> get user => _auth.authStateChanges();

  final _host = UserApp().obs;
  UserApp? get host => _host.value;
  set host(UserApp? value) => _host.value = value!;

  bool? getRememberMe() =>
      (storage.read('rememberMe') != null) ? storage.read('rememberMe') : null;

  Future<User?> checkStateUser() async {
    final isUserLoged = getRememberMe();
    log('LOGADO: $isUserLoged');
    if (isUserLoged == null) {
      signOut();
      return null;
    }

    if (!isUserLoged) {
      signOut();
    } else {
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out!');
        } else {
          if (Get.isRegistered<LoginController>()) {
            LoginController.to.getUserData(user.uid).then((value) {
              host = value;
              Get.offAllNamed(AppRoutes.APP);
            });
          } else {
            Get.put<LoginController>(LoginController(
                loginUsecase: LoginUsecase(repository: LoginRepositoryImpl())));
            LoginController.to.getUserData(user.uid).then((value) {
              host = value;
              Get.offAllNamed(AppRoutes.APP);
            });
          }

          log('User is signed in!');
        }
      });
    }

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
      storage.write('rememberMe', false);
      Get.offAllNamed(AppRoutes.LOGIN);
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
