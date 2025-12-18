import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/constants.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

import '../data/menu.dart';
import '../data/menupage.dart';

import '../data/meta.dart';
import '../widgets/header.dart';
import '../widgets/email_form.dart';
import '../main.dart';

class EmailScreen extends StatelessWidget {
  final Meta meta;
  final MenuPage page;
  final Menu previousMenu;

  EmailScreen(this.previousMenu, this.page, this.meta);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      return Scaffold(
          backgroundColor: MainBackgroundColor,
          body: SafeArea(
              child: Column(children: [
            Header(null, this.page),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                  // height: MediaQuery.of(context).size.height * 0.48,
                  decoration: BoxDecoration(
                      color: SecondBackgroundColor,
                      borderRadius: BorderRadius.circular(9.0)),
                  child:
                      SingleChildScrollView(child: EmailForm(meta: this.meta))),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20),
                child: Container(
                    height: 30.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        backgroundColor: Color(0xff028090), // Background color
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                          localization == Localization.English
                              ? this.previousMenu.title_en ?? ""
                              : this.previousMenu.title_kh ?? "",
                          style: TextStyle(
                            color: MainBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: KhmerFonts.siemreap,
                            package: 'khmer_fonts',
                          )),
                    ))),
          ])));
    });
  }
}
