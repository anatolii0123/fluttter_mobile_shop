import 'package:cms_manhattan_project/src/Models/ModelProduct.dart';
import 'package:cms_manhattan_project/src/Models/ModelSearch.dart';
import 'package:cms_manhattan_project/src/Session/SessionManager.dart';
import 'package:cms_manhattan_project/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan_project/src/UI/ProductPage.dart';
import 'package:cms_manhattan_project/src/UI/SearchProductPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SearchPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ModelSearch> SavedSearchList = [];
  List<ModelSearch> RecentSearchList = [];
  Widget appBarTitle = new Text("Search");
  Icon actionIcon = new Icon(Icons.search);
  late RestDatasource api;
  bool isSearchEnable = false;
  String? SeaarchText;
  late SessionManager session;

  _PageState() {
    api = new RestDatasource();
    session = new SessionManager();
  }

  Future AddToRecent(String value) async {
    List<ModelSearch> oldList = [];
    if (await session.readRecentSize() != null) oldList.addAll(await session.getFromRecent());
    oldList.add(new ModelSearch(value));
    await session.AddToRecent(ModelSearch.encode(oldList));
    oldList.clear();
    isSearchEnable = false;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductPage.set(
          searchString: SeaarchText ?? '',
          productPageType: ProductPageType.Search,
        ),
      ),
    );
  }

  Future RemoveSearchSaved(value) async {
    SavedSearchList.remove(value);
    if (SavedSearchList.isNotEmpty) {
      await session.AddToSearchSaved(ModelSearch.encode(SavedSearchList));
    } else {
      await session.remove("search_saved");
    }
    setState(() {});
  }

  Future RemoveSearchRecent(value) async {
    RecentSearchList.remove(value);
    if (RecentSearchList.isNotEmpty) {
      await session.AddToRecent(ModelSearch.encode(RecentSearchList));
    } else {
      await session.remove("recent");
    }
    setState(() {});
  }

  PreferredSizeWidget _appBar() {
    return TabBar(
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.blueGrey[200],
      tabs: [
        Tab(
          child: Text(
            "RECENT",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            "SAVED",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _SearchappBar() {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: EdgeInsets.all(5.0),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey[100]),
              margin: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black, backgroundColor: Colors.grey[100]),
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (text) {
                          setState(() {
                            SeaarchText = text;
                          });
                        },
                        onSubmitted: (string) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductPage.set(
                                productPageType: ProductPageType.Search,
                                searchString: string,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                      widthFactor: 1,
                      alignment: AlignmentDirectional.centerEnd,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              isSearchEnable = false;
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey,
                          )))
                ],
              ),
            ),
            onTap: () => {
              setState(() {
                isSearchEnable = true;
              })
            },
          ),
        ]);
  }

  PreferredSizeWidget _SearchappBarTab() {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        backgroundColor: Colors.white,
        bottom: _appBar(),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              padding: EdgeInsets.all(5.0),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey[100]),
              margin: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Text(
                          "Search for a...",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      )),
                  Align(
                    widthFactor: 1,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                      children: [
                        Icon(
                          Icons.mic_outlined,
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey[400],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () => {
              setState(() {
                isSearchEnable = true;
              })
            },
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      // Added
      length: 2, // Added
      initialIndex: 0, //Added
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: isSearchEnable ? _SearchappBar() : _SearchappBarTab(),
        body: isSearchEnable
            ? _SearchResult()
            : TabBarView(
                children: [
                  _Resent(),
                  _Saved(),
                ],
              ),
      ),
    );
  }

  Widget _Resent() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        FutureBuilder(
            future: session.getFromRecent(),
            builder: (context, data) {
              if (data.hasData) {
                RecentSearchList = data.data as List<ModelSearch>? ?? [];
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: RecentSearchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(RecentSearchList[index].key),
                        tileColor: Colors.white,
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            RemoveSearchRecent(RecentSearchList[index]);
                          },
                        ),
                        onTap: () {
                          isSearchEnable = false;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductPage.set(
                                productPageType: ProductPageType.Search,
                                searchString: RecentSearchList[index].key,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text('No Recent search found'));
              }
            }),
      ]),
    );
  }

  Widget _Saved() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        FutureBuilder(
            future: session.getFromSearchSaved(),
            builder: (context, data) {
              if (data.hasData) {
                SavedSearchList = data.data as List<ModelSearch>? ?? [];
                return Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: SavedSearchList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(SavedSearchList[index].key),
                          tileColor: Colors.white,
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              RemoveSearchSaved(SavedSearchList[index]);
                            },
                          ),
                          onTap: () {
                            isSearchEnable = false;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductPage.set(
                                  productPageType: ProductPageType.Search,
                                  searchString: SavedSearchList[index].key,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                );
              } else {
                return Center(child: Text('No saved search found'));
              }
            }),
      ]),
    );
  }

  Widget _SearchResult() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        FutureBuilder(
            future: api.searchProduct(context, SeaarchText ?? ''),
            builder: (context, data) {
              if (data.hasData) {
                List<ModelProduct> suggestion = data.data as List<ModelProduct>? ?? [];
                if (suggestion.isEmpty) {
                  return Center(
                      child: Column(
                    children: [Image.asset('images/card_icon.png'), Text('No Result found!')],
                  ));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: suggestion.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(suggestion[index].name),
                        subtitle: Text(
                          suggestion[index].short_des,
                          maxLines: 2,
                        ),
                        tileColor: Colors.white,
                        trailing: Icon(Icons.open_in_new),
                        onTap: () {
                          AddToRecent(SeaarchText ?? '');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (ctx) => ProductPage.set(
                          //       productPageType: ProductPageType.Search,
                          //       searchString: suggestion[index].name,
                          //     ),
                          //   ),
                          // );
                        },
                      );
                    },
                  ),
                );
              } else if (data.hasError) {
                return Center(
                    child: Column(
                  children: [Image.asset('images/card_icon.png'), Text('No Result found!')],
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ]),
    );
  }
}
