import 'dart:async';
import 'package:cms_manhattan/src/Models/ModelAddress.dart';
import 'package:cms_manhattan/src/Models/ModelCart.dart';
import 'package:cms_manhattan/src/Models/ModelCategory.dart';
import 'package:cms_manhattan/src/Models/ModelCity.dart';
import 'package:cms_manhattan/src/Models/ModelMessage.dart';
import 'package:cms_manhattan/src/Models/ModelNotification.dart';
import 'package:cms_manhattan/src/Models/ModelOrder.dart';
import 'package:cms_manhattan/src/Models/ModelPaymentHistory.dart';
import 'package:cms_manhattan/src/Models/ModelProduct.dart';
import 'package:cms_manhattan/src/Utils/NetworkUtil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart' as xml;

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://kuwmi.com/kuwmi_api/webservice";
  static final LOGIN_URL = BASE_URL + "/login";
  static final SIGNUP_URL = BASE_URL + "/signup";
  static final Banner_URL = BASE_URL + "/get_banner";
  static final Category_URL = BASE_URL + "/get_category";

  Future<dynamic> login(String username, String password) {
    return _netUtil.post(LOGIN_URL,
        body: {"email": username, "password": password}).then((dynamic res) {
      return res;
    });
  }

  Future<dynamic> signup(String username, String email, String password) {
    return _netUtil.post(SIGNUP_URL, body: {
      "first_name": username,
      "email": email,
      "password": password
    }).then((dynamic res) {
      print("MyData==>" + res.toString());
      return res;
    });
  }

  Future<List<ModelCategory>> getCategory(BuildContext context) async {
    String xmlData =
        await DefaultAssetBundle.of(context).loadString('data/category.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelCategory(
            e.findElements('id').first.text,
            e.findElements('cat_name').first.text,
            e.findElements('cat_image').first.text))
        .toList();
  }

  Future<List<ModelProduct>> getProduct(BuildContext context) async {
    String xmlData =
        await DefaultAssetBundle.of(context).loadString('data/products.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelProduct(
            e.findElements('id').first.text,
            e.findElements('product_name').first.text,
            e.findElements('product_description').first.text,
            e.findElements('qty').first.text,
            e.findElements('price').first.text,
            e.findElements('cut_off_price').first.text,
            e.findElements('short_des').first.text,
            e.findElements('image').first.text,
            double.parse(e.findElements('rating').first.text)))
        .toList();
  }

  Future<List<ModelMessage>> getMessage(BuildContext context) async {
    String xmlData =
        await DefaultAssetBundle.of(context).loadString('data/xml_message.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelMessage(
            e.findElements('id').first.text,
            e.findElements('user_name').first.text,
            e.findElements('message').first.text,
            e.findElements('date').first.text,
            e.findElements('image').first.text))
        .toList();
  }

  Future<List<ModelNotification>> getNotification(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context)
        .loadString('data/xml_notification.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelNotification(
            e.findElements('id').first.text,
            e.findElements('title').first.text,
            e.findElements('message').first.text,
            e.findElements('date').first.text))
        .toList();
  }
  Future<List<ModelAddress>> getAddress(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context)
        .loadString('data/xml_address.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelAddress(
            e.findElements('id').first.text,
            e.findElements('name').first.text,
            e.findElements('mobile').first.text,
            e.findElements('address').first.text,
            e.findElements('pin').first.text))
        .toList();
  }

  Future<List<ModelCity>> getCity(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context)
        .loadString('data/xml_city.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelCity(
        e.findElements('id').first.text,
        e.findElements('city').first.text))
        .toList();
  }
  Future<List<ModelPaymentHistory>> getPaymentHistory(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context)
        .loadString('data/xml_payment_history.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelPaymentHistory(
        e.findElements('id').first.text,
        e.findElements('name').first.text,
        e.findElements('amount').first.text,
        e.findElements('date').first.text,
        e.findElements('description').first.text))
        .toList();
  }
  Future<List<ModelOrder>> getOrderHistory(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context)
        .loadString('data/xml_order_history.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelOrder(
        e.findElements('id').first.text,
        e.findElements('order_id').first.text,
        e.findElements('payment_id').first.text,
        e.findElements('product_name').first.text,
        e.findElements('description').first.text,
        e.findElements('selling_price').first.text,
        e.findElements('amount').first.text,
        e.findElements('date').first.text,
        e.findElements('image').first.text))
        .toList();
  }
  Future<List<ModelCart>> getCart(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context)
        .loadString('data/xml_cart.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelCart(
        e.findElements('id').first.text,
        e.findElements('sellar_name').first.text,
        e.findElements('product_name').first.text,
        e.findElements('price').first.text,
        e.findElements('shipping_charge').first.text,
        e.findElements('qty').first.text,
        e.findElements('image').first.text))
        .toList();
  }
}
