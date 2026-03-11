import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/authentication_controller.dart';
import '../core/app_role.dart';
import '../Home/home.dart';
import '../Home/professor_home.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  final AppRole role;

  const LoginScreen({
    super.key,
    required this.role,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController = Get.find();

  bool obscurePassword = true;

  Future<void> _login() async {
    try {
      await authenticationController.signIn(
        controllerEmail.text,
        controllerPassword.text,
        widget.role,
      );

      Get.snackbar(
        'Login',
        'Inicio de sesión exitoso',
        snackPosition: SnackPosition.BOTTOM,
      );

      if (widget.role == AppRole.student) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const ProfessorHomeScreen());
      }
    } catch (err) {
      Get.snackbar(
        'Login',
        err.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const greenDark = Color(0xFF577F49);
    const greenSoft = Color(0xFFC6E0BC);
    const background = Color(0xFFF3F3F3);

    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 360,
              color: greenDark,
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.role.label,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -25),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                decoration: const BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Inicio de Sesión',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Center(
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Correo',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu correo';
                          }
                          if (!value.contains('@')) {
                            return 'Correo inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Contraseña',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controllerPassword,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          isDense: true,
                          border: const UnderlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu contraseña';
                          }
                          if (value.length < 6) {
                            return 'Mínimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            if (formKey.currentState!.validate()) {
                              await _login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenSoft,
                            foregroundColor: greenDark,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Inicio de Sesión',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'No tienes cuenta? ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterScreen(
                                    role: widget.role,
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: greenDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}