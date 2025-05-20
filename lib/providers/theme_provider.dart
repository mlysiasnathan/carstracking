import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isInit = false;
  Locale locale = const Locale('fr');
  ThemeMode themeMode = ThemeMode.dark;
  bool isFirstTime = true;

  Future<void> getStarted() async {
    isFirstTime = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final actualTheme = {
      'lang': locale.languageCode,
      'themeMode': themeMode.index,
      'isFirstTime': isFirstTime,
    };
    final themData = json.encode(actualTheme);
    prefs.setString('themData', themData);
  }

  Future<void> getIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('themData')) {
      return;
    }
    final extractedThemeData =
        json.decode(prefs.getString('themData').toString());
    locale = Locale(extractedThemeData['lang'] ?? 'EN');
    isFirstTime = extractedThemeData['isFirstTime'] ?? false;
    extractedThemeData['themeMode'] == ThemeMode.light.index
        ? themeMode = ThemeMode.light
        : extractedThemeData['themeMode'] == ThemeMode.dark.index
            ? themeMode = ThemeMode.dark
            : themeMode = ThemeMode.system;
    notifyListeners();
  }

  Future<void> getOut() async {
    final prefs = await SharedPreferences.getInstance();
    final actualTheme = {
      'lang': locale.languageCode,
      'themeMode': themeMode.index,
      'isFirstTime': isFirstTime,
    };
    final themData = json.encode(actualTheme);
    prefs.setString('themData', themData);
  }

  void changeLanguage() {
    if (locale == const Locale('en')) {
      locale = const Locale('fr');
    } else {
      locale = const Locale('en');
    }
    notifyListeners();
    getOut();
  }

  void followTheSystem() {
    if (themeMode != ThemeMode.system) {
      themeMode = ThemeMode.system;
      notifyListeners();
      getOut();
    }
  }

  void setLightTheme() {
    if (themeMode != ThemeMode.light) {
      themeMode = ThemeMode.light;
      notifyListeners();
      getOut();
    }
  }

  void setDarkTheme() {
    if (themeMode != ThemeMode.dark) {
      themeMode = ThemeMode.dark;
      notifyListeners();
      getOut();
    }
  }
}
