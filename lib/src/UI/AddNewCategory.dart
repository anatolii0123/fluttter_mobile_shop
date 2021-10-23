import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewCategory extends StatefulWidget {
  @override
  _AddNewCategoryState createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  String catName = '';
  File? catImage;
  final _picker = ImagePicker();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Select Categories',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          catImage != null
              ? Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Image.file(
                    catImage!,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                )
              : GestureDetector(
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
                                imageFile = File(pickedFile.path);
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
                                imageFile = File(pickedFile.path);
                              });
                            Navigator.of(context).pop();
                            print('Camera');
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
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                          "Add Image for Category.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          TextButton(
            child: Text('Add'),
            onPressed: () => Navigator.of(context).pop(
              ModelCategory(
                catName,
                catName,
                catImage != null ? catImage!.path : '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
