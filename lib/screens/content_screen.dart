import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/data/document.dart';
import 'package:fpic_app/data/photo.dart';
import 'package:fpic_app/widgets/image_component.dart';
import 'package:khmer_fonts/khmer_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:fpic_app/constants.dart';
import 'package:fpic_app/data/menupage.dart';
import 'package:fpic_app/data/video.dart';

import '../data/menu.dart';
import '../widgets/header.dart';
import '../widgets/language_switcher.dart';
import '../main.dart';
import 'package:fpic_app/bloc/app_route.dart';

class YTPlayer extends StatefulWidget {
  final String url;

  YTPlayer(this.url, {super.key});

  @override
  YTPlayerState createState() => YTPlayerState();
}

class YTPlayerState extends State<YTPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    var id = YoutubePlayerController.convertUrlToId(widget.url);
    _controller = YoutubePlayerController.fromVideoId(
      videoId: id!,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableCaption: false,
        showVideoAnnotations: false,
        enableJavaScript: false,
        playsInline: false,
        loop: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      gestureRecognizers: const {},
      controller: _controller,
    );
    return YoutubePlayerControllerProvider(
      key: UniqueKey(),
      controller: _controller,
      child: player,
    );
  }
}

class ListItemVideo extends StatefulWidget {
  final YTPlayer video;

  ListItemVideo({required this.video});

  @override
  _ListItemVideoState createState() => _ListItemVideoState();
}

class _ListItemVideoState extends State<ListItemVideo>
    with AutomaticKeepAliveClientMixin<ListItemVideo> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(child: widget.video);
  }

  @override
  bool get wantKeepAlive => true;
}

class ContentScreen extends StatelessWidget {
  final Menu? menu;
  final MenuPage page;
  final bool isSearch;

  ContentScreen(this.menu, this.page, this.isSearch);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic> _retrieveContents(Localization localization) {
    var contents = [];

    if (this.page.photos != null && this.page.photos!.isNotEmpty) {
      contents.addAll(this.page.photos!);
    }

    if (this.page.videos != null && this.page.videos!.isNotEmpty) {
      contents.addAll(this.page.videos!);
    }

    if (localization == Localization.English) {
      if (this.page.documents_en != null &&
          this.page.documents_en!.isNotEmpty) {
        contents.addAll(this.page.documents_en!);
      }
    }

    if (localization == Localization.Khmer) {
      if (this.page.documents_kh != null &&
          this.page.documents_kh!.isNotEmpty) {
        contents.addAll(this.page.documents_kh!);
      }
    }

    return contents;
  }

  _onLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffcaf0f8)),
              ),
              Container(
                  margin: EdgeInsets.only(left: 5), child: Text("Loading")),
            ],
          ),
        );
      },
    );
  }

  _onError(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Unable to download file."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _downloadFile(String url, String filename) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    var directory = (await getApplicationDocumentsDirectory()).path;
    var path = "${directory}/${filename}";

    try {
      await File(path).readAsBytes();
      await OpenFile.open(path);
    } catch (exception) {
      if (exception is FileSystemException) {
        bool connectivity = await App.checker.check();
        if (connectivity) {
          try {
            _onLoading(_scaffoldKey.currentContext!);
            var request =
                await HttpClient().getUrl(Uri.parse("${ApiBaseUrl}${url}"));
            var response = await request.close();
            var bytes = await consolidateHttpClientResponseBytes(response);

            var newFile = File(path);
            await newFile.writeAsBytes(bytes);
            OpenFile.open(path);
          } catch (exception) {
            _onError(_scaffoldKey.currentContext!);
          }

          Navigator.pop(_scaffoldKey.currentContext!);
        } else {
          _onError(_scaffoldKey.currentContext!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Localization>(
      builder: (BuildContext context, Localization localization) {
        return Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
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
                  Stack(children: [
                    Header(null, this.page, useWhiteHeader: true),
                    Positioned(
                      top: 10,
                      right: 25,
                      child: LanguageSwitcher(),
                    ),
                  ]),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Container(
                        width: double.infinity,
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
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate([
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        localization == Localization.English
                                            ? this.page.body_en
                                            : this.page.body_kh,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Color(0xFF404040),
                                          fontSize: 16,
                                          height: 1.8,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: KhmerFonts.siemreap,
                                          package: 'khmer_fonts',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(List.generate(
                                _retrieveContents(localization).length,
                                (index) {
                                  var c =
                                      _retrieveContents(localization)[index];
                                  if (c is Video) {
                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: ListItemVideo(
                                            video: YTPlayer(c.url)));
                                  }

                                  if (c is Document) {
                                    return Card(
                                        margin: EdgeInsets.only(
                                            top: 10.0,
                                            left: 10.0,
                                            right: 10.0,
                                            bottom: 10),
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(9.0))),
                                          child: ListTile(
                                            leading: Icon(Icons.attach_file,
                                                color: Colors.black87),
                                            title: Text(
                                              c.name,
                                              style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: KhmerFonts.siemreap,
                                                package: 'khmer_fonts',
                                              ),
                                            ),
                                            onTap: () =>
                                                _downloadFile(c.url, c.name),
                                          ),
                                        ));
                                  }

                                  if (c is Photo) {
                                    return GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FPICImage(c.thumbnail),
                                        ),
                                        onTap: () =>
                                            _downloadFile(c.url, c.name));
                                  }
                                  return SizedBox(height: 100);
                                },
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Back action moved to AppBar leading (icon-only) in Header
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppRoute(
            currentIndex: App.tabIndex.value,
            onTap: (index) {
              App.tabIndex.value = index;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        );
      },
    );
  }
}
