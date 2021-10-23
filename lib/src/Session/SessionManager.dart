import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Models/ModelSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionManager {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? '');
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  //TODO: Cart Crd
  AddToCart(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("cart", value);
  }

  UpdateToCart(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("cart", value);
  }

  Future<List<ModelProduct>> getFromCart() async {
    final prefs = await SharedPreferences.getInstance();
    return ModelProduct.decode(prefs.getString('cart') ?? '');
  }

  readCartSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cart');
  }

  //TODO: Saved Crd
  AddToSaved(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("saved", value);
  }

  Future<List<ModelProduct>> getFromSaved() async {
    final prefs = await SharedPreferences.getInstance();
    return ModelProduct.decode(prefs.getString('saved') ?? '');
  }

  readSavedSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('saved');
  }

  //TODO: Offer Crd
  AddToOffer(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("offer", value);
  }

  Future<List<ModelProduct>> getFromOffer() async {
    final prefs = await SharedPreferences.getInstance();
    return ModelProduct.decode(prefs.getString('offer') ?? '');
  }

  readOfferSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('offer');
  }

  //TODO: Feed Crd
  AddToFeed(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("feed", value);
  }

  Future<List<ModelProduct>> getFromFeed() async {
    final prefs = await SharedPreferences.getInstance();
    return ModelProduct.decode(prefs.getString('feed') ?? '');
  }

  readFeedSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('feed');
  }

  //TODO: Recent
  AddToRecent(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("recent", value);
  }

  UpdateToRecent(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("recent", value);
  }

  Future<List<ModelSearch>> getFromRecent() async {
    final prefs = await SharedPreferences.getInstance();
    return ModelSearch.decode(prefs.getString('recent') ?? '');
  }

  readRecentSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('recent');
  }

  //TODO: Recent
  AddToSearchSaved(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("search_saved", value);
  }

  UpdateToSearchSaved(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("search_saved", value);
  }

  Future<List<ModelSearch>> getFromSearchSaved() async {
    final prefs = await SharedPreferences.getInstance();
    return ModelSearch.decode(prefs.getString('search_saved') ?? '');
  }

  readSearchSavedSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('search_saved');
  }

//============
  ClearAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
