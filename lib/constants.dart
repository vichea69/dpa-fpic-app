// Base URL
import 'dart:io';

import 'package:flutter/material.dart';

import 'main.dart';

var meta = App.meta;

//const String ApiBaseUrl = 'https://fpicbackend.herokuapp.com';
const String ApiBaseUrl = "https://fpicbackend.analyticalx.org";

// Text
const String MainButtonTextLanguageKhmer = 'ភាសាខ្មែរ';
const String MainButtonTextLanguageEnglish = 'English';

// Colors
const Color MainBackgroundColor = Color(0xFF2A7C6B);
const Color DarkBackgroundColor = Color(0xff19aeb3);
const Color SecondBackgroundColor = Color(0xff028090);
const Color ThirdBackgroundColor = Color(0xff00d4d0);
const Color FourBackgroundColor = Color.fromARGB(157, 15, 17, 155);

// Links
final String ShareLink = Platform.isAndroid
    ? meta?.android_share_link ?? ""
    : Platform.isIOS
        ? meta?.ios_share_link ?? ""
        : "";
