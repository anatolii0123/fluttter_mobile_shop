import 'dart:io';
import 'dart:math';

import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/Models/ModelCity.dart';
import 'package:cms_manhattan_project/src/Models/ModelCriteria.dart';
import 'package:cms_manhattan_project/src/UI/AllCMSImages.dart';
import 'package:cms_manhattan_project/src/UI/PostItemManageCriteria.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:cms_manhattan_project/src/Widgets/Badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class PostItemPage extends StatefulWidget {
  final bool isEdit;

  PostItemPage({
    this.isEdit = false,
  });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PostItemPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final _multiSelectKey = GlobalKey<FormFieldState>();
  final _headingController = TextEditingController();
  final _breifInfoController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailInfoController = TextEditingController();
  final _locationController = TextEditingController();
  final _regionInputController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit) {
      mainAssetFile = ['images/image_1.png'];
      smallAssetFile = ['images/image_1.png'];
      _headingController.text = 'Macaroons - Two Bite Choc';
      _breifInfoController.text = 'porttitor id consequat in consequat ut nulla sed accumsan felis ut';
      _priceController.text = '5.03';
      _detailInfoController.text =
          'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.';
      _locationController.text = 'Lorem Ipsum';
      _regionInputController.text = 'Test Region 1';
    }
    super.initState();
  }

  ModelCity? SelectedCity;
  String? _neighborhood, _street;
  bool isLoading = false;
  late RestDatasource api;
  String? userID;
  List<File> mainPicFile = [];
  List<String> mainAssetFile = [];
  List<File> smallPicFile = [];
  List<String> smallAssetFile = [];
  List<String> mainPicUrl = [];
  List<String> smallPicUrl = [];
  String? logoUrl;
  late ImagePicker _picker;
  bool showComments = false;
  bool showRating = true;
  String postType = 'List on Market place';
  List<String> postTypes = [
    'List on Market place',
    'List on local store',
    'Off market',
  ];
  String? selectedRegion;
  List<String> autoCompleteCities = [
    'Test Region 1',
    'Test Region 2',
    'Test Region 3',
    'Test Region 4',
    'Test Region 5',
  ];
  File? logoFile;

  List<ModelCategory> _selectedCategory = [];
  List<ModelCategory> _customSelectedCategory = [];
  List<ModelCategory> _customCategories = [];
  List<ModelCriteria> _criteria = [];
  List<ModelCriteria> _selectedCriteria = [];

  _PageState() {
    api = new RestDatasource();
    getData();
    _picker = ImagePicker();
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

  Widget _Heading() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Heading",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _headingController,
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 10 ? "Heading must have at least 10 chars" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  Widget _BrifInfo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Brief Informations",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: 8,
            controller: _breifInfoController,
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "Brief Informations must have at least 3 chars" : null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _DetailsInfo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Details Informations",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            controller: _detailInfoController,
            minLines: 3,
            maxLines: 8,
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "Details Informations must have at least 3 chars" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  Widget _Price() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _priceController,
            onSaved: (value) => _neighborhood = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "Price must have at least 100" : null;
            },
            decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
          )
        ],
      ),
    );
  }

  Widget _Critaria() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Criteria",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onSaved: (value) => _street = value,
            validator: (val) {
              return (val?.length ?? 0) < 3 ? "Criteria must have at least 3 chars" : null;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
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
                      // if (mainPicFile.length != 0 || mainAssetFile.length != 0)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...mainAssetFile.map(
                              (imgFile) => Badge(
                                child: Icon(Icons.cancel),
                                parent: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      mainAssetFile.remove(imgFile);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Image.asset(
                                      imgFile,
                                      width: width / 4,
                                      height: width / 4,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ...mainPicUrl.map(
                              (imgFile) => Badge(
                                child: Icon(Icons.cancel),
                                parent: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      mainPicUrl.remove(imgFile);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    width: (width / 4) + 4,
                                    height: (width / 4) + 4,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Image.network(
                                      imgFile,
                                      width: width / 4,
                                      height: width / 4,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ...mainPicFile.map(
                              (imgFile) => Badge(
                                child: Icon(Icons.cancel),
                                parent: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      mainPicFile.remove(imgFile);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Image.file(
                                      imgFile,
                                      width: width / 4,
                                      height: width / 4,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          showAdaptiveActionSheet(
                            context: context,
                            title: const Text('Select Image from'),
                            bottomSheetColor: Colors.white,
                            actions: <BottomSheetAction>[
                              BottomSheetAction(
                                title: const Text('Gallery'),
                                onPressed: () async {
                                  final pickedFile = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (pickedFile != null)
                                    setState(() {
                                      mainPicFile.add(File(pickedFile.path));
                                    });
                                  Navigator.of(context).pop();
                                  print('Gallery');
                                },
                              ),
                              BottomSheetAction(
                                title: const Text('Camera'),
                                onPressed: () async {
                                  final pickedFile = await _picker.pickImage(
                                    source: ImageSource.camera,
                                  );
                                  if (pickedFile != null)
                                    setState(() {
                                      mainPicFile.add(File(pickedFile.path));
                                    });
                                  Navigator.of(context).pop();
                                  print('Camera');
                                },
                              ),
                              BottomSheetAction(
                                title: const Text('From CMS'),
                                onPressed: () async {
                                  // Fluttertoast.showToast('Under Development', context);
                                  //mainPicUrl
                                  final image = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => AllCMSImages(true),
                                    ),
                                  );
                                  print('here');
                                  print(image.runtimeType);
                                  if (image is String) {
                                    setState(() {
                                      mainPicUrl.add(image);
                                      print('here1');
                                    });
                                  } else if (image is File) {
                                    setState(() {
                                      mainPicFile.add(image);
                                    });
                                  }
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                            cancelAction: CancelAction(
                              title: const Text('Cancel'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: width,
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Add Big Image",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _Heading(),
                      SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        title: Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _BrifInfo(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _Price(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _DetailsInfo(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...smallAssetFile.map(
                              (imgFile) => Badge(
                                child: Icon(Icons.cancel),
                                parent: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      smallAssetFile.remove(imgFile);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Image.asset(
                                      imgFile,
                                      width: width / 4,
                                      height: width / 4,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ...smallPicFile.map(
                              (imgFile) => Badge(
                                child: Icon(Icons.cancel),
                                parent: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      smallPicFile.remove(imgFile);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Image.file(
                                      imgFile,
                                      width: width / 4,
                                      height: width / 4,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ...smallPicUrl.map(
                              (imgFile) => Badge(
                                child: Icon(Icons.cancel),
                                parent: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      smallPicUrl.remove(imgFile);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Image.network(
                                      imgFile,
                                      width: width / 4,
                                      height: width / 4,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          showAdaptiveActionSheet(
                            context: context,
                            title: const Text('Select Image from'),
                            bottomSheetColor: Colors.white,
                            actions: <BottomSheetAction>[
                              BottomSheetAction(
                                title: const Text('Gallery'),
                                onPressed: () async {
                                  final pickedFile = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (pickedFile != null)
                                    setState(() {
                                      smallPicFile.add(File(pickedFile.path));
                                    });
                                  Navigator.of(context).pop();
                                  print('Gallery');
                                },
                              ),
                              BottomSheetAction(
                                title: const Text('Camera'),
                                onPressed: () async {
                                  final pickedFile = await _picker.pickImage(
                                    source: ImageSource.camera,
                                  );
                                  if (pickedFile != null)
                                    setState(() {
                                      smallPicFile.add(File(pickedFile.path));
                                    });
                                  Navigator.of(context).pop();
                                  print('Camera');
                                },
                              ),
                              BottomSheetAction(
                                title: const Text('From CMS'),
                                onPressed: () async {
                                  // Fluttertoast.showToast('Under Development', context);
                                  //smallPicUrl
                                  final image = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => AllCMSImages(true),
                                    ),
                                  );
                                  print('here');
                                  print(image.runtimeType);
                                  setState(() {
                                    if (image is String) {
                                      smallPicUrl.add(image);
                                    } else if (image is File) {
                                      smallPicFile.add(image);
                                    }
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                            cancelAction: CancelAction(
                              title: const Text('Cancel'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: width,
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Add Small Image",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        backgroundColor: Colors.grey[100],
                        title: Text(
                          'Seller logo',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        children: [
                          InkWell(
                            onTap: () {
                              showAdaptiveActionSheet(
                                context: context,
                                title: const Text('Select Image from'),
                                bottomSheetColor: Colors.white,
                                actions: <BottomSheetAction>[
                                  BottomSheetAction(
                                    title: const Text('Gallery'),
                                    onPressed: () async {
                                      final pickedFile = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (pickedFile != null)
                                        setState(() {
                                          logoFile = File(pickedFile.path);
                                        });
                                      Navigator.of(context).pop();
                                      print('Gallery');
                                    },
                                  ),
                                  BottomSheetAction(
                                    title: const Text('Camera'),
                                    onPressed: () async {
                                      final pickedFile = await _picker.pickImage(
                                        source: ImageSource.camera,
                                      );
                                      if (pickedFile != null)
                                        setState(() {
                                          logoFile = File(pickedFile.path);
                                        });
                                      Navigator.of(context).pop();
                                      print('Camera');
                                    },
                                  ),
                                  BottomSheetAction(
                                    title: const Text('From CMS'),
                                    onPressed: () async {
                                      // Fluttertoast.showToast('Under Development', context);
                                      //logoUrl
                                      final image = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => AllCMSImages(true),
                                        ),
                                      );
                                      print('here');
                                      print(image.runtimeType);
                                      setState(() {
                                        if (image is String) {
                                          logoUrl = image;
                                        } else if (image is File) {
                                          logoFile = image;
                                        }
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                                cancelAction: CancelAction(
                                  title: const Text('Cancel'),
                                ),
                              );
                            },
                            child: (logoFile == null && logoUrl == null)
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey[300],
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: 100,
                                    height: 80,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(Icons.add),
                                        Text(
                                          "Add Logo",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Badge(
                                    child: Icon(Icons.change_circle),
                                    parent: Container(
                                      decoration: BoxDecoration(),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      child: ClipOval(
                                        child: Image(
                                          image: (logoUrl != null ? NetworkImage(logoUrl!) : FileImage(logoFile!)) as ImageProvider,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _ManageCategory(),
                      SizedBox(
                        height: 10,
                      ),
                      _ManageCriteria(),
                      SizedBox(
                        height: 10,
                      ),
                      _ShowComment(),
                      SizedBox(
                        height: 10,
                      ),
                      _ItemDetails(),
                      SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        backgroundColor: Colors.grey[100],
                        title: Text(
                          'Add Region',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TypeAheadFormField(
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: _regionInputController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Region',
                                  border: InputBorder.none,
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                              ),
                              suggestionsCallback: (pattern) {
                                return [...autoCompleteCities]..removeWhere(
                                    (e) => !e.toLowerCase().contains(
                                          pattern.toLowerCase(),
                                        ),
                                  );
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                  tileColor: Colors.white,
                                );
                              },
                              transitionBuilder: (context, suggestionsBox, controller) {
                                return suggestionsBox;
                              },
                              onSuggestionSelected: (String suggestion) {
                                _regionInputController.text = suggestion;
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please select a region';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                              hideOnEmpty: true,
                            ), /* TextFormField(
                              onSaved: (value) => _neighborhood = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ), */
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        backgroundColor: Colors.grey[100],
                        title: Text(
                          'Post Type',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              items: postTypes
                                  .map(
                                    (String value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  postType = newValue!;
                                });
                              },
                              value: postType,
                              elevation: 16,
                              dropdownColor: Colors.white,
                              isExpanded: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _Offers(),
                      SizedBox(
                        height: 10,
                      ),
                      _submitButton(),
                    ],
                  ),
                )),
          )),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        widget.isEdit ? 'Edit Product' : 'Post Product',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _ManageCriteria() {
    return ListTile(
      focusColor: Colors.grey[100],
      title: Text(
        'Manage Criteria',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.start,
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () async {
        // print(st.data);

        Map<String, dynamic> criterias = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostItemManageCriteria(
              _criteria,
              _selectedCriteria,
            ),
          ),
        );
        if (criterias != null) {
          // print(criterias['allCategories'][10].name);
          setState(
            () {
              _criteria = criterias['allCriteria'];
              _selectedCriteria = criterias['selectedCriteria'];
            },
          );
        }
      },
    );
  }

  Widget _ManageCategory() {
    return ExpansionTile(
      backgroundColor: Colors.grey[100],
      title: Text(
        'Manage Category',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.start,
      ),
      children: [
        FutureBuilder(
          future: api.getCategoryForAddProduct(context),
          builder: (context, data) {
            List<MultiSelectItem<ModelCategory>> category = data.data as List<MultiSelectItem<ModelCategory>>? ?? [];
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MultiSelectBottomSheetField<ModelCategory>(
                        key: _multiSelectKey,
                        backgroundColor: Colors.white,
                        initialChildSize: 0.7,
                        maxChildSize: 0.95,
                        initialValue: _selectedCategory,
                        title: Text("Category"),
                        buttonText: Text("Category"),
                        items: category,
                        searchable: true,
                        validator: (values) {
                          var nValues = [...values ?? [], ..._customSelectedCategory];
                          if (nValues == null || nValues.isEmpty) {
                            return "Required";
                          }
                          if (nValues.length > 5) {
                            return 'You could select atmost 5 Category';
                          }
                          return null;
                        },
                        onConfirm: (values) {
                          setState(() {
                            _selectedCategory = values;
                            print("SelectedSide${_selectedCategory.length}");
                          });
                          _multiSelectKey.currentState!.validate();
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (item) {
                            setState(() {
                              _selectedCategory.remove(item);
                            });
                            _multiSelectKey.currentState!.validate();
                          },
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (_) => AlertDialog(
                    //         title: Text('Enter the name of Category.'),
                    //         content: TextField(
                    //           decoration: InputDecoration(
                    //             hintText: 'Category Name.',
                    //           ),
                    //           controller: _categoryInputController,
                    //         ),
                    //         actions: [
                    //           TextButton(
                    //             child: Text('Cancel'),
                    //             onPressed: () => Navigator.of(context).pop(),
                    //           ),
                    //           TextButton(
                    //             child: Text('Add'),
                    //             onPressed: () {
                    //               setState(() {
                    //                 _customSelectedCategory.add(
                    //                   ModelCategory(
                    //                     Random().nextInt(100).toString(),
                    //                     _categoryInputController.text,
                    //                     'https://robohash.org/sitdeseruntet.png?size=50x50&amp;set=set1',
                    //                   ),
                    //                 );
                    //                 _categoryInputController.text = '';
                    //               });
                    //               _multiSelectKey.currentState.validate();
                    //               Navigator.of(context).pop();
                    //             },
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   icon: Icon(Icons.add),
                    // ),
                  ],
                ),
                MultiSelectChipDisplay(
                  icon: Icon(Icons.close),
                  items: ([..._selectedCategory, ..._customSelectedCategory]).map((e) => MultiSelectItem(e, e.name)).toList(),
                  onTap: (item) {
                    setState(() {
                      if (!_selectedCategory.remove(item)) _customSelectedCategory.remove(item);
                    });
                    _multiSelectKey.currentState!.validate();
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _ShowComment() {
    return ExpansionTile(
      backgroundColor: Colors.grey[100],
      title: Text(
        'Show Comment and Rating',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.start,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Comments:  '),
                  Switch(
                    value: showComments,
                    onChanged: (b) => setState(
                      () {
                        showComments = b;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ratings:  '),
                  Switch(
                    value: showRating,
                    onChanged: (b) => setState(
                      () {
                        showRating = b;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ItemDetails() {
    return ExpansionTile(
      backgroundColor: Colors.grey[100],
      title: Text(
        'Add Location',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.start,
      ),
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _locationController,
              onSaved: (value) => _neighborhood = value,
              validator: (val) {
                return (val?.length ?? 0) < 3 ? "Location must have at least 3 chars" : null;
              },
              decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.grey[200], filled: true),
            )),
      ],
    );
  }

  Widget _Offers() {
    return ExpansionTile(
      backgroundColor: Colors.grey[100],
      title: Text(
        'Allow Offer From',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.start,
      ),
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onSaved: (value) => _neighborhood = value,
              validator: (val) {
                return (val?.length ?? 0) < 3 ? "Comment must have at least 3 chars" : null;
              },
              decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.grey[200], filled: true),
            )),
      ],
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () => {Navigator.pop(context)},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
            color: Colors.blue),
        child: Text(
          widget.isEdit ? 'Update' : 'Post Product',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
