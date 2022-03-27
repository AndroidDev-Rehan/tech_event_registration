import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_event_registration/controllers/addevent.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:uuid/uuid.dart';

import '../../../controllers/event.dart';
import '../../../models/events.dart';
import '../../widgets/datepicker.dart';
import '../../widgets/timepicker.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({Key? key}) : super(key: key);

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  EventController _controller = Get.put(EventController());
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController _bidcontroller = TextEditingController();
  int? selectedindex;
  bool bidding = false;
  int bidvalue=0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_PRIMARY,
          title: const Text(
            'Select Stall',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Events').doc(_controller.selectedevent.uid).snapshots(),
          builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(snapshot.hasData)
            {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [

                          ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  int.parse(_controller.selectedevent.stall),
                              itemBuilder: (context, index) {
                                if (index % 2 == 0 &&
                                    index + 1 ==
                                        int.parse(
                                            _controller.selectedevent.stall)) {
                                  print('index' + index.toString());
                                  return Row(
                                    children: [_stallwidget(index,snapshot.data!.data() as Map<String,dynamic>)],
                                  );
                                } else if (index % 2 == 0) {
                                  print('index' + index.toString());
                                  return Row(
                                    children: [
                                      _stallwidget(index,snapshot.data!.data() as Map<String,dynamic>),
                                      Spacer(),
                                      _stallwidget(index + 1,snapshot.data!.data() as Map<String,dynamic>)
                                    ],
                                  );
                                }

                                return SizedBox();
                              }),
                          Text(
                            _controller.selectedevent.venue,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.COLOR_PRIMARY),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          bidding
                              ? SizedBox(
                                  width: Get.width,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Form(
                                            key: _signUpFormKey,
                                            child: customTextField(
                                                'Enter bidding amount',
                                                _bidcontroller, (value) {
                                                  print(bidvalue);
                                                  print(_bidcontroller.text);
                                              if (int.parse(
                                                      _bidcontroller.text) <
                                                  bidvalue) {
                                                return 'Bid higher than previous bid';
                                              }
                                              return null;
                                            })),
                                        GestureDetector(
                                            onTap: () {
                                              if (_signUpFormKey.currentState!
                                                  .validate()) {
                                                FirebaseFirestore.instance
                                                    .collection('Events')
                                                    .doc(_controller
                                                        .selectedevent.uid)
                                                    .set({
                                                  'bid':
                                                    {
                                                      selectedindex.toString():
                                                          {
                                                        'value':
                                                            _bidcontroller.text,
                                                        'user': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid
                                                      }
                                                    }

                                                }, SetOptions(merge: true));
                                                Get.snackbar(
                                                    'Sucess', 'Bid Completed.');
                                              }
                                            },
                                            child: Container(
                                              child: Icon(
                                                Icons.arrow_forward_sharp,
                                                color: ColorResources
                                                    .COLOR_PRIMARY,
                                                size: 50,
                                              ),
                                              height: 45,
                                            ))
                                      ]),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                );
              }
            return CircularProgressIndicator();
            }
        ),
      );
    });
  }

  _stallwidget(int index,Map<String ,dynamic> data) {
    return GestureDetector(
        onTap: () {
          print('hiiiiiiiiii');
          selectedindex = index;
          bidding = true;
          Map<String,dynamic> list =data['bid'];
          print('fffffffffff'+index.toString());

         bidvalue=list[index.toString()]==null?0:int.parse(list[index.toString()]['value']);

          setState(() {});
        },
        child: Image.asset(
          'assets/images/stall.png',
          height: 100,
          width: 130,
          color: selectedindex == index
              ? ColorResources.COLOR_PRIMARY
              : Colors.black,
        ));
  }
}

customTextField(String hint, TextEditingController controller,
    FormFieldValidator<String?> validator,
    {TextInputType type = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: SizedBox(
      width: Get.width / 1.5,
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          border: InputBorder.none,
//          prefix: Icon(prefixIcon),
        ),
      ),
    ),
  );
}
