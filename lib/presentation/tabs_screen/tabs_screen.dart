import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nine_dart_score/presentation/dashboard/dashboard_screen.dart';
import 'package:nine_dart_score/presentation/history/history_screen.dart';
import 'package:nine_dart_score/presentation/players/ui/player_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  static const _screens = [
    DashboardScreen(),
    HistoryScreen(),
    PlayerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/dart_target.svg",
              height: 24,
              width: 24,
            ),
            label: "Jeu",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Historique",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Joueurs",
          )
        ],
      ),
    );
  }
}
