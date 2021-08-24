import 'package:cms_manhattan/src/Models/ModelCategory.dart';
import 'package:cms_manhattan/src/UI/ProductPage.dart';
import 'package:cms_manhattan/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class SubCategoryPage extends StatefulWidget {
  ModelCategory Category;

  @override
  _PageState createState() => _PageState();

  SubCategoryPage(this.Category);
}

class _PageState extends State<SubCategoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> list;
  bool isLoading = false;

  RestDatasource api;

  _PageState() {
    api = new RestDatasource();
  }
  Widget _appBar() {
    return AppBar(
      centerTitle: false,
      title: Text(widget.Category.cat_name,style: TextStyle(
          color: Colors.black
      ),),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child:FadeInImage(
                    placeholder: AssetImage('images/logo.png'),
                    image: NetworkImage(widget.Category.image,),
                    fit: BoxFit.fitWidth,
                    height: 150.0,
                  ),
                ),
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              widget.Category.cat_name,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2,
              textAlign: TextAlign.start,
            ),
          ),
          FutureBuilder(
              future: api.getCategory(context),
              builder: (context, data) {
                if (data.hasData) {
                  List<ModelCategory>list=data.data;
                  return Expanded(child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage.set(list[index])))
                          },
                          child: ListTile(
                            leading: FadeInImage(
                              placeholder: AssetImage('images/logo.png'),
                              image: NetworkImage(list[index].image,),
                              fit: BoxFit.fill,
                              width: 40.0,
                            ),
                            title: Text(list[index].cat_name),
                          ),
                        );
                      }
                  )
                  );
                }
                else {
                  return Center(child: CircularProgressIndicator());
                }
              })
      ],
    )),
    );
  }
}
