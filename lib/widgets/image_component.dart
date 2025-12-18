import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fpic_app/constants.dart';

class FPICImage extends StatelessWidget {
  final String image;
  final BoxFit? fit;
  final double? width;
  final double? height;

  FPICImage(this.image, {this.fit, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${ApiBaseUrl}${image}",
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
          padding: EdgeInsets.all(8),
          child: Center(
              child: Container(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffcaf0f8)))))),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
