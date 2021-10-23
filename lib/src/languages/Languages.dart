import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages)!;
  }

  String get appName;
  String get home;
  String get notification;
  String get message;
  String get saved;
  String get purchases;
  String get offers;
  String get selling;
  String get category;
  String get deals;
  String get setting;
  String get help;
  String get logout;
  String get ResetYourPassword;
  String get CreateAnAccount;
  String get SignIn;
  String get RegisterMessage;
  String get Email;
  String get Password;
  String get PasswordValidMessage;
  String get EmailValidMessage;
  String get MyProfile;
  String get MyOrder;
  String get ShippingAddress;
  String get PaymentMethod;
  String get Promocode;
  String get MyReview;
  String get Setting;
  String get Account;
  String get Genral;
  String get CountryOrRegion;
  String get Language;
  String get Support;
  String get CustomerService;
  String get About;
  String get TermAndConditions;
  String get labelWelcome;
  String get labelSelectLanguage;
  String get BuyNow;
  String get AddToCart;
  String get Cart;
  String get PaymentHistory;
  String get orderList;
  String get resolutionCenter;
}
