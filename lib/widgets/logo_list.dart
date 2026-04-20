import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpic_app/widgets/image_component.dart';
import '../data/meta.dart';

class LogoList extends StatelessWidget {
  final List<dynamic> images;
  final double itemWidth;
  final double itemHeight;
  final double containerHeight;

  LogoList(this.images,
      {this.itemWidth = 100.0,
      this.itemHeight = 60.0,
      this.containerHeight = 80.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30.0, right: 30.0),
        height: containerHeight,
        width: MediaQuery.of(context).size.width - 10,
        child: Center(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var logo = images[index];
                  return Container(
                      // margin:
                      //     EdgeInsets.symmetric(horizontal: 0.3, vertical: 0.0),
                      height: itemHeight,
                      width: itemWidth,
                      child: FPICImage(logo,
                          fit: BoxFit.contain,
                          width: itemWidth,
                          height: itemHeight),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                              BorderRadius.all(Radius.circular(2.0))));
                })));
  }
}
