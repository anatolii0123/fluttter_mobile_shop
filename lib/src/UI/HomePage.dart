import 'package:cms_manhattan/src/Models/ModelCategory.dart';
import 'package:cms_manhattan/src/Models/ModelProduct.dart';
import 'package:cms_manhattan/src/UI/CartPage.dart';
import 'package:cms_manhattan/src/UI/LoginPage.dart';
import 'package:cms_manhattan/src/UI/MainCategoryPage.dart';
import 'package:cms_manhattan/src/UI/MessagePage.dart';
import 'package:cms_manhattan/src/UI/OffersPage.dart';
import 'package:cms_manhattan/src/UI/OrderHistoryPage.dart';
import 'package:cms_manhattan/src/UI/PaymentHistoryPage.dart';
import 'package:cms_manhattan/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan/src/UI/ProductPage.dart';
import 'package:cms_manhattan/src/UI/ProfilePage.dart';
import 'package:cms_manhattan/src/UI/RegisterPage.dart';
import 'package:cms_manhattan/src/UI/NotificationPage.dart';
import 'package:cms_manhattan/src/UI/SavedPage.dart';
import 'package:cms_manhattan/src/UI/PurchasesPage.dart';
import 'package:cms_manhattan/src/UI/SearchPage.dart';
import 'package:cms_manhattan/src/UI/SellingPage.dart';
import 'package:cms_manhattan/src/UI/SettingPage.dart';
import 'package:cms_manhattan/src/UI/SubCategoryPage.dart';
import 'package:cms_manhattan/src/languages/Languages.dart';
import 'package:flutter/material.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}
class _PageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _home_title="CMS Manhattan";
  String title="CMS Manhattan";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  RestDatasource api;
  _PageState(){
    api=new RestDatasource();
  }
  Widget _drawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 100,
              color: Colors.white,
              child: InkWell(
                child:Row(
                  children: [
                    SizedBox(width: 30,),
                    Icon(Icons.supervised_user_circle_sharp,color: Colors.blue,),
                    SizedBox(width: 10,),
                    Text("Sign In",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue
                    ),)
                  ],
                ),
                onTap: ()=>{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()))
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(Languages.of(context).home),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(Languages.of(context).notification),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text(Languages.of(context).message),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text('My CMS', style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(Languages.of(context).saved),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text(Languages.of(context).purchases),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(4);
              },
            ),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text(Languages.of(context).offers),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(5);
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text(Languages.of(context).selling),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(6);
              },
            ),
            ListTile(
              leading: Icon(Icons.payments),
              title: Text(Languages.of(context).PaymentHistory),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(12);
              },
            ),
            ListTile(
              leading: Icon(Icons.reorder),
              title: Text(Languages.of(context).orderList),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(13);
              },
            ),
            ListTile(
              leading: Icon(Icons.business_center_rounded),
              title: Text(Languages.of(context).resolutionCenter),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(14);
              },
            ),
            Divider(
              color: Colors.grey,
              height: 1,
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(Languages.of(context).category),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(7);
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text(Languages.of(context).deals),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(9);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(Languages.of(context).setting),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(11);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(Languages.of(context).help),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(Languages.of(context).logout),
              onTap: () {
                Navigator.pop(context);

              },
            ),
          ],
        ),
      )
    );
  }
  Widget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text(_home_title,style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 25
      ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,//change your color here
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          icon:  Icon(Icons.shopping_cart_outlined,size: 30,),
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
          },
        ),
      ],
    );
  }

  Widget _product() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 220,
      child:FutureBuilder(
        future: api.getProduct(context),
        builder: (context,data){
          if(data.hasData){
            List<ModelProduct>list=data.data;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: 180,
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child:InkWell(
                        child:Card(
                          child: Column(
                            children: [
                              FadeInImage(
                                placeholder: AssetImage('images/logo.png'),
                                image: NetworkImage(list[index].image,),
                                height: 100.0,
                                width: 150.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      list[index].name,
                                      softWrap: true,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      list[index].short_des,
                                      softWrap: true,
                                      maxLines: 2,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),//*
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
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsPage.set(list[index])));
                        },
                      )

                  );
                });
          }else{
            return Container(child: CircularProgressIndicator());
          }
        }
      )
    );
  }


  void _onItemTapped(int index) {
    if(index==0){
      title=Languages.of(context).appName;
    }else if(index==1){
      title=Languages.of(context).notification;
    }else if(index==2){
      title=Languages.of(context).message;
    }else if(index==3){
      title=Languages.of(context).saved;
    }else if(index==4){
      title=Languages.of(context).purchases;
    }else if(index==5){
      title=Languages.of(context).offers;
    }else if(index==6){
      title=Languages.of(context).selling;
    }else if(index==7){
      title=Languages.of(context).category;
    }else if(index==9){
      title=Languages.of(context).deals;
    }else if(index==11){
      title=Languages.of(context).setting;
    }else if(index==12){
      title=Languages.of(context).PaymentHistory;
    }else if(index==13){
      title=Languages.of(context).orderList;
    }else if(index==14){
      title=Languages.of(context).resolutionCenter;
    }
    setState(() {
      _selectedIndex = index;
      _home_title=title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: _appBar(),
      body: _Body(_selectedIndex),
      drawer: _drawer(),
      backgroundColor: Colors.white,
    );
  }
  Widget _Body(int pos){
    if(pos==0){
      return _HomePage();
    }else if(pos==1){
      return NotificationPage();
    }else if(pos==2){
      return MessagePage();
    }else if(pos==3){
      return SavedPage();
    }else if(pos==4){
      return PurchasesPage();
    }else if(pos==5){
      return OffersPage();
    }else if(pos==6){
      return SellingPage();
    }else if(pos==7){
      return MainCategoryPage();
    }else if(pos==9||pos==10){
      return ProductPage();
    }else if(pos==11){
      return SettingPage();
    }else if(pos==12){
      return PaymentHistoryPage();
    }else if(pos==13){
      return OrderHistoryPage();
    }else if(pos==14){
      return PurchasesPage();
    }else{
      return _HomePage();
    }
  }
  Widget _Search(){
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(5.0),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey[100]),
        margin: EdgeInsets.all(5.0),
        child: Row(
          children: [
            Icon(Icons.search,),
            Container(
              width: MediaQuery.of(context).size.width * 0.66,
              margin: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 8.0),
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
                  Icon(Icons.mic_outlined,color: Colors.grey[400],),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.camera_alt_outlined,color: Colors.grey[400],)
                ],
              ),
            )
          ],
        ),
      ),
      onTap: ()=>{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()))
      },
    );

  }
  Widget _HomePage(){
    return SingleChildScrollView(
      child: Column(
        children: [
          _Search(),
          _Menus(),
          Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Sign in wp we can personalize your eBay experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ButtonSignUp(),
                        SizedBox(
                          width: 20,
                        ),
                        _ButtonLogin(),
                      ],
                    ),
                  )
                ],
              )
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 15.0),
            child: Text(
              "Daily Deals",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          _product(),
          Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 15.0),
            child: Text(
              "Recommended sellers",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          _product(),
          Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 15.0),
            child: Text(
              "Sponsored",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          _product(),
          Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 15.0),
            child: Text(
              "Popular Destinations",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          _Popular()
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
      child:FutureBuilder(
        future: api.getCategory(context),
        builder: (context, data){
          if(data.hasData){
            List<ModelCategory>category=data.data;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap:()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage.set(category[index])))
                  },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey[200]),
                        child: Row(
                          children: [
                            FadeInImage(
                              placeholder: AssetImage('images/logo.png'),
                              image: NetworkImage(category[index].image,),
                              height: 40.0,
                              width: 40.0,
                            ),
                            Text(
                              category[index].name,
                              style: TextStyle(fontSize: 16, color: Colors.blue,),
                            ),
                          ],
                        )
                    ),
                  );
                });
          }else{
            return Container(child: CircularProgressIndicator(),);
          }
        }
      )

    );
  }
  Widget _Popular() {
    return FutureBuilder(
        future: api.getCategory(context),
        builder: (context,data){
          if(data.hasData){
            List<ModelCategory>list=data.data;
            print(list.length);
            return GridView.count(
              crossAxisCount: 3,
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(list.length, (index) {
                return Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(5),
                    child: InkWell(
                      splashColor: Colors.blue[100],
                      onTap: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryPage(list[index])))
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.amber,
                            child: Image.network(list[index].image,),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            list[index].cat_name,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    )
                );
              }),
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
  Widget _ButtonLogin() {
    return InkWell(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()))
      },
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.blueAccent),
            color: Colors.white),
        child: Text(
          "Sign In",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }
  Widget _ButtonSignUp() {
    return InkWell(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()))
      },
      child: Container(
        width: MediaQuery.of(context).size.width/3,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.blueAccent),
            color: Colors.white),
        child: Text(
          "Register",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }
  Widget _Menus(){
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:[
          InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[100]),
                child: Row(
                  children: [
                    Icon(Icons.card_membership,color: Colors.blue),
                    SizedBox(width: 8,),
                    Text(
                      Languages.of(context).selling,
                      style: TextStyle(fontSize: 14, color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                  ],
                )
            ),
            onTap: ()=>{
              _onItemTapped(6)
            },
          ),
          InkWell(
            child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[100]),
                child: Row(
                  children: [
                    Icon(Icons.flash_on_sharp,color: Colors.blue,),
                    SizedBox(width: 8,),
                    Text(
                      Languages.of(context).deals,
                      style: TextStyle(fontSize: 14, color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                  ],
                )
            ),
            onTap: ()=>{
              _onItemTapped(9)
            },
          ),
          InkWell(
            child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[100]),
                child: Row(
                  children: [
                    Icon(Icons.category,color: Colors.blue,),
                    SizedBox(width: 8,),
                    Text(
                      Languages.of(context).category,
                      style: TextStyle(fontSize: 14, color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                  ],
                )
            ),
            onTap: ()=>{
              _onItemTapped(7)
            },
          ),
          InkWell(
            child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[100]),
                child: Row(
                  children: [
                    Icon(Icons.favorite,color: Colors.blue),
                    SizedBox(width: 8,),
                    Text(
                      Languages.of(context).saved,
                      style: TextStyle(fontSize: 14, color: Colors.blue,fontWeight: FontWeight.bold),
                    ),
                  ],
                )
            ),
            onTap: ()=>{
              _onItemTapped(3)
            },
          ),
        ],
      ),
    );
  }
}