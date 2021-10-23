import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/UI/ProductPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Filter {
  bool _isSelect1 = false;
  bool _isSelect2 = false;
  bool _isSelect3 = false;
  bool _isSelect4 = false;
  int _selectedFilter = 0;
  int _radioValue = -1;
  BuildContext context;
  var dis;
  Filter(this.context, this.dis);
  RestDatasource api = new RestDatasource();
  Widget DrawerFilter() {
    return Drawer();
  }

  Widget _drawerCondition() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                    onPressed: () => {
                          dis.setState(() {
                            _selectedFilter = 0;
                          })
                        },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Conditions",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "Done",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                    )),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('New(251)'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect1,
              onChanged: _onChangeValue1,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Open Box(112)'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect2,
              onChanged: _onChangeValue2,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Seller refurbished(251)'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect3,
              onChanged: _onChangeValue3,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Used(200)'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect4,
              onChanged: _onChangeValue4,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _drawerBrand() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                    onPressed: () => {
                          dis.setState(() {
                            _selectedFilter = 0;
                          })
                        },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Brands",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "Done",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                    )),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Brand 1'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect1,
              onChanged: _onChangeValue1,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Brand 2'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect2,
              onChanged: _onChangeValue2,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Brand 3'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect3,
              onChanged: _onChangeValue3,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Brand 4'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect4,
              onChanged: _onChangeValue4,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _drawerPrice() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                    onPressed: () => {
                          dis.setState(() {
                            _selectedFilter = 0;
                          })
                        },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Price",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "Done",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                    )),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Best Match'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect1,
              onChanged: _onChangeValue1,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Lowest Price + Shipping'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect2,
              onChanged: _onChangeValue2,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Highest Price + Shipping'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect3,
              onChanged: _onChangeValue3,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Ending Soonest'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect4,
              onChanged: _onChangeValue4,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _drawerCategory() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                    onPressed: () => {
                          dis.setState(() {
                            _selectedFilter = 0;
                          })
                        },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "Done",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                    )),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: api.getCategory(context),
                  builder: (context, data) {
                    if (data.hasData) {
                      List<ModelCategory> category = data.data as List<ModelCategory>? ?? [];
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: category.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                category[index].name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              leading: FadeInImage(
                                placeholder: AssetImage('images/logo.png'),
                                image: NetworkImage(
                                  category[index].image,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage.set(category: category[index])));
                              },
                            );
                          });
                    } else {
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))
        ],
      ),
    );
  }

  Widget _MainBody() {
    switch (_selectedFilter) {
      case 0:
        return _MainFilter();
      case 1:
        return _drawerCondition();
      case 2:
        return _drawerBrand();
      case 3:
        return _drawerCategory();
      default:
        return _drawerPrice();
    }
  }

  Widget _MainFilter() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Filter",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "Reset",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
                    )),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Sort'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(context);
              _Sort();
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Brands'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              dis.setState(() {
                _selectedFilter = 2;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Buying Format'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              dis.setState(() {
                _selectedFilter = 2;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Condition'),
            subtitle: Text('New'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              dis.setState(() {
                _selectedFilter = 1;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Price'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              dis.setState(() {
                _selectedFilter = 4;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Category'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              dis.setState(() {
                _selectedFilter = 3;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Lock Status'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              dis.setState(() {
                _selectedFilter = 1;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Future _Sort() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 500,
          color: Colors.transparent,
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Sort",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Best Match"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Lowest Price + Shipping"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 3,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Highest Price + Shipping"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 4,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Ending Soonest"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 5,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Newly Listed"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 8,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Distant: Nearest First"),
                      ],
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  void _handleRadioValueChange(int? value) {
    dis.setState(() {
      _radioValue = value ?? _radioValue;
      Navigator.pop(context);
    });
  }

  void _onChangeValue1(bool? value) {
    dis.setState(() {
      _isSelect1 = value ?? _isSelect1;
    });
  }

  void _onChangeValue2(bool? value) {
    dis.setState(() {
      _isSelect2 = value ?? _isSelect2;
    });
  }

  void _onChangeValue3(bool? value) {
    dis.setState(() {
      _isSelect3 = value ?? _isSelect3;
    });
  }

  void _onChangeValue4(bool? value) {
    dis.setState(() {
      _isSelect4 = value ?? _isSelect4;
    });
  }
}
