import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum ProductPageType {
  Category,
  Search,
}

class ProductPage extends StatefulWidget {
  ModelCategory? category;
  late ProductPageType productPageType;
  late String searchString;

  @override
  _PageState createState() => _PageState();

  ProductPage() {
    searchString = '';
    productPageType = ProductPageType.Category;
  }

  ProductPage.set({
    this.category,
    this.productPageType = ProductPageType.Category,
    this.searchString = '',
  });
}

class _PageState extends State<ProductPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isLoading = false;
  late RestDatasource api;
  int _radioValue = -1;
  int _selectedFilter = 0;
  bool _isSelect1 = false;
  bool _isSelect2 = false;
  bool _isSelect3 = false;
  bool _isSelect4 = false;

  _PageState() {
    api = new RestDatasource();
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        (widget.productPageType == ProductPageType.Category ? widget.category?.cat_name : widget.searchString).toString(),
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      actions: [Container()],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: _appBar(),
        endDrawer: _drawerFilter(),
        body: Column(
          children: [
            Card(
              elevation: 5,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: widget.productPageType == ProductPageType.Category
                          ? Container()
                          : Container(
                              alignment: AlignmentDirectional.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.blue,
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Save this Search",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onPressed: () => {},
                                  ),
                                ],
                              ),
                            )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sort,
                            color: Colors.blue,
                          ),
                          TextButton(
                            child: Text(
                              "Sort",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () => {_Sort()},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.blue,
                          ),
                          TextButton(
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () => {_scaffoldKey.currentState?.openEndDrawer()},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: api.getProduct(context),
                builder: (context, data) {
                  if (data.hasData) {
                    List<ModelProduct> list = data.data as List<ModelProduct>? ?? [];
                    return Expanded(
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage.set(list[index])))},
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FadeInImage(
                                      placeholder: AssetImage('images/logo.png'),
                                      image: NetworkImage(
                                        list[index].image,
                                      ),
                                      width: 100.0,
                                      height: 80,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index].name,
                                            maxLines: 1,
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            list[index].short_des,
                                            maxLines: 2,
                                            softWrap: true,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ), //*
                                          RatingBar.builder(
                                            initialRating: list[index].rating,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 10,
                                            itemSize: 15,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                list[index].price,
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                list[index].cut_off,
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _Search() {
    return Container(
      padding: EdgeInsets.all(5.0),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey[200]),
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: [
          Icon(Icons.search),
          Container(
            width: MediaQuery.of(context).size.width * 0.66,
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text(
              "Search for a...",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            widthFactor: 1,
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              children: [
                Icon(Icons.mic_outlined),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.camera_alt_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _child_category() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 40.0,
        child: FutureBuilder(
            future: widget.productPageType == ProductPageType.Category ? api.getCategory(context) : api.searchProduct(context, widget.searchString),
            builder: (context, data) {
              if (data.hasData) {
                List<ModelCategory> category = data.data as List<ModelCategory>? ?? [];
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage.set(category: category[index])))},
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey[200]),
                            child: Row(
                              children: [
                                FadeInImage(
                                  placeholder: AssetImage('images/logo.png'),
                                  image: NetworkImage(
                                    category[index].image,
                                  ),
                                  height: 40.0,
                                  width: 40.0,
                                ),
                                Text(
                                  category[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            )),
                      );
                    });
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget _drawerFilter() {
    return Drawer(child: _MainBody());
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
                          setState(() {
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
                          setState(() {
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
                          setState(() {
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
                          setState(() {
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

  Widget _drawerCriteria() {
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
                          setState(() {
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
                      "Criteria",
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
            title: Text('Criteria 1'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect1,
              onChanged: _onChangeValue1,
            ),
            onTap: () {
              _onChangeValue1(!_isSelect1);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Criteria 2'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect2,
              onChanged: _onChangeValue2,
            ),
            onTap: () {
              _onChangeValue2(!_isSelect2);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Criteria 3'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect3,
              onChanged: _onChangeValue3,
            ),
            onTap: () {
              _onChangeValue3(!_isSelect3);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Criteria 4'),
            trailing: Checkbox(
              activeColor: Colors.blue,
              value: _isSelect4,
              onChanged: _onChangeValue4,
            ),
            onTap: () {
              _onChangeValue4(!_isSelect4);
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
      case 4:
        return _drawerPrice();
      default:
        return _drawerCriteria();
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
              setState(() {
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
              setState(() {
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
              setState(() {
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
              setState(() {
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
              setState(() {
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
              setState(() {
                _selectedFilter = 1;
              });
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Criteria'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              setState(() {
                _selectedFilter = 5;
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
    setState(() {
      _radioValue = value ?? _radioValue;
      Navigator.pop(context);
    });
  }

  void _onChangeValue1(bool? value) {
    setState(() {
      _isSelect1 = value ?? _isSelect1;
    });
  }

  void _onChangeValue2(bool? value) {
    setState(() {
      _isSelect2 = value ?? _isSelect2;
    });
  }

  void _onChangeValue3(bool? value) {
    setState(() {
      _isSelect3 = value ?? _isSelect3;
    });
  }

  void _onChangeValue4(bool? value) {
    setState(() {
      _isSelect4 = value ?? _isSelect4;
    });
  }
}
