import 'package:cms_manhattan_project/src/Models/ModelCategory.dart';
import 'package:cms_manhattan_project/src/Models/ModelCharge.dart';
import 'package:cms_manhattan_project/src/UI/AddressPage.dart';
import 'package:cms_manhattan_project/src/UI/ProductDetailsPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PaymentPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late RestDatasource api;
  int _radioValue1 = -1;
  _PageState() {
    api = new RestDatasource();
  }

  PreferredSizeWidget _appBar(dis) {
    return AppBar(
      centerTitle: false,
      title: Text('Pay with', style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(context),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Your credit card and debit card",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () => {_AddPaymentCard()},
                            child: Row(
                              children: [
                                Icon(Icons.payment, color: Colors.white),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Add Card",
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                      Text("Other payment option", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.payment),
                          SizedBox(
                            width: 5,
                          ),
                          Text("PayPal"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.payment),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Google Pay"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.payment),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Paytm"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 4,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.payment),
                          SizedBox(
                            width: 5,
                          ),
                          Text("PhonePay"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                  future: api.getTotal(context),
                  builder: (context, data) {
                    if (data.hasData) {
                      ModelCharge charge = data.data as ModelCharge;
                      return BottomAppBar(
                        notchMargin: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.grey,
                                height: 2,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Items (${charge.item_count})',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '\$ ${charge.total}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Shipping',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '\$ ${charge.shipping}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Discount',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '\$ ${charge.discount}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Sub Total',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.black, fontSize: 18),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        '\$ ${charge.sub_total}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                                      )),
                                ],
                              ),
                              _submitButton(),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          )),
    );
  }

  void _handleRadioValueChange1(int? value) {
    setState(() {
      _radioValue1 = value ?? _radioValue1;
    });
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddressPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 4), blurRadius: 5, spreadRadius: 2)],
              color: Colors.blue),
          child: Text(
            'Continue',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Future _AddPaymentCard() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 500,
          color: Colors.transparent,
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))),
              child: SingleChildScrollView(
                  child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(5)),
                    SizedBox(
                      width: 100,
                      height: 10,
                      child: Divider(
                        color: Colors.grey,
                        height: 10,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      'Add new card',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Column(
                      children: [
                        // CreditCardForm(
                        //   formKey: formKey,
                        //   obscureCvv: true,
                        //   obscureNumber: true,
                        //   cardNumberDecoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: 'Number',
                        //     hintText: 'XXXX XXXX XXXX XXXX',
                        //   ),
                        //   expiryDateDecoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: 'Expired Date',
                        //     hintText: 'XX/XX',
                        //   ),
                        //   cvvCodeDecoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: 'CVV',
                        //     hintText: 'XXX',
                        //   ),
                        //   cardHolderDecoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: 'Card Holder',
                        //   ),
                        //   onCreditCardModelChange: onCreditCardModelChange,
                        // ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: const Text(
                              'ADD CARD',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          color: const Color(0xff1b447b),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print('valid!');
                            } else {
                              print('invalid!');
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ))),
        );
      },
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      /* cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;*/
    });
  }
}
