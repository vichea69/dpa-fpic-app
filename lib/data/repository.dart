import 'dart:convert';

import 'package:fpic_app/data/menupage.dart';
import 'package:fpic_app/data/web_client.dart';
import 'package:fpic_app/main.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';

import '../constants.dart';
import 'meta.dart';

class Repository {
  final WebClient? _webClient;

  Repository({WebClient? webClient}) : _webClient = webClient ?? WebClient();

  Future<dynamic> saveMetaOffline() async {
    try {
      var local_meta = json.decode(App.localStorage.getString('Meta')!);

      var b64_image = local_meta['image'] != null
          ? await base64(local_meta['image'])
          : null;

      local_meta['image'] = b64_image;

      // funded by logos
      var funded_by_logos = local_meta['funded_by_logos'];

      List<String> fl = [];

      for (var logo in funded_by_logos) {
        var b64 = await base64(logo);
        fl.add(b64!);
      }

      local_meta['funded_by_logos'] = fl;

      // implemented by logos
      var implemented_by_logos = local_meta['implemented_by_logos'];

      List<String> il = [];

      for (var logo in implemented_by_logos) {
        var b64 = await base64(logo);
        il.add(b64!);
      }

      local_meta['implemented_by_logos'] = il;

      App.localStorage.setString('Meta', json.encode(local_meta));

      App.meta =
          Meta.fromJson(json.decode(App.localStorage.getString('Meta')!));
      print("saved meta offline");
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }

  Future<List<dynamic>> loadMeta() async {
    try {
      var meta = await _webClient?.get(ApiBaseUrl + '/metadata');

      meta['image'] = meta['image'] != null
          ? meta['image']['formats']['small']['url']
          : null;

      var funded_by_logos = meta['funded_by_logos'];

      List<String> fl = [];

      for (var logo in funded_by_logos) {
        fl.add(logo['url']);
      }

      meta['funded_by_logos'] = fl;

      var implemented_by_logos = meta['implemented_by_logos'];

      List<String> il = [];

      for (var logo in implemented_by_logos) {
        il.add(logo['url']);
      }

      meta['implemented_by_logos'] = il;

      App.localStorage.setString('Meta', json.encode(meta));
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }

    var local_meta =
        Meta.fromJson(json.decode(App.localStorage.getString('Meta')!));

    App.meta = local_meta;

    return [local_meta];
  }

  Future<List<dynamic>> loadPages() async {
    try {
      var pages =
          await _webClient?.get(ApiBaseUrl + '/pages?_where[menu_null]=true');

      pages = await processImages(pages, false);

      App.localStorage.setString('Pages', json.encode(pages));
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }

    var local_pages =
        (json.decode(App.localStorage.getString('Pages')!) as List)
            .map((item) => MenuPage.fromJson(item))
            .toList();

    App.pages = local_pages;
    return local_pages;
  }

  Future<List<dynamic>> loadMenus() async {
    try {
      var menus = await _webClient
          ?.get(ApiBaseUrl + '/menus?_where[menu_null]=true&_sort=order:ASC');

      menus = await processImages(menus, false);

      App.localStorage.setString('Menus', json.encode(menus));
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }

    // var local_menus =
    //     (json.decode(App.localStorage.getString('Menus')) as List)
    //         .map((item) => Menu.fromJson(item))
    //         .toList();
    List<Menu> local_menus =
        (json.decode(App.localStorage.getString('Menus') ?? '[]')
                as List<dynamic>)
            .map((item) => Menu.fromJson(item as Map<String, dynamic>))
            .toList();

    App.menus = local_menus;
    return local_menus;
  }

  Future saveOffline() async {
    var menus = (json.decode(App.localStorage.getString('Menus')!) as List);
    var pages = (json.decode(App.localStorage.getString('Pages')!) as List);

    try {
      menus = await processImages(menus, true);
      pages = await processImages(pages, true);

      App.localStorage.setString('Menus', json.encode(menus));
      App.localStorage.setString('Pages', json.encode(pages));

      var local_menus =
          (json.decode(App.localStorage.getString('Menus')!) as List)
              .map((item) => Menu.fromJson(item))
              .toList();

      var local_pages =
          (json.decode(App.localStorage.getString('Pages')!) as List)
              .map((item) => MenuPage.fromJson(item))
              .toList();

      App.menus = local_menus;
      App.pages = local_pages;
      print("saved offline");
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }

  Future processImages(dynamic data, bool forOfflineUsage) async {
    for (var menuOrPage in data) {
      menuOrPage['image'] = menuOrPage['image'] != null
          ? forOfflineUsage
              ? await base64(menuOrPage['image'])
              : menuOrPage['image']['formats']['small'] != null
                  ? menuOrPage['image']['formats']['small']['url']
                  : menuOrPage['image']['url']
          : null;

      // if is page, may contain video thumbnail
      if (menuOrPage['videos'] != null) {
        for (var video in menuOrPage['videos']) {
          video['thumbnail'] = video['thumbnail'] != null
              ? forOfflineUsage // checking if forOfflineUsage, otherwise just asign url
                  ? await base64(video['thumbnail'])
                  : video['thumbnail']
              : null;
        }
      }

      // if is page, may contain photos
      if (menuOrPage['photos'] != null) {
        for (var photo in menuOrPage['photos']) {
          photo['thumbnail'] = photo['url'] != null
              ? forOfflineUsage // checking if forOfflineUsage, otherwise just asign url
                  ? await base64(photo['url'])
                  : photo['url']
              : null;
        }
      }

      // recursively call function if nested menus or pages exist
      if (menuOrPage['menus'] != null) {
        menuOrPage['menus'] =
            await processImages(menuOrPage['menus'], forOfflineUsage);
      }
      if (menuOrPage['pages'] != null) {
        menuOrPage['pages'] =
            await processImages(menuOrPage['pages'], forOfflineUsage);
      }
    }

    return data;
  }

  Future<String?> base64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return bytes.isNotEmpty ? base64Encode(bytes) : null;
  }

  Future<bool> email(dynamic form) async {
    http.Response response =
        await _webClient?.post(ApiBaseUrl + '/email', form);

    var data = json.decode(response.body);

    var statusCode = data['statusCode'];

    if (statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
