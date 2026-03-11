import 'package:get/get.dart';
import '../core/app_role.dart';
import '../models/app_user.dart';

class AuthenticationController extends GetxController {
  final RxList<AppUser> _users = <AppUser>[].obs;
  final Rxn<AppUser> currentUser = Rxn<AppUser>();

  List<AppUser> get users => _users;

  AppUser? _findUser(String email, AppRole role) {
    for (final user in _users) {
      if (user.email.trim().toLowerCase() == email.trim().toLowerCase() &&
          user.role == role) {
        return user;
      }
    }
    return null;
  }

  Future<void> signUp(
    String email,
    String password,
    String name,
    AppRole role,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final existingUser = _findUser(email, role);
    if (existingUser != null) {
      throw Exception(
        'Ya existe una cuenta como ${role.label.toLowerCase()} con ese correo',
      );
    }

    final user = AppUser(
      email: email.trim(),
      password: password,
      name: name.trim(),
      role: role,
    );

    _users.add(user);
    currentUser.value = user;
  }

  Future<void> signIn(
    String email,
    String password,
    AppRole role,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final user = _findUser(email, role);

    if (user == null) {
      throw Exception(
        'No existe una cuenta como ${role.label.toLowerCase()} con ese correo',
      );
    }

    if (user.password != password) {
      throw Exception('Contraseña incorrecta');
    }

    currentUser.value = user;
  }

  void signOut() {
    currentUser.value = null;
  }
}