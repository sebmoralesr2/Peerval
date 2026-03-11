import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/authentication_controller.dart';
import '../start/role_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const greenDark = Color(0xFF577F49);
    const greenMedium = Color(0xFF7DB56C);
    const greenSoft = Color(0xFFC6E0BC);
    const dividerColor = Color(0xFFE6EDF2);

    final AuthenticationController authenticationController = Get.find();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 12),
              child: Align(
                alignment: Alignment.centerLeft,
              ),
            ),
            Container(
              height: 86,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              color: greenSoft,
              child: Row(
                children: [
                  const Icon(Icons.menu_rounded, color: greenDark, size: 32),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Peerval',
                        style: TextStyle(
                          color: greenDark,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      authenticationController.signOut();

                      Get.offAll(() => const RoleSelectionScreen());
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: greenDark,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              color: dividerColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 290,
                      margin: const EdgeInsets.only(left: 6, right: 6, top: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            greenMedium,
                            Color(0xFF6FA35D),
                            Color(0xFF5B8B4C),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 34,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40),
                            Text(
                              'Hola, Juan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '9no Semestre - Estudiante',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          ShortcutTile(
                            icon: Icons.local_fire_department_outlined,
                            label: 'Cursos',
                          ),
                          ShortcutTile(
                            icon: Icons.favorite_border,
                            label: 'Evaluaciones\nactivas',
                          ),
                          ShortcutTile(
                            icon: Icons.history,
                            label: 'Reportes\npasados',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 12,
                      color: dividerColor,
                    ),
                    const SizedBox(height: 14),
                    const CourseCard(
                      title: 'Programación Movil',
                      subtitle: '1 trabajo  •  3 peers  •  Activo',
                      imageUrl:
                          'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?auto=format&fit=crop&w=1200&q=80',
                    ),
                    const SizedBox(height: 24),
                    const CourseCard(
                      title: 'Inteligencia Artificial',
                      subtitle: '1 trabajo  •  2 compañeros  •  Activo',
                      imageUrl:
                          'https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=1200&q=80',
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 12,
                      color: dividerColor,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShortcutTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const ShortcutTile({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    const greenDark = Color(0xFF577F49);

    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: greenDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 100,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: greenDark,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const greenDark = Color(0xFF577F49);

    return Container(
      width: MediaQuery.of(context).size.width * 0.86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E6EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                SizedBox(
                  height: 230,
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 14,
                  bottom: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    color: Colors.black.withOpacity(0.28),
                    child: const Text(
                      'Class',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: greenDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF617287),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}