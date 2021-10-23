import 'dart:async';
import 'package:cms_manhattan_project/src/Models/ModelAddress.dart';
import 'package:cms_manhattan_project/src/Models/ModelCart.dart';
import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/Models/ModelCharge.dart';
import 'package:cms_manhattan_project/src/Models/ModelCity.dart';
import 'package:cms_manhattan_project/src/Models/ModelMessage.dart';
import 'package:cms_manhattan_project/src/Models/ModelNotification.dart';
import 'package:cms_manhattan_project/src/Models/ModelOrder.dart';
import 'package:cms_manhattan_project/src/Models/ModelPaymentHistory.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Models/ModelSearch.dart';
import 'package:cms_manhattan_project/src/Session/SessionManager.dart';
import 'package:cms_manhattan_project/src/Utils/NetworkUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://kuwmi.com/kuwmi_api/webservice";
  static final LOGIN_URL = BASE_URL + "/login";
  static final SIGNUP_URL = BASE_URL + "/signup";
  static final Banner_URL = BASE_URL + "/get_banner";
  static final Category_URL = BASE_URL + "/get_category";

  Future<dynamic> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {"email": username, "password": password}).then((dynamic res) {
      return res;
    });
  }

  Future<dynamic> signup(String username, String email, String password) {
    return _netUtil.post(SIGNUP_URL, body: {"first_name": username, "email": email, "password": password}).then((dynamic res) {
      return res;
    });
  }

  Future<List<ModelCategory>> getCategory(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/category.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelCategory(e.findElements('id').first.text, e.findElements('cat_name').first.text, e.findElements('cat_image').first.text))
        .toList();
  }

  Future<List<MultiSelectItem<dynamic>>> getCategoryForAddProduct(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/category.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map(
          (e) => MultiSelectItem<ModelCategory>(
            ModelCategory(e.findElements('id').first.text, e.findElements('cat_name').first.text, e.findElements('cat_image').first.text),
            e.findElements('cat_name').first.text,
          ),
        )
        .toList();
  }

  Future<List<ModelCategory>> getCategoryForPostProduct(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/category.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map(
          (e) => ModelCategory(
            e.findElements('id').first.text,
            e.findElements('cat_name').first.text,
            e.findElements('cat_image').first.text,
          ),
        )
        .toList();
  }

  Future<List<ModelProduct>> getProduct(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/products.xml');
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
            double.parse(e.findElements('rating').first.text),
            e.findElements('sellar_name').first.text,
            e.findElements('shipping_charge').first.text))
        .toList();
  }

  Future<List<ModelProduct>> searchProduct(BuildContext context, String value) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/products.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    var textual = elements.where((node) => node.findElements('product_name').first.text.toLowerCase().contains(value.toLowerCase()));
    return textual
        .map((e) => ModelProduct(
            e.findElements('id').first.text,
            e.findElements('product_name').first.text,
            e.findElements('product_description').first.text,
            e.findElements('qty').first.text,
            e.findElements('price').first.text,
            e.findElements('cut_off_price').first.text,
            e.findElements('short_des').first.text,
            e.findElements('image').first.text,
            double.parse(e.findElements('rating').first.text),
            e.findElements('sellar_name').first.text,
            e.findElements('shipping_charge').first.text))
        .toList();
  }

  Future<List<ModelMessage>> getMessage(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_message.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelMessage(e.findElements('id').first.text, e.findElements('user_name').first.text, e.findElements('message').first.text,
            e.findElements('date').first.text, e.findElements('image').first.text))
        .toList();
  }

  Future<List<ModelNotification>> getNotification(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_notification.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelNotification(e.findElements('id').first.text, e.findElements('title').first.text, e.findElements('message').first.text,
            e.findElements('date').first.text))
        .toList();
  }

  Future<List<ModelAddress>> getAddress(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_address.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements
        .map((e) => ModelAddress(e.findElements('id').first.text, e.findElements('name').first.text, e.findElements('mobile').first.text,
            e.findElements('address').first.text, e.findElements('pin').first.text))
        .toList();
  }

  Future<List<ModelCity>> getCity(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_city.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    return elements.map((e) => ModelCity(e.findElements('id').first.text, e.findElements('city').first.text)).toList();
  }

  Future<List<ModelPaymentHistory>> getPaymentHistory(BuildContext context, String value) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_payment_history.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    var textual = elements.where((node) =>
        node.findElements('id').first.text.toLowerCase().contains(value.toLowerCase()) ||
        node.findElements('name').first.text.toLowerCase().contains(value.toLowerCase()) ||
        node.findElements('date').first.text.toLowerCase().contains(value.toLowerCase()));

    return textual
        .map((e) => ModelPaymentHistory(e.findElements('id').first.text, e.findElements('name').first.text, e.findElements('amount').first.text,
            e.findElements('date').first.text, e.findElements('description').first.text))
        .toList();
  }

  Future<List<ModelOrder>> getOrderHistory(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_order_history.xml');
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

  Future<List<ModelOrder>> getOrderHistorySearch(BuildContext context, String value,
      {int from_price = 0, int to_price = 0, String from_date = '', String to_date = ''}) async {
    final DateFormat formatter = DateFormat('M/d/yyyy');
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_order_history.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    var textual = elements.where((node) =>
        node.findElements('order_id').first.text.toLowerCase().contains(value.toLowerCase()) ||
        node.findElements('payment_id').first.text.toLowerCase().contains(value.toLowerCase()) ||
        node.findElements('product_name').first.text.toLowerCase().contains(value.toLowerCase()));

    if (to_price > from_price) {
      textual = textual.where((node) => (double.parse(node.findElements('selling_price').first.text.replaceAll("\$", "")) > from_price &&
          double.parse(node.findElements('selling_price').first.text.replaceAll("\$", "")) < to_price));
    } else {
      if (from_price > 0) {
        textual = textual.where((node) => (double.parse(node.findElements('selling_price').first.text.replaceAll("\$", "")) > from_price));
      }
    }
    if (!from_date.contains("From Date")) {
      var date = formatter.parse(from_date);
      textual = textual.where((node) => date.isBefore(formatter.parse(node.findElements('date').first.text)));
    }
    if (!to_date.contains("To Date")) {
      var date = formatter.parse(to_date);
      textual = textual.where((node) => date.isAfter(formatter.parse(node.findElements('date').first.text)));
    }

    return textual
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
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_cart.xml');
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

  Future<ModelCharge> getTotal(BuildContext context) async {
    String xmlData = await DefaultAssetBundle.of(context).loadString('data/xml_cart.xml');
    var row = xml.XmlDocument.parse(xmlData);
    var elements = row.findAllElements('record');
    final total = elements.map((node) => double.parse(node.findElements('price').first.text.replaceAll("\$", ""))).reduce((a, b) => a + b);
    final shipping =
        elements.map((node) => double.parse(node.findElements('shipping_charge').first.text.replaceAll("\$", ""))).reduce((a, b) => a + b);
    double subTotal = total + shipping;
    int itemCount = elements.map((e) => null).length;
    return ModelCharge(total.toStringAsFixed(2), shipping.toStringAsFixed(2), "0", itemCount, subTotal.toStringAsFixed(2));
  }

  Future<ModelCharge> getTotalCart(BuildContext context) async {
    SessionManager manager = new SessionManager();
    List<ModelProduct> cart = await manager.getFromCart();
    final total = cart.map((node) => double.parse(node.price.replaceAll("\$", ""))).reduce((a, b) => a + b);
    final shipping = cart.map((node) => double.parse(node.shipping_charge.replaceAll("\$", ""))).reduce((a, b) => a + b);
    double subTotal = total + shipping;
    int itemCount = cart.length;
    return ModelCharge(total.toStringAsFixed(2), shipping.toStringAsFixed(2), "0", itemCount, subTotal.toStringAsFixed(2));
  }

  Future<String> getHtml(BuildContext context) async {
    String htmlData = await DefaultAssetBundle.of(context).loadString('data/mail.html');
    return htmlData;
  }
}
