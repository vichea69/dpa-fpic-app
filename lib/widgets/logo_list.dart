import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpic_app/widgets/image_component.dart';
import '../data/meta.dart';

class LogoList extends StatelessWidget {
  final List<dynamic> images;

  LogoList(this.images);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30.0, right: 30.0),
        height: 30.0,
        width: MediaQuery.of(context).size.width - 10,
        child: Center(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var logo = images[index];
                  return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                      height: 40.0,
                      child: FPICImage(logo),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius:
                              BorderRadius.all(Radius.circular(2.0))));
                })));
  }
}
