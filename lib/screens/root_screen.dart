import 'package:flutter/material.dart';
import 'package:fpic_app/bloc/app_route.dart';
import 'package:fpic_app/main.dart';
import 'main_screen.dart';
import 'home_screen.dart';
import 'contact_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  dynamic _contactMenu;
  VoidCallback? _tabListener;

  @override
  void initState() {
    super.initState();
    _findContactMenu();
    // Initialize current index from global notifier and listen for changes.
    _currentIndex = App.tabIndex.value;
    _tabListener = () {
      final v = App.tabIndex.value;
      if (v != _currentIndex) {
        setState(() {
          _currentIndex = v;
        });
      }
    };
    App.tabIndex.addListener(_tabListener!);
  }

  void _findContactMenu() {
    // Find contact menu from App.menus
    for (var m in App.menus) {
      if (m.title_en.toLowerCase().contains('contact') ||
          m.title_kh.toLowerCase().contains('contact')) {
        _contactMenu = m;
        return;
      }
      if (m.menus != null) {
        for (var nm in m.menus!) {
          if (nm.title_en.toLowerCase().contains('contact') ||
              nm.title_kh.toLowerCase().contains('contact')) {
            _contactMenu = nm;
            return;
          }
        }
      }
    }
  }

  void _onTap(int index) {
    // Retry finding contact menu if user taps Contact tab and it's not found yet
    if (index == 2 && _contactMenu == null) {
      setState(() {
        _findContactMenu();
        _currentIndex = index;
      });
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure contact menu is found on every rebuild
    if (_contactMenu == null) {
      _findContactMenu();
    }

    final tabs = <Widget>[
      const MainScreen(),
      HomeScreen(),
      _contactMenu != null && App.meta != null
          ? ContactScreen(_contactMenu, App.meta!)
          : Center(child: Text('Contact not available')),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: AppRoute(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  @override
  void dispose() {
    if (_tabListener != null) App.tabIndex.removeListener(_tabListener!);
    super.dispose();
  }
}
