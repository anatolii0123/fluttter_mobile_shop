import 'package:cms_manhattan_project/src/Models/ModelCity.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef StepValue = Function();

class AddAddressPage extends StatefulWidget {
  StepValue callback;

  AddAddressPage(this.callback);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<AddAddressPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  ModelCity? SelectedCity;
  String? _neighborhood, _street;
  bool isLoading = false;
  late RestDatasource api;
  String? userID;

  _PageState() {
    api = new RestDatasource();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('id');
  }

  void AddAddress() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        isLoading = true;
      });
      form.save();
      Navigator.pop(context);
      /* api.AddAddress(userID, SelectedCity.name, _neighborhood, _street).then((value) => {
        setState((){
          isLoading=false;
        }),
        if(value.status=="1"){
          Fluttertoast.showToast('Address Added Successfully', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM),
          widget.callback(),
          Navigator.pop(context)
        }else{
          Fluttertoast.showToast('Failed, Please Try Again!', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM),
        }
      }
      );

      */
    }
  }

  Widget _Mobile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Mobile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 10 ? "Mobile must have at least 10 chars" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  Widget _FullName() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Full name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "full name must have at least 3 chars" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  Widget _City() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "City",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "City must have at least 3 chars" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  Widget _State() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "State",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "State must have at least 3 chars" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  Widget _Zip() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Zip",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: (value) => _street = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "Zip must have at least 3 chars" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Expanded(
              child: Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _FullName(),
                        SizedBox(
                          height: 10,
                        ),
                        _Mobile(),
                        SizedBox(
                          height: 10,
                        ),
                        _City(),
                        SizedBox(
                          height: 10,
                        ),
                        _State(),
                        SizedBox(
                          height: 10,
                        ),
                        _Zip(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Country',
                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder(
                            future: api.getCity(context),
                            builder: (context, value) {
                              if (value.hasData) {
                                List<ModelCity> city = value.data as List<ModelCity>? ?? [];
                                return DropdownButton<ModelCity>(
                                  isExpanded: true,
                                  value: SelectedCity == null ? city[0] : SelectedCity,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  dropdownColor: Colors.white,
                                  style: TextStyle(color: Colors.red, fontSize: 18),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (ModelCity? data) {
                                    /*setState(() {
                              SelectedCity = data;
                            });*/
                                  },
                                  items: city.map<DropdownMenuItem<ModelCity>>((ModelCity value) {
                                    return DropdownMenuItem<ModelCity>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        style: TextStyle(color: Colors.black, backgroundColor: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          child: isLoading ? CircularProgressIndicator() : Text('Submit', style: TextStyle(fontSize: 20)),
                          onPressed: () => {
                            AddAddress(),
                          },
                          color: Colors.blueGrey,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  )),
            ),
          )),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Add Address',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.white,
    );
  }
}
