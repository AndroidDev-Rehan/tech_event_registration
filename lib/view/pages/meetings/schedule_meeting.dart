import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_event_registration/models/meeting.dart';
import 'package:tech_event_registration/utils/authWrapper.dart';
import '../../../utils/const/colors.dart';
import '../../widgets/datepicker.dart';
import '../../widgets/timepicker.dart';
import '../addevent/addeventpage.dart';

class ScheduleMeetingScreen extends StatefulWidget {

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {

  bool loading = false;
  XFile? image;

  TextEditingController _titlecontroller = TextEditingController();

  TextEditingController _venuecontroller = TextEditingController();

  TextEditingController _paymentcontroller = TextEditingController();

  TextEditingController _descontroller = TextEditingController();

  TextEditingController _stallcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_PRIMARY,
          title: const Text(
            'Schedule Meeting',
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
          actions: [
            IconButton(
              onPressed: () async {
                String img = await uploadImageToFirebase(image!);
              },
              icon: const Icon(
                Icons.upload_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: loading ?
        Center(child: CircularProgressIndicator(),):
        SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Basic Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Meeting Topic',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField('Topic', _titlecontroller, (value) => null),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Enter Brief Description',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      'Description', _descontroller, (value) => null),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Location',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField(
                      'Where is the event', _venuecontroller, (value) => null),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      TimePickerRow(),
                      DatePickerRow(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: loading ? SizedBox(height: 0,) : scheduleMeetingButton(),
      );
    });
  }

  scheduleMeetingButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,0, 16,16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () async{
              setState(() {
                loading = true;
              });
              await FirebaseFirestore.instance.collection("Meetings").add(Meeting(meetingTopic: _titlecontroller.text, meetingDescription: _descontroller.text, meetingDate: "27th March", meetingTime: "11:30 am", meetingLocation: "Lahore").toMap());
              setState(() {
                loading = false;
              });
              Get.off(()=>AuthWrapper());

            },
            child: Text("Schedule Meeting", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 50),
            )
        ),
      ),
    );
  }
}
