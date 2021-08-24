
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OrderTrackingPage extends StatefulWidget{

  @override
  _PageState createState() => _PageState();
}
class _PageState extends State<OrderTrackingPage>{
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
      appBar: _appBar(),
      body:Column(
        children: [
          Expanded(
            child: Stepper(
              steps: [
                Step(
                  title: const Text('Order Signed'),
                  isActive: true,
                  state:StepState.complete,
                  content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('18-03-2021 02:00 PM',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Text('order current address display here',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Order Processed'),
                  isActive: false,
                  state:StepState.indexed,
                  content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('18-03-2021 02:00 PM',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Text('order current address display here',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Shipped'),
                  isActive: false,
                  state:StepState.indexed,
                  content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('18-03-2021 02:00 PM',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Text('order current address display here',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Out for delivery'),
                  isActive: false,
                  state:StepState.indexed,
                  content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('18-03-2021 02:00 PM',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Text('order current address display here',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                    ],
                  ),
                ),
                Step(
                  title: const Text('delivered'),
                  isActive: false,
                  state:StepState.indexed,
                  content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('19-03-2021 02:00 PM',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                      Text('order current address display here',style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),),
                    ],
                  ),
                ),
              ],
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel})=>Container(),
              onStepTapped: (step) => goTo(step),
              currentStep: currentStep,
              /*  onStepContinue: next,
           onStepCancel: cancel,*/
            ),
          ),
        ],
      )
    ),
    );
  }
  goTo(int step) {
    setState(() => currentStep = step);
  }
  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Order Tracking',style: TextStyle(
        color: Colors.black
      ),),

      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.white,
    );
  }
  Widget _submitButton() {
    return InkWell(
      onTap: () => {

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Colors.blueGrey),
        child: Text(
          'CONTINUE SHOPPING',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
