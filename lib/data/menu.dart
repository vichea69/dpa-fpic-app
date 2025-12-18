import 'package:fpic_app/data/menupage.dart';

class Menu {
  final int id;
  final String title_en;
  final String title_kh;
  final String subtitle_en;
  final String subtitle_kh;
  final String image;
  final List<MenuPage>? pages;
  final List<Menu>? menus;

  Menu(this.id, this.title_en, this.title_kh, this.subtitle_en,
      this.subtitle_kh, this.image, this.pages, this.menus);

  Menu.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title_en = json['title_en'],
        title_kh = json['title_kh'],
        subtitle_en = json['subtitle_en'],
        subtitle_kh = json['subtitle_kh'],
        image = json['image'] ?? "",
        pages = json['pages'] != null
            ? (json['pages'] as List).map((i) => MenuPage.fromJson(i)).toList()
            : null,
        menus = json['menus'] != null
            ? (json['menus'] as List).map((i) => Menu.fromJson(i)).toList()
            : null;
}
