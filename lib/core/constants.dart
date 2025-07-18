import 'package:flutter/material.dart';

class AppColors {
  static const Color green = Color(0XFF29D09E);
  static const Color lightGreen = Color(0xFFEAFFF8);
  static const Color white = Color(0XFFFFFFFF);
  static const Color black = Color(0XFF181920);
  static const Color grey = Color(0XFFB4B4B4);
  static const Color red = Colors.redAccent;
  static const Color transparent = Colors.transparent;

// Background
  static const Color kBackground = white;

// Texts
  static const Color kMainText = green;
  static const Color kDarkText = black;
  static const Color kLightText = white;
  static const Color kHintText = grey;
  static const Color kErrorText = red;

  // Icons
  static const Color kMainIcon = green;
  static const Color kSecondaryIcon = lightGreen;
  static const Color kLightIcon = white;
  static const Color kDarkIcon = black;
  static const Color kExtraIcon = grey;
  static const Color kErrorIcon = red;

// Containers
  static const Color kMainContainer = green;
  static const Color kSecondaryContainer = lightGreen;
  static const Color kLightContainer = white;
  static const Color kDarkContainer = black;
  static const Color kExtraContainer = grey;
  static const Color kDangerContainer = red;

// Buttons
  static const Color kMainButton = green;
  static const Color kLightButton = white;
  static const Color kDarkButton = grey;
  static const Color kMainOverlayButton = white;

// TextFields
  static const Color kMainTextFieldColor = white;

// DropDownMenu
  static const Color kDropDownMenu = grey;

// Borders
  static const Color kMainBorder = green;
  static const Color kDarkBorder = black;
  static const Color kErrorBorder = red;
  static const Color kExtraBorder = grey;

// Bars
  static const Color kAppBarBackground = white;
  static const Color kNavBarBackground = white;
}

class ApiConstants {
  static const baseUrl = 'https://dummyjson.com';
  static const productsEndpoint = '$baseUrl/products';
}
