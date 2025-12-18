import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/data/menupage.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

import '../constants.dart';
import '../data/menu.dart';
import '../data/meta.dart';
import '../main.dart';
import '../widgets/header.dart';
import '../widgets/language_switcher.dart';
import '../screens/email_screen.dart';
import 'content_screen.dart';
import 'detail_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  final Menu menu;
  final Meta meta;

  const ContactScreen(this.menu, this.meta, {super.key});

  _retrieveDetails() {
    var details = [];
    if (this.menu.pages != null) {
      if (this.menu.pages!.length > 0) {
        details.addAll(this.menu.pages!);
      }
    }

    if (this.menu.menus != null) {
      if (this.menu.menus!.length > 0) {
        details.addAll(this.menu.menus!);
      }
    }
    return details;
  }

  @override
  Widget build(BuildContext context) {
    // hardcoded contact links (modify here if needed)
    final String phoneLink = '+85523883665';
    final String websiteLink = 'https://www.dpacam.org';
    final String facebookLink = 'https://web.facebook.com/CambodiaDPA';

    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Container(
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
                  child: Column(children: [
            Stack(children: [
              Header(menu, null, useWhiteHeader: true),
              Positioned(
                top: 10,
                right: 25,
                child: LanguageSwitcher(),
              ),
            ]),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    height: MediaQuery.of(context).size.height * 0.48,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Card(
                        elevation: 3.0,
                        margin:
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        child: Container(
                          // height: 100.0,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(209, 136, 137, 137)
                                    .withOpacity(0.05),
                                blurRadius: 0.5,
                                offset: Offset(0, 2.0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(this.meta.address,
                                  style: TextStyle(
                                    height: 1.8,
                                    fontSize: 16,
                                    color: Color(0xFF404040),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: KhmerFonts.battambang,
                                    package: 'khmer_fonts',
                                  )),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.phone, size: 24),
                                    color: MainBackgroundColor,
                                    onPressed: () async {
                                      if (phoneLink.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'No phone number available')));
                                        return;
                                      }
                                      final uri = Uri.parse('tel:$phoneLink');
                                      try {
                                        final launched = await launchUrl(uri);
                                        if (!launched) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Could not launch phone dialer')));
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Error launching phone: $e')));
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.language, size: 24),
                                    color: SecondBackgroundColor,
                                    onPressed: () async {
                                      if (websiteLink.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'No website available')));
                                        return;
                                      }
                                      final uri = Uri.parse(websiteLink);
                                      try {
                                        final launched = await launchUrl(uri,
                                            mode:
                                                LaunchMode.externalApplication);
                                        if (!launched) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Could not open website')));
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Error opening website: $e')));
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.facebook, size: 24),
                                    color: Color(0xFF1877F2),
                                    onPressed: () async {
                                      if (facebookLink.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'No Facebook link available')));
                                        return;
                                      }
                                      final uri = Uri.parse(facebookLink);
                                      try {
                                        final launched = await launchUrl(uri,
                                            mode:
                                                LaunchMode.externalApplication);
                                        if (!launched) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Could not open Facebook')));
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Error opening Facebook: $e')));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),

                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                          height: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Map(),
                          )),

                      ..._retrieveDetails().map((item) => (GestureDetector(
                          onTap: () {
                            if (item is MenuPage) {
                              if (item.title_en.toLowerCase() ==
                                  "Email Us".toLowerCase()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmailScreen(
                                            this.menu, item, this.meta)));
                              } else {
                                App.tabIndex.value = 1;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContentScreen(
                                            this.menu, item, false)));
                              }
                            } else {
                              App.tabIndex.value = 1;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(this.menu, item)));
                            }
                          },
                          child: Container(
                              child: Card(
                                  elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Container(
                                      height: 60.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: DarkBackgroundColor),
                                      child: ListTile(
                                        title: Text(
                                          localization == Localization.English
                                              ? item.title_en ?? ""
                                              : item.title_kh ?? "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: KhmerFonts.siemreap,
                                            package: 'khmer_fonts',
                                          ),
                                        ),
                                        trailing: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                            size: 30.0),
                                      ))))))),
                      //         ),
                      //         LogoList(this.meta)
                      //       ]))
                    ])))),
            // Align(
            //     alignment: FractionalOffset.bottomCenter,
            //     child: Padding(
            //         padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            //         child: Container(
            //             height: 55.0,
            //             //width: 100.0,
            //             child: ElevatedButton(
            //               style: ElevatedButton.styleFrom(
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(9.0),
            //                 ),
            //                 backgroundColor:
            //                     Color(0xff028090), // Background color
            //               ),
            //               onPressed: () => Navigator.pop(context),
            //               child: Text(
            //                   localization == Localization.English
            //                       ? this.meta.home_en ?? ""
            //                       : this.meta.home_kh ?? "",
            //                   maxLines: 2,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.w600,
            //                     fontFamily: KhmerFonts.siemreap,
            //                     package: 'khmer_fonts',
            //                   )),
            //             ))))
          ]))));
    });
  }
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.575881332796119, 104.88892103990776),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _createMarker()),
    );
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
        markerId: MarkerId("DPA"),
        position: LatLng(11.575881332796119, 104.88892103990776),
        infoWindow:
            InfoWindow(title: 'Development and Partnership in Action (DPA)'),
      ),
    };
  }
}
