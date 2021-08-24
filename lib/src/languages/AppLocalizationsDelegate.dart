import 'package:cms_manhattan/src/languages/LanguageCh.dart';
import 'package:cms_manhattan/src/languages/LanguageEn.dart';
import 'package:cms_manhattan/src/languages/LanguageRu.dart';
import 'package:cms_manhattan/src/languages/LanguageSp.dart';
import 'package:cms_manhattan/src/languages/Languages.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'zh', 'ru'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    print('LanguageCode ${locale.languageCode}');
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'es':
        return LanguageSp();
      case 'zh':
        return LanguageCh();
      case 'ru':
        return LanguageRu();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;

}