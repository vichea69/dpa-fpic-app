import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/constants.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/main.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

class AppRoute extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const AppRoute(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      this.backgroundColor,
      this.selectedItemColor,
      this.unselectedItemColor});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<LocalizationCubit, Localization>(
      builder: (BuildContext context, Localization localization) {
        final isKhmer = localization == Localization.Khmer;
        final labels = isKhmer
            ? ['ទំព័រដើម', 'បណ្ណាល័យ', 'ទំនាក់ទំនង']
            : ['Home', 'Library', 'Contact'];

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor ??
                (isDark ? const Color(0xFF1E1E1E) : Colors.white),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: onTap,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: selectedItemColor ?? SecondBackgroundColor,
                unselectedItemColor: unselectedItemColor ??
                    (isDark ? Colors.grey : SecondBackgroundColor),
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: isKhmer ? KhmerFonts.battambang : null,
                  package: isKhmer ? 'khmer_fonts' : null,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: isKhmer ? KhmerFonts.battambang : null,
                  package: isKhmer ? 'khmer_fonts' : null,
                ),
                items: [
                  _buildNavItem(Icons.home_rounded, labels[0], 0),
                  _buildNavItem(Icons.menu_book_sharp, labels[1], 1),
                  _buildNavItem(Icons.contact_mail, labels[2], 2),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Builder(builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? (isDark
                    ? SecondBackgroundColor.withOpacity(0.2)
                    : SecondBackgroundColor.withOpacity(0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon),
        );
      }),
      label: label,
    );
  }
}
