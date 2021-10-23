import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/Widgets/Badge.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostItemAddCriteria extends StatefulWidget {
  @override
  _PostItemAddCriteriaState createState() => _PostItemAddCriteriaState();
}

class _PostItemAddCriteriaState extends State<PostItemAddCriteria> {
  final _picker = new ImagePicker();
  final _formKey = GlobalKey<FormState>();
  List<int> criIndex = [0];
  List<String> criNames = [''];
  List<int> criKeys = [0];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Criteria',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                // if (catPicFile != null)
                //   Badge(
                //     child: Icon(Icons.cancel),
                //     parent: GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           catPicFile = null;
                //         });
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //           color: Colors.grey[200],
                //           border: Border.all(
                //             width: 2,
                //             color: Colors.grey[200],
                //           ),
                //         ),
                //         margin: const EdgeInsets.symmetric(
                //           horizontal: 10,
                //           vertical: 10,
                //         ),
                //         child: Image.file(
                //           catPicFile,
                //           width: width / 3,
                //           height: width / 3,
                //           fit: BoxFit.scaleDown,
                //         ),
                //       ),
                //     ),
                //   )
                // else
                //   GestureDetector(
                //     onTap: () async {
                //       showAdaptiveActionSheet(
                //         context: context,
                //         title: const Text('Select Image from'),
                //         bottomSheetColor: Colors.white,
                //         actions: <BottomSheetAction>[
                //           BottomSheetAction(
                //             title: const Text('Gallery'),
                //             onPressed: () async {
                //               final pickedFile = await _picker.getImage(
                //                 source: ImageSource.gallery,
                //               );
                //               setState(() {
                //                 catPicFile = File(pickedFile.path);
                //               });
                //               Navigator.of(context).pop();
                //               print('Gallery');
                //             },
                //           ),
                //           BottomSheetAction(
                //             title: const Text('Camera'),
                //             onPressed: () async {
                //               final pickedFile = await _picker.getImage(
                //                 source: ImageSource.camera,
                //               );
                //               setState(() {
                //                 catPicFile = File(pickedFile.path);
                //               });
                //               Navigator.of(context).pop();
                //               print('Camera');
                //             },
                //           ),
                //         ],
                //         cancelAction: CancelAction(
                //           title: const Text('Cancel'),
                //         ),
                //       );
                //     },
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         color: Colors.grey[200],
                //       ),
                //       margin: EdgeInsets.symmetric(vertical: 10),
                //       width: width,
                //       height: 60,
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: <Widget>[
                //           Icon(Icons.add),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           Text(
                //             "Add Category Image",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold, fontSize: 15),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // if (_error != null)
                //   Text(
                //     _error,
                //     style: TextStyle(
                //       color: Colors.red,
                //     ),
                //   ),
                // const SizedBox(
                //   height: 25,
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Criteria Items",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                criIndex.add(criIndex.length);
                                criNames.add('');
                                criKeys.add(criKeys.last + 1);
                              });
                            },
                            child: Text(
                              'Add Criteria Item',
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: criIndex
                            .map(
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        key: Key('${criKeys[index]}'),
                                        onSaved: (value) => criNames[index] = value!,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                    if (criIndex.length > 1)
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            print(index);
                                            criNames.removeAt(index);
                                            criIndex = List.generate(
                                              criIndex.length - 1,
                                              (index) => index,
                                            );
                                            criKeys.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    if (!criNames.any((element) => element != '')) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Alert'),
                          content: Text('Criteria List should not be empty.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    criNames.removeWhere(
                      (element) => element == null || element == '',
                    );
                    Navigator.of(context).pop(criNames);
                  },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2,
                        )
                      ],
                      color: Colors.blue,
                    ),
                    child: const Text(
                      'Add Criteria List',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
