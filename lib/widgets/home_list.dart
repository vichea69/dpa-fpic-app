import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/constants.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/data/menupage.dart';
import 'package:fpic_app/screens/content_screen.dart';
import 'package:fpic_app/screens/detail_screen.dart';
import 'package:fpic_app/widgets/image_component.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

import '../screens/contact_screen.dart';
import '../data/menu.dart';
import '../data/meta.dart';
import '../main.dart';

class HomeList extends StatelessWidget {
  final List<Menu> menus;
  final List<MenuPage> pages;
  final Meta meta;
  final bool isHorizontal;

  HomeList(this.menus, this.pages, this.meta, this.isHorizontal);

  @override
  Widget build(BuildContext context) {
    return //Center(child:
        BlocBuilder<LocalizationCubit, Localization>(
            builder: (BuildContext context, Localization localization) {
      // Filter out any menu that is a Contact entry (title contains 'contact')
      final visibleMenus = this.menus.where((m) {
        final en = m.title_en.toLowerCase();
        final kh = m.title_kh.toLowerCase();
        return !(en.contains('contact') || kh.contains('contact'));
      }).toList();

      return ListView.builder(
          padding: isHorizontal
              ? EdgeInsets.symmetric(vertical: 0)
              : EdgeInsets.symmetric(vertical: 10),
          scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
          itemCount: (visibleMenus.length + this.pages.length),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index < visibleMenus.length) {
              var menu = visibleMenus[index];
              return isHorizontal
                  ? Card(
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      margin: EdgeInsets.only(left: 16.0),
                      child: GestureDetector(
                          onTap: () {
                            if (menu.title_en != "Contact Us") {
                              App.tabIndex.value = 1;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      menu.title_en == "Contact Us"
                                          ? ContactScreen(menu, this.meta)
                                          : DetailScreen(null, menu)),
                            );
                          },
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0))),
                                  child: menu.image.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.all(6),
                                              child: FPICImage(menu.image,
                                                  fit: BoxFit.contain,
                                                  width: double.infinity,
                                                  height: double.infinity)))
                                      : null))))
                  : Card(
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                      child: GestureDetector(
                          onTap: () {
                            if (menu.title_en != "Contact Us") {
                              App.tabIndex.value = 1;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      menu.title_en == "Contact Us"
                                          ? ContactScreen(menu, this.meta)
                                          : DetailScreen(null, menu)),
                            );
                          },
                          child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.all(12),
                                              //padding: EdgeInsets.all(5),
                                              constraints:
                                                  BoxConstraints.expand(),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black54
                                                        .withOpacity(0.5),
                                                    spreadRadius: 0,
                                                    blurRadius: 1,
                                                    offset: Offset(0, 0.5),
                                                  ),
                                                ],
                                              ),
                                              child: menu.image.isNotEmpty
                                                  ? FPICImage(menu.image)
                                                  // ? Image.memory(
                                                  //     base64Decode(menu.image),
                                                  //     height: 70,
                                                  //     fit: BoxFit.contain)
                                                  : null),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0))),
                                        child: Text(
                                          localization == Localization.English
                                              ? menu.title_en
                                              : menu.title_kh,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Color(0xFF404040),
                                            height: 1.8,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: KhmerFonts.siemreap,
                                            package: 'khmer_fonts',
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0))),
                                        child: Icon(Icons.keyboard_arrow_right,
                                            color: Colors.black45, size: 30.0),
                                      )),
                                ],
                              ))));
            } else {
              var page = this.pages[index - this.menus.length];
              return isHorizontal
                  ? Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      margin: EdgeInsets.only(left: 16.0),
                      child: GestureDetector(
                          onTap: () {
                            App.tabIndex.value = 1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ContentScreen(null, page, false)),
                            );
                          },
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: MainBackgroundColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(9.0))),
                                  child: page.image.isNotEmpty
                                      ? FPICImage(page.image)
                                      : null))))
                  : Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                      child: GestureDetector(
                          onTap: () {
                            App.tabIndex.value = 1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ContentScreen(null, page, false)),
                            );
                          },
                          child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: MainBackgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.all(8),
                                              constraints:
                                                  BoxConstraints.expand(),
                                              decoration: BoxDecoration(
                                                  color: MainBackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.0))),
                                              child: page.image.isNotEmpty
                                                  ? FPICImage(page.image)
                                                  // ? Image.memory(
                                                  //     base64Decode(menu.image),
                                                  //     height: 70,
                                                  //     fit: BoxFit.contain)
                                                  : null),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: MainBackgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0))),
                                        child: Text(
                                          localization == Localization.English
                                              ? page.title_en
                                              : page.title_kh,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: KhmerFonts.siemreap,
                                              package: 'khmer_fonts'),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: MainBackgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0))),
                                        child: Icon(Icons.keyboard_arrow_right,
                                            color: Colors.white, size: 30.0),
                                      )),
                                ],
                              ))));
            }
          });
    });
  }
}
