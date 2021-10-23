import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cms_manhattan_project/src/Widgets/Badge.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AllCMSImages extends StatefulWidget {
  final bool isPicker;

  AllCMSImages([this.isPicker = false]);
  @override
  _AllCMSImagesState createState() => _AllCMSImagesState();
}

class _AllCMSImagesState extends State<AllCMSImages> {
  List<ImageProvider> mainPicImage = [
    NetworkImage('https://picsum.photos/400'),
    NetworkImage('https://picsum.photos/401'),
    NetworkImage('https://picsum.photos/402'),
    NetworkImage('https://picsum.photos/403'),
    NetworkImage('https://picsum.photos/404'),
  ];
  List imageReturn = [
    'https://picsum.photos/400',
    'https://picsum.photos/401',
    'https://picsum.photos/402',
    'https://picsum.photos/403',
    'https://picsum.photos/404',
  ];

  ImagePicker _picker = ImagePicker();

  PreferredSizeWidget _appBar(context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        'CMS Images',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {
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
                          imageReturn.add(File(pickedFile.path));
                          mainPicImage.add(FileImage(File(pickedFile.path)));
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
                          imageReturn.add(File(pickedFile.path));
                          mainPicImage.add(FileImage(File(pickedFile.path)));
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
            icon: Icon(Icons.add))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
          children: [
            ...List<Widget>.generate(
              mainPicImage.length,
              (index) => Badge(
                child: widget.isPicker ? Container() : Icon(Icons.cancel),
                parent: GestureDetector(
                  onTap: () {
                    if (widget.isPicker)
                      Navigator.of(context).pop(imageReturn[index]);
                    else
                      setState(() {
                        mainPicImage.removeAt(index);
                        imageReturn.removeAt(index);
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
                    child: Image(
                      image: mainPicImage[index],
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
    );
  }
}
