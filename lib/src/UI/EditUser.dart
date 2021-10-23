import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final Map<String, dynamic> e;

  EditUser(this.e);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  PreferredSizeWidget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text(
        'Edit User',
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _submitButton(dis) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pop();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
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
        child: Text(
          'Update',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueGrey[200]),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: widget.e['name'],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueGrey[200]),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: widget.e['email'],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueGrey[200]),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: widget.e['address'],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'State',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueGrey[200]),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: widget.e['state'],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Country',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blueGrey[200]),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: widget.e['country'],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
