import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'routine_screen.dart';
import 'notices_screen.dart';
import 'settings_screen.dart';
import 'bus_screen.dart';
import 'exam_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text('DIU Smart Campus'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;

          if (constraints.maxWidth >= 1200) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth >= 800) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.15,
              children: [
                _card(context, 'Profile', Icons.person, const LoginScreen()),
                _card(context, 'Routine', Icons.calendar_today,
                    const RoutineScreen()),
                _card(context, 'Notices', Icons.notifications,
                    const NoticesScreen()),
                _card(context, 'Bus Schedule', Icons.directions_bus,
                    const BusScreen()),
                _card(
                    context, 'Exam Info', Icons.assignment, const ExamScreen()),
                _card(context, 'Settings', Icons.settings,
                    const SettingsScreen()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _card(BuildContext context, String title, IconData icon, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 34, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
