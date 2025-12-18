import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/main.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  LanguageSwitcherState createState() => LanguageSwitcherState();
}

class LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      final isEnglish = localization == Localization.English;
      return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Material(
          color: Colors.white.withOpacity(0.98),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              BlocProvider.of<LocalizationCubit>(context).setLocalization(
                  isEnglish ? Localization.Khmer : Localization.English);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // flag icon
                  Image(
                    image: AssetImage(isEnglish
                        ? 'assets/cambodia.png'
                        : 'assets/united-kingdom.png'),
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isEnglish ? 'ខ្មែរ' : 'EN',
                    style: TextStyle(
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      fontFamily: isEnglish ? KhmerFonts.siemreap : null,
                      package: isEnglish ? 'khmer_fonts' : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
