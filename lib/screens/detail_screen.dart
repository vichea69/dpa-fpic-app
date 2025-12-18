import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/data/menupage.dart';
import 'package:fpic_app/screens/content_screen.dart';
import 'package:khmer_fonts/khmer_fonts.dart';
import 'package:fpic_app/bloc/app_route.dart';

import '../constants.dart';
import '../data/menu.dart';
import '../widgets/header.dart';
import '../widgets/language_switcher.dart';
import '../main.dart';

class DetailScreen extends StatelessWidget {
  final Menu menu;
  final Menu? previousMenu;

  const DetailScreen(this.previousMenu, this.menu, {super.key});

  _retrieveSubtitle(Localization localization) {
    if (localization == Localization.English) {
      return this.previousMenu?.subtitle_en ?? App.meta?.home_en;
    } else if (localization == Localization.Khmer) {
      return this.previousMenu?.subtitle_kh ?? App.meta?.home_kh;
    }
    return "";
  }

  _retrieveDetails() {
    var details = [];
    if (this.menu.pages != null) {
      if (this.menu.pages!.length > 0) {
        details = this.menu.pages!;
      }
    }

    if (this.menu.menus != null) {
      if (this.menu.menus!.length > 0) {
        details = this.menu.menus!;
      }
    }
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      return Scaffold(
          backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Colors.white,
            //       Color(0xFFF8F8EE),
            //     ],
            //   ),
            // ),
            child: Column(
              children: [
                Stack(children: [
                  Header(this.menu, null, useWhiteHeader: true),
                  Positioned(
                    top: 10,
                    right: 25,
                    child: LanguageSwitcher(),
                  ),
                ]),
                // const SizedBox(height: 10.0);
              
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      // height: MediaQuery.of(context).size.height * 0.48,

                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        scrollDirection: Axis.vertical,
                        itemCount: _retrieveDetails().length,
                        itemBuilder: (BuildContext context, int index) {
                          var d = _retrieveDetails()[index];
                          return Card(
                            elevation: 1.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)),
                              ),
                              child: ListTile(
                                title: Text(
                                  localization == Localization.English
                                      ? d.title_en ?? ""
                                      : d.title_kh ?? "",
                                  style: TextStyle(
                                    color: Color(0xFF404040),
                                    height: 1.8,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: KhmerFonts.battambang,
                                    package: 'khmer_fonts',
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black45,
                                  size: 30.0,
                                ),
                                onTap: () {
                                  App.tabIndex.value = 1;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (d is MenuPage)
                                          ? ContentScreen(this.menu, d, false)
                                          : DetailScreen(this.menu, d),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      )),
                ) // Back button moved to the AppBar leading (icon-only) in Header
              ],
            ),
          ),
        ),
        // add persistent bottom menu here; tapping will switch the global tab and pop back to root
        bottomNavigationBar: AppRoute(
          currentIndex: App.tabIndex.value,
          onTap: (index) {
            App.tabIndex.value = index;
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      );
    });
  }
}
