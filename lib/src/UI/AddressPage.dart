import 'package:cms_manhattan_project/src/Models/ModelAddress.dart';
import 'package:cms_manhattan_project/src/UI/AddAddressPage.dart';
import 'package:cms_manhattan_project/src/UI/SuccessPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:cms_manhattan_project/src/languages/Languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<AddressPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  late RestDatasource api;
  int _radioValue1 = -1;
  _PageState() {
    api = new RestDatasource();
  }

  PreferredSizeWidget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text(
        Languages.of(dis).ShippingAddress,
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      actions: [
        IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
            tooltip: 'Add Address',
            onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressPage(() => {})))})
      ],
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
        appBar: _appBar(context),
        body: Column(children: [
          FutureBuilder(
              future: api.getAddress(context),
              builder: (context, data) {
                if (data.hasData) {
                  List<ModelAddress> list = data.data as List<ModelAddress>? ?? [];
                  return Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _Address(list[index], index);
                        }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ]),
      ),
    );
  }

  Widget _Address(ModelAddress address, int index) {
    return InkWell(
      child: Card(
          child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: index,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        address.mobile,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        address.address,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        address.pin,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
      onTap: () => {_handleRadioValueChange1(index)},
    );
  }

  void _handleRadioValueChange1(int? value) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SuccessPage()), (route) => false);
  }
}
