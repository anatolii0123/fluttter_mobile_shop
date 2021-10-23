import 'dart:math';

import 'package:cms_manhattan_project/src/UI/EditUser.dart';
import 'package:cms_manhattan_project/src/UI/UserDetails.dart';
import 'package:cms_manhattan_project/src/languages/Languages.dart';
import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  static const String routeName = '/store-details';

  @override
  _UsersListState createState() => _UsersListState();
}

final names = [
  'Leah Vaughan',
  'Penelope Nash',
  'Warren Fraser',
  'Dominic Tucker',
  'Rebecca Hughes',
  'Connor Russell',
  'Stephanie Scott',
  'Rose Langdon',
  'Alison Thomson',
  'Claire Fraser',
];

final random = Random();

class _UsersListState extends State<UsersList> {
  bool editing = false;
  final users = List<Map<String, dynamic>>.generate(
    10,
    (index) {
      int r = random.nextInt(10);
      return {
        'id': index,
        'name': names[r],
        'email': names[r].toLowerCase().replaceAll(' ', '') + '@gmail.com',
        'address': '123, East Street, A City',
        'state': 'B State',
        'country': 'Country',
        'imageUrl': 'https://picsum.photos/${1000 + index}',
        'mob': '1234567890',
        'emailVerified': random.nextBool(),
        'mobVerified': random.nextBool(),
      };
    },
  );

  PreferredSizeWidget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text(
        'Users List',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              editing = !editing;
            });
          },
          icon: editing ? Icon(Icons.check) : Icon(Icons.edit),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: users.isEmpty
          ? const Center(
              child: Text('No Users Exists'),
            )
          : SingleChildScrollView(
              // physics: BouncingScrollPhysics(
              //   parent: AlwaysScrollableScrollPhysics(),
              // ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: users
                      .map(
                        (e) => ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 2,
                          ).copyWith(right: editing ? 10 : null),
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage('images/user.png'),
                                foregroundImage: NetworkImage(e['imageUrl']),
                              ),
                            ],
                          ),
                          title: Text(e['name']),
                          subtitle: Text(e['email']),
                          onTap: editing
                              ? null
                              : () async {
                                  bool delete = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => UserDetails(e),
                                    ),
                                  );
                                  if (delete != null) {
                                    setState(() {
                                      users.removeWhere(
                                        (element) => element['id'] == e['id'],
                                      );
                                    });
                                  }
                                },
                          trailing: editing
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => EditUser(e),
                                          ),
                                        );
                                      },
                                      padding: EdgeInsets.zero,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text('Alert'),
                                            content: Text(
                                              'Are you sure, you want to completely remove this user.',
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    users.removeWhere(
                                                      (element) => element['id'] == e['id'],
                                                    );
                                                  });
                                                },
                                                child: Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}
