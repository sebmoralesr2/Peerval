import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/authentication_controller.dart';
import '../core/app_role.dart';
import '../Home/home.dart';
import '../Home/professor_home.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  final AppRole role;

  const RegisterScreen({
    super.key,
    required this.role,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final AuthenticationController authenticationController = Get.find();

  bool obscurePassword = true;

  Future<void> _register() async {
    try {
      await authenticationController.signUp(
        controllerEmail.text,
        controllerPassword.text,
        controllerName.text,
        widget.role,
      );

      Get.snackbar(
        'Registro',
        'Usuario creado correctamente',
        snackPosition: SnackPosition.BOTTOM,
      );

      if (widget.role == AppRole.student) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const ProfessorHomeScreen());
      }
    } catch (err) {
      Get.snackbar(
        'Registro',
        err.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerName.dispose();
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
                      'Regístrate',
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
                        'Registrarse',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 34),
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
                        'Nombre',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controllerName,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu nombre';
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
                      const SizedBox(height: 42),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            if (formKey.currentState!.validate()) {
                              await _register();
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
                            'Registrarse',
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
                            'Ya tienes cuenta? ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(
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
                              'Inicia Sesión',
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