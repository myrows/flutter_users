// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hey, welcome !`
  String get buttonMain {
    return Intl.message(
      'Hey, welcome !',
      name: 'buttonMain',
      desc: '',
      args: [],
    );
  }

  /// `Search users ..`
  String get searchUsersHint {
    return Intl.message(
      'Search users ..',
      name: 'searchUsersHint',
      desc: '',
      args: [],
    );
  }

  /// `Newest Date`
  String get newestDate {
    return Intl.message(
      'Newest Date',
      name: 'newestDate',
      desc: '',
      args: [],
    );
  }

  /// `Older Date`
  String get olderDate {
    return Intl.message(
      'Older Date',
      name: 'olderDate',
      desc: '',
      args: [],
    );
  }

  /// `Edit user`
  String get titlePopUpEdit {
    return Intl.message(
      'Edit user',
      name: 'titlePopUpEdit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get buttonPopUpEdit {
    return Intl.message(
      'Save',
      name: 'buttonPopUpEdit',
      desc: '',
      args: [],
    );
  }

  /// `Create user`
  String get titlePopUpCreate {
    return Intl.message(
      'Create user',
      name: 'titlePopUpCreate',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get buttonPopUpCreate {
    return Intl.message(
      'Create',
      name: 'buttonPopUpCreate',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editSlideOption {
    return Intl.message(
      'Edit',
      name: 'editSlideOption',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}