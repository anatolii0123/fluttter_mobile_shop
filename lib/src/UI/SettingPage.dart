import 'package:cms_manhattan_project/src/UI/AllCMSImages.dart';
import 'package:cms_manhattan_project/src/UI/UsersList.dart';
import 'package:cms_manhattan_project/src/languages/Languages.dart';
import 'package:cms_manhattan_project/src/languages/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

enum SingingCharacter { en, sp, ch, ru }

class _PageState extends State<SettingPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isLoading = false;
  String _character = "en";
  SettingPage() {
    getLanguage();
  }

  void getLanguage() async {
    getLocale().then((locale) {
      print("locale ${locale.countryCode}");
      setState(() {
        _character = locale.countryCode ?? _character;
      });
    });
  }

  PreferredSizeWidget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text(
        Languages.of(dis).MyProfile,
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Languages.of(context).Account,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(Languages.of(context).SignIn),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(Languages.of(context).notification),
                  onTap: () {},
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Languages.of(context).Genral,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(Languages.of(context).CountryOrRegion),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(Languages.of(context).Language),
                  onTap: () {
                    MyBottomSheet(context);
                  },
                ),
                ListTile(
                  title: Text('Users List'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UsersList(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('CMS Images'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AllCMSImages(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Languages.of(context).Support,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(Languages.of(context).CustomerService),
                  onTap: () {},
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Languages.of(context).About,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(Languages.of(context).TermAndConditions),
                  subtitle: Text('6.9.3.1'),
                  onTap: () {},
                ),
              ],
            ),
          )),
    );
  }

  Future<void> MyBottomSheet(dis) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(Languages.of(dis).labelSelectLanguage),
              ListTile(
                title: const Text('English'),
                onTap: () => {updateLanguage("en")},
                leading: Radio(
                  value: "en",
                  groupValue: _character,
                  onChanged: (String? value) {
                    setState(() {
                      _character = value ?? _character;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Spanish'),
                onTap: () => {updateLanguage("es")},
                leading: Radio(
                  value: "es",
                  groupValue: _character,
                  onChanged: (String? value) {
                    setState(() {
                      _character = value ?? _character;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Chinese'),
                onTap: () => {updateLanguage("zh")},
                leading: Radio(
                  value: "zh",
                  groupValue: _character,
                  onChanged: (String? value) {
                    setState(() {
                      _character = value ?? _character;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Russian'),
                onTap: () => {updateLanguage("ru")},
                leading: Radio(
                  activeColor: Colors.blue,
                  value: "ru",
                  groupValue: _character,
                  onChanged: (String? value) {
                    setState(() {
                      _character = value ?? _character;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void updateLanguage(languageCode) async {
    setLocale(languageCode).then((locale) {
      Navigator.pop(context);
      setState(() {
        _character = languageCode;
      });
    });
  }
}
