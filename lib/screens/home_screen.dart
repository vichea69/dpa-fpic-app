import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/bloc/menu_bloc.dart';
import 'package:fpic_app/bloc/menu_state.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/screens/error_screen.dart';
import 'package:fpic_app/screens/loading_screen.dart';
import 'package:khmer_fonts/khmer_fonts.dart';

import '../data/menupage.dart';
import '../screens/search_screen.dart';
import '../constants.dart';
import '../main.dart';
import '../widgets/home_list.dart';
import '../widgets/language_switcher.dart';
import '../widgets/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<MenuPage> _filterResults(String query, Localization localization) {
    var menus = App.menus;
    List<MenuPage> pages = [];
    menus.forEach((menu) {
      pages.addAll(menu.pages ?? []);
      if (menu.menus != null && menu.menus!.isNotEmpty) {
        menu.menus!.forEach((nestedMenu) {
          pages.addAll(nestedMenu.pages ?? []);
        });
      }
    });

    List<MenuPage> searchListData = [];
    if (query.isNotEmpty) {
      pages.forEach((item) {
        if (localization == Localization.English) {
          if (item.title_en.toLowerCase().contains(query.toLowerCase())) {
            searchListData.add(item);
          } else if (item.body_en.toLowerCase().contains(query.toLowerCase())) {
            searchListData.add(item);
          }
        } else if (localization == Localization.Khmer) {
          if (item.title_kh.toLowerCase().contains(query.toLowerCase())) {
            searchListData.add(item);
          } else if (item.body_kh.toLowerCase().contains(query.toLowerCase())) {
            searchListData.add(item);
          }
        }
      });
    }
    return searchListData;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Localization>(
      builder: (BuildContext context, Localization localization) {
        return BlocBuilder<MenuBloc, MenuState>(
          builder: (BuildContext context, MenuState state) {
            if (state is MenuLoading) {
              return LoadingScreen();
            }

            if (state is MenuLoadingSuccess) {
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
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
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
                            //     Color.fromARGB(255, 32, 82, 168), // A deep teal/blue at the top
                            //     // Color.fromARGB(255, 3, 147, 142), // A lighter teal in the middle
                            //     Color.fromARGB(255, 30, 173, 106), // Light cream/green bottom color
                            //   ],
                            // ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 48, 50, 50)
                                    .withOpacity(0.2),
                                blurRadius: 2,
                                offset: Offset(0, 5.0),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Top row: logout (left) and language switcher (right)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, left: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.logout,
                                          color: Colors.black87),
                                      tooltip: 'Logout',
                                      onPressed: () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Confirm logout'),
                                            content: const Text(
                                                'Are you sure you want to logout?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text('Logout'),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirm == true) {
                                          await AuthService.logout();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                const LoginScreen()),
                                                (route) => false,
                                          );
                                        }
                                      },
                                    ),
                                    LanguageSwitcher(),
                                  ],
                                ),
                              ),

                              // Search field
                              Container(
                                height: 70,
                                margin: EdgeInsets.only(
                                    top: 10.0, left: 30.0, right: 30.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (value) {
                                    var results =
                                    _filterResults(value, localization);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchScreen(value, results, meta!),
                                      ),
                                    );
                                  },
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: KhmerFonts.siemreap,
                                    package: 'khmer_fonts',
                                    decorationColor: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.search,
                                        color: Colors.black26),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(9.0)),
                                      borderSide: BorderSide(
                                          color: MainBackgroundColor,
                                          width: 1.0),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(9.0)),
                                      borderSide: BorderSide(
                                          color: Colors.black45, width: 1.0),
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    hintText: 'ស្វែងរកនៅទីនេះ(Find here)...',
                                  ),
                                ),
                              ),

                              // Small HomeList inside header
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 30.0, bottom: 20.0, left: 15.0, right: 15.0),
                          height: 70.0,
                          width: MediaQuery.of(context).size.width,
                          child: HomeList(App.menus, App.pages, meta!, true),
                        ),
                        const SizedBox(height: 10.0),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.black12,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.only(
                              left: 35.0, right: 15.0, top: 25.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'មេរៀនសំខាន់ៗ (Modules)',
                            style: TextStyle(
                              color: Color(0xFF595959),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: KhmerFonts.battambang,
                              package: 'khmer_fonts',
                            ),
                          ),
                        ),
                        // Main content list
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: HomeList(App.menus, App.pages, meta!, false),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (state is MenuLoadingFailure) {
              return ErrorScreen();
            }

            return Container();
          },
        );
      },
    );
  }
}
