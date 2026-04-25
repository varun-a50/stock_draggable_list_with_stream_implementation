import 'package:diamondhandllp/features/funds/presentation/screens/funds_screen.dart';
import 'package:diamondhandllp/features/gtt/presentation/screens/gtt_screen.dart';
import 'package:diamondhandllp/features/orders/presenation/screens/orders_screen.dart';
import 'package:diamondhandllp/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:diamondhandllp/features/profile/presentation/screens/profile_screen.dart';
import 'package:diamondhandllp/features/stock_dashboard/presentation/screens/dashboard.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _screens = [
    Dashboard(),
    OrdersScreen(),
    GttScreen(),
    PortfolioScreen(),
    FundsScreen(),
    ProfileScreen(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(255, 136, 133, 133),
        unselectedLabelStyle: TextStyle(
          color: Color.fromARGB(255, 136, 133, 133),
        ),
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.watch), label: "Wishlist"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_sharp),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.light_outlined),
            label: "GTT",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: "Portfolio",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Funds"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
