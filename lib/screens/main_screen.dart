// dart:convert not used here
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// menu bloc imports not required in this screen
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/widgets/image_component.dart';
import 'package:khmer_fonts/khmer_fonts.dart';
import '../constants.dart';
import '../widgets/logo_list.dart';
import 'home_screen.dart';
// contact and app route are managed by `RootScreen`
// import 'contact_screen.dart';
// import '../bloc/app_route.dart';
import '../main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen() : super();

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var meta = App.meta;
    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFFF8F8EE),
                ],
              ),
            ),
            child: Column(
              children: [
                // Khmer Title with decorative lines
                Container(
                  margin: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    children: [
                      Text(meta!.title_kh,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MainBackgroundColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            fontFamily: KhmerFonts.battambang,
                            package: 'khmer_fonts',
                          )),
                    ],
                  ),
                ),
                // Decorative line and dot
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 2.0,
                          color: Color(0xFF4DADA8),
                          margin: EdgeInsets.only(right: 12.0, left: 130),
                        ),
                      ),
                      Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF4DADA8),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 2.0,
                          color: Color(0xFF4DADA8),
                          margin: EdgeInsets.only(left: 12.0, right: 130),
                        ),
                      ),
                    ],
                  ),
                ),
                // English Title
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Center(
                      child: Text(meta.title_en,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF2669AA),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold))),
                ),
                Flexible(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: 25.0, right: 25.0, bottom: 70.0),
                        child: meta.image.isNotEmpty
                            ? Card(
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Map of Cambodia',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 40.0),
                                      Expanded(
                                        child: FPICImage(meta.image),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container())),
                // Buttons with gradient background
                // Container(
                //   margin: EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
                //   width: MediaQuery.of(context).size.width - 70,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors: [
                //         Color(0xFF2A7C6B), // Dark green (top)
                //         Color(0xFF00B388), // Lighter green (bottom)
                //       ],
                //     ),
                //     borderRadius: BorderRadius.circular(9.0),
                //   ),
                // child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       foregroundColor: Colors.white,
                //       backgroundColor: Colors.transparent,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(9.0),
                //       ),
                //       side: BorderSide(width: 2.0, color: Colors.yellow),
                //     ),
                //     child: Text(
                //       MainButtonTextLanguageKhmer,
                //       style: TextStyle(
                //         fontWeight: FontWeight.w600,
                //         fontFamily: KhmerFonts.siemreap,
                //         package: 'khmer_fonts',
                //       ),
                //     ),
                //     onPressed: () => {
                //           BlocProvider.of<LocalizationCubit>(context)
                //               .setLocalization(Localization.Khmer),
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => HomeScreen()))
                //         })
                // ),
                // // Another Button with gradient background
                // Container(
                //   margin: EdgeInsets.only(
                //       top: 5.0, left: 40.0, right: 40.0, bottom: 10),
                //   width: MediaQuery.of(context).size.width - 70,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors: [
                //         Color(0xFF2A7C6B), // Dark green (top)
                //         Color(0xFF00B388), // Lighter green (bottom)
                //       ],
                //     ),
                //     borderRadius: BorderRadius.circular(9.0),
                //   ),
                // child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       foregroundColor: Colors.white,
                //       backgroundColor: Colors.transparent,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(9.0),
                //       ),
                //       side: BorderSide(width: 2.0, color: Colors.red),
                //     ),
                //     child: Text(MainButtonTextLanguageEnglish),
                //     onPressed: () => {
                //           BlocProvider.of<LocalizationCubit>(context)
                //               .setLocalization(Localization.English),
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => HomeScreen()),
                //           )
                //         })
                // ),

                // "Implemented By" Section with Gradient Background
                Container(
                  margin: EdgeInsets.only(
                      top: 10.0, left: 40.0, right: 40.0, bottom: 20.0),
                  // width: MediaQuery.of(context).size.width - 70,
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [
                  //       Color.fromARGB(255, 78, 80, 79), // Dark green (top)
                  //       Color.fromARGB(255, 231, 233, 196), // Lighter green (bottom)
                  //     ],
                  //   ),
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Section Title Text
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 15),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            meta.first_logo_section_text,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Logos List
                      LogoList(meta.implemented_by_logos),
                      if (meta.funded_by_logos.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: LogoList(meta.funded_by_logos),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              // width: MediaQuery.of(context).size.width - 60,
                              child: Center(
                                child: Text(
                                  meta.second_logo_section_text,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottom navigation is provided by RootScreen
      );
    });
  }
}
