import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/constants.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/widgets/image_component.dart';
import 'package:fpic_app/widgets/language_switcher.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

import '../data/menu.dart';
import '../data/menupage.dart';
import '../main.dart';

class Header extends StatelessWidget {
  final Menu? menu;
  final MenuPage? page;
  final bool useWhiteHeader;

  const Header(this.menu, this.page, {super.key, this.useWhiteHeader = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      return Column(children: [
        Stack(children: [
          Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Color.fromARGB(255, 245, 245, 225),
                  ],
                ),

                // gradient: LinearGradient(
                //   begin: Alignment.centerLeft,
                //   end: Alignment.centerRight,
                //   colors: [
                //     Color.fromARGB(
                //         200, 32, 82, 168), // A deep teal/blue at the top
                //     // Color.fromARGB(255, 3, 147, 142), // A lighter teal in the middle
                //     Color.fromARGB(200, 30, 173, 106),
                //   ],
                // ),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 48, 50, 50).withOpacity(0.2),
                    blurRadius: 2,
                    offset: Offset(0, 5.0),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.30,
              padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: this.menu != null
                      ? this.menu?.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: SizedBox(
                                  height: 140,
                                  width: double.infinity,
                                  child: FPICImage(this.menu!.image,
                                      fit: BoxFit.contain, height: 140)),
                            )
                          : null
                      : this.page?.image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: SizedBox(
                                  height: 140,
                                  width: double.infinity,
                                  child: FPICImage(this.page!.image,
                                      fit: BoxFit.contain, height: 140)),
                            )
                          : null)),
          // positioned language switcher to top-right
          Positioned(
            top: 10,
            right: 25,
            child: LanguageSwitcher(),
          ),
          AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: Builder(builder: (context) {
              // show back icon only when there is somewhere to pop to
              if (Navigator.of(context).canPop()) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: useWhiteHeader ? Colors.black : Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                );
              }
              return SizedBox.shrink();
            }),
            // actions: [
            //   if (ShareLink.isNotEmpty)
            //     IconButton(
            //         icon: Icon(Icons.share),
            //         tooltip: 'Share',
            //         color: useWhiteHeader ? Colors.black : Colors.white,
            //         onPressed: () => Share.share(ShareLink))
            // ],
          ),
        ]),
        Container(
            height: 85.0,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //     color: useWhiteHeader ? Colors.white : Color(0xff028090),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.5),
            //         blurRadius: 2.0,
            //         offset: Offset(0, 5.5),
            //       ),
            //     ]
            //     ),
            child: Container(
                margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                child: Align(
                  // alignment: Alignment.center,
                  child: Text(
                      this.menu != null
                          ? localization == Localization.English
                              ? this.menu?.title_en ?? ""
                              : this.menu?.title_kh ?? ""
                          : localization == Localization.English
                              ? this.page?.title_en ?? ""
                              : this.page?.title_kh ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.8,
                        color: Colors.green[900],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: KhmerFonts.battambang,
                        package: 'khmer_fonts',
                      )),
                )))
      ]);
    });
  }
}
