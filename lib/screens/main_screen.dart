import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_screen.dart';
import 'history_screen.dart';
import 'recap_screen.dart';
import 'graph_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; 

  // List of screens
  final List<Widget> _screens = [
    const InputScreen(),
    const HistoryScreen(),
    const RecapScreen(),
    const GraphScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
               if (states.contains(MaterialState.selected)) {
                 return GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF2563EB));
               }
               return GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF94A3B8));
            }),
            iconTheme: MaterialStateProperty.resolveWith((states) {
               if (states.contains(MaterialState.selected)) {
                 return const IconThemeData(color: Color(0xFF2563EB));
               }
               return const IconThemeData(color: Color(0xFF94A3B8));
            }),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            indicatorColor: const Color(0xFFEFF6FF), // Ultra light blue
            height: 65,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline),
                selectedIcon: Icon(Icons.add_circle),
                label: 'Pencatatan',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_outlined),
                selectedIcon: Icon(Icons.history),
                label: 'Riwayat',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today),
                label: 'Rekap',
              ),
              NavigationDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: 'Grafik',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
