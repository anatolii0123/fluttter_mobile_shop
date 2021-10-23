import 'dart:io';

import 'package:cms_manhattan_project/src/Models/ModelCriteria.dart';
import 'package:cms_manhattan_project/src/UI/PostItemAddCriteria.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class PostItemManageCriteria extends StatefulWidget {
  final List<ModelCriteria> allCriteria;
  final List<ModelCriteria> selectedCriteria;

  PostItemManageCriteria(this.allCriteria, this.selectedCriteria);

  @override
  _PostItemManageCriteriaState createState() => _PostItemManageCriteriaState();
}

class _PostItemManageCriteriaState extends State<PostItemManageCriteria> {
  List<ModelCriteria> _allCri = [];
  List<GlobalKey<FormFieldState>> _multiSelectKey = [];
  List<ModelCriteria> _selectedCri = [];

  @override
  void initState() {
    _allCri = widget.allCriteria;
    _selectedCri = widget.selectedCriteria;
    _multiSelectKey = List.generate(
      widget.allCriteria.length,
      (index) => GlobalKey<FormFieldState>(),
    );
    // print(_allCri);
    // print(_selectedCri);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Manage Criteria',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(
              {
                'selectedCriteria': _selectedCri,
                'allCriteria': _allCri,
              },
            ),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: _allCri.length <= 10,
        child: FloatingActionButton(
          onPressed: () async {
            var newCri = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostItemAddCriteria(),
              ),
            );
            print(newCri);
            if (newCri != null && newCri.length > 0) {
              setState(() {
                _allCri.add(ModelCriteria(data: newCri, id: _allCri.length));
                _selectedCri.add(
                  ModelCriteria(
                    id: _selectedCri.length,
                    data: [],
                  ),
                );
                _multiSelectKey.add(new GlobalKey<FormFieldState>());
              });
            }
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _allCri.length + 1,
                itemBuilder: (ctx, index) {
                  print('a $index');
                  if (index == _allCri.length) {
                    if (index == 0) {
                      return Container(
                        child: Center(
                          child: Text(
                            'Nothing to display.\nPlease add Criteria List.',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListTile();
                  }
                  print('b $index');
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Expanded(
                          child: MultiSelectBottomSheetField<String>(
                            key: _multiSelectKey[index],
                            backgroundColor: Colors.white,
                            initialChildSize: 0.7,
                            maxChildSize: 0.95,
                            initialValue: _selectedCri[index].data,
                            title: Text("Select"),
                            buttonText: Text(
                              _selectedCri[index].data.length > 0 ? _selectedCri[index].data.join(', ') : 'Select',
                            ),
                            items: _allCri[index]
                                .data
                                .map(
                                  (elem) => MultiSelectItem(elem, elem),
                                )
                                .toList(),
                            searchable: true,
                            validator: (values) {
                              if (values == null || values.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            onConfirm: (values) {
                              setState(() {
                                _selectedCri[index].data = values;
                                print("SelectedSide${_selectedCri[index].data.length}");
                              });
                              _multiSelectKey[index].currentState!.validate();
                            },
                            chipDisplay: MultiSelectChipDisplay.none(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _allCri.removeAt(index);
                              _selectedCri.removeAt(index);
                              _multiSelectKey.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                    // child: InkWell(
                    //   splashColor: Colors.blue[100],
                    //   onTap: () {
                    //     setState(() {
                    //       if (isSelected) {
                    //         _selectedCri.removeWhere(
                    //           (element) => _allCri[index].id == element.id,
                    //         );
                    //       } else {
                    //         _selectedCri.add(_allCri[index]);
                    //       }
                    //     });
                    //   },
                    //   child: ListTile(
                    //     title: Text(
                    //       _allCri[index].id.toString(),
                    //       style: Theme.of(context).textTheme.bodyText2,
                    //     ),
                    //     trailing: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Checkbox(
                    //           onChanged: (a) {
                    //             setState(() {
                    //               if (isSelected) {
                    //                 _selectedCri.removeWhere(
                    //                   (element) =>
                    //                       _allCri[index].id == element.id,
                    //                 );
                    //               } else {
                    //                 _selectedCri.add(_allCri[index]);
                    //               }
                    //             });
                    //           },
                    //           value: isSelected,
                    //         ),
                    //         if (index >= _allCri.length)
                    //           IconButton(
                    //             onPressed: () {
                    //               print('here');
                    //               setState(() {
                    //                 _allCri.removeWhere(
                    //                   (element) =>
                    //                       element.id == _allCri[index].id,
                    //                 );
                    //               });
                    //             },
                    //             icon: Icon(
                    //               Icons.delete,
                    //             ),
                    //           )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
