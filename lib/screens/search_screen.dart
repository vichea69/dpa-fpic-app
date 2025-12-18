import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/data/meta.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

import '../main.dart';
import 'content_screen.dart';

class SearchScreen extends StatelessWidget {
  final dynamic results;
  final dynamic query;
  final Meta meta;

  SearchScreen(this.query, this.results, this.meta);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Query display below back button
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  '"' + this.query + '"',
                  style: TextStyle(
                    color: Color(0xFF404040),
                    fontWeight: FontWeight.bold,
                    fontFamily: KhmerFonts.siemreap,
                    package: 'khmer_fonts',
                    fontSize: 18,
                  ),
                ),
              ),
              // Results cards at bottom (expanded)
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Color.fromARGB(255, 245, 245, 225),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 40, 56, 53)
                            .withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 5.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    scrollDirection: Axis.vertical,
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) {
                      var d = results[index];
                      return Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: ListTile(
                            title: Text(
                              localization == Localization.English
                                  ? d.title_en
                                  : d.title_kh,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF404040),
                                fontWeight: FontWeight.bold,
                                fontFamily: KhmerFonts.siemreap,
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
                                  builder: (context) =>
                                      ContentScreen(null, d, true),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
