import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/UI/SubCategoryPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCategoryPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MainCategoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isLoading = false;
  late RestDatasource api;
  _PageState() {
    api = new RestDatasource();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          key: _scaffoldKey,
          body: FutureBuilder(
              future: api.getCategory(context),
              builder: (context, data) {
                if (data.hasData) {
                  List<ModelCategory> list = data.data as List<ModelCategory>? ?? [];
                  return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(list.length, (index) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        color: Colors.white,
                        margin: EdgeInsets.all(5),
                        child: InkWell(
                          splashColor: Colors.blue[100],
                          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryPage(list[index])))},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.amber,
                                child: Image.network(
                                  list[index].image,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                list[index].cat_name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
