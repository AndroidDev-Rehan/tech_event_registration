import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_event_registration/controllers/addevent.dart';
import 'package:tech_event_registration/services/user_db.dart';
import 'package:tech_event_registration/utils/const/colors.dart';
import 'package:uuid/uuid.dart';

import '../../../models/events.dart';
import '../../widgets/datepicker.dart';
import '../../widgets/timepicker.dart';
import '../home/home.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({Key? key}) : super(key: key);


  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool loading = false;
  AddEventController _controller = Get.put(AddEventController());
  XFile? image;
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _venuecontroller = TextEditingController();
  TextEditingController _paymentcontroller = TextEditingController();
  TextEditingController _descontroller = TextEditingController();
  TextEditingController _stallcontroller = TextEditingController();

  Future<dynamic> ImagePickersheet() async {
    Get.bottomSheet(Container(
      color: Colors.white,
      child: Wrap(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: const Text(
                    'Choose Option',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: Get.width,
                  height: 1.0,
                  color: Colors.white.withOpacity(0.8),
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    var imgFile =
                        await _picker.pickImage(source: ImageSource.camera);

                    if (imgFile != null) {
                      image = imgFile;
                      setState(() {});
                      Get.back();
                    }
                  },
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.camera_alt,
//                                  color: Colors.white.withOpacity(0.7),
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('Camera',
                            style: TextStyle(fontSize: 15, color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();

                    var imgFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (imgFile != null) {
                      image = imgFile;
                      setState(() {});
                      Get.back();
                    }
                  },
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.photo_album,
//                                  color: Colors.white.withOpacity(0.7),
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Upload from Gallery',
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_PRIMARY,
          title: (loading)
              ? Center(
                  child: Container(),
                )
              : const Text(
                  'Add Event',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
            (loading)
                ? Center(
                    child: Container(),
                  )
                : IconButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });
                        String img = await uploadImageToFirebase(image!);
                        Events data = Events(
                            title: _titlecontroller.text,
                            Image: img,
                            venue: _venuecontroller.text,
                            starttime: _controller.starttime.toString(),
                            endtime: _controller.date.toString(),
                            description: _descontroller.text,
                            price: _stallcontroller.text,
                            stall: _stallcontroller.text,
                            educriteria: _controller.degree!,
                            agecriteria: _controller.age!);
                        UserDatabase.setevents(data);
                        setState(() {
                          loading = false;
                        });
                        Get.off(() => const HomePage());
                      }
                    },
                    icon: const Icon(
                      Icons.upload_outlined,
                      color: Colors.white,
                    ),
                  )
          ],
        ),
        body: (loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Form(
                      key: _formKey,
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
                          const Text('Event Title',
                              style: TextStyle(color: Colors.grey, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextField(
                            'Title',
                            _titlecontroller,
                            (String? value) {
                              if (value == null) {
                                return 'title is required';
                              }
                              if (value.isEmpty) {
                                return 'title is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Enter Description',
                              style: TextStyle(color: Colors.grey, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextField('Description', _descontroller,
                              (String? value) {
                            if (value == null) {
                              return 'description is required';
                            }
                            if (value.isEmpty) {
                              return 'description is required';
                            }
                            return null;
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Price of the Ticket',
                              style: TextStyle(color: Colors.grey, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextField(
                            '\$',
                            _paymentcontroller,
                            (String? value) {
                              if (value == null) {
                                return 'price is required';
                              }
                              if (value.isEmpty) {
                                return 'price is required';
                              }
                              return null;
                            },
                            type: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Venue',
                              style: TextStyle(color: Colors.grey, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextField('Where is the event', _venuecontroller,
                              (String? value) {
                            if (value == null) {
                              return 'venue is required';
                            }
                            if (value.isEmpty) {
                              return 'venue is required';
                            }
                            return null;
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const TimePickerRow(),
                              const DatePickerRow(),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('No of Stalls',
                              style: TextStyle(color: Colors.grey, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextField(
                            'Stalls',
                            _stallcontroller,
                            (String? value) {
                              if (value == null) {
                                return 'stalls is required';
                              }
                              if (value.isEmpty) {
                                return 'stalls is required';
                              }
                              return null;
                            },
                            type: TextInputType.number,
                          ),
                          const Text('Student Eligibility criteria',
                              style: TextStyle(color: Colors.grey, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              color: Colors.grey.withOpacity(0.2),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: MyDropDownButton(
                                dropdownValue: "Select Age",
                                items: const [
                                  "Select Age",
                                  "Under 18",
                                  "Above 18",
                                  "Above 25",
                                  "Above 35"
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              color: Colors.grey.withOpacity(0.2),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: MyDropDownButton(
                                dropdownValue: "Select Degree",
                                items: const [
                                  "Select Degree",
                                  "Matric",
                                  "Intermediate",
                                  "Undergraduate",
                                  "Graduate"
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Upload Photo',
                              style: TextStyle(color: Colors.grey, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                ImagePickersheet();
                              },
                              child: image == null
                                  ? Container(
                                      height: Get.height / 5,
                                      width: Get.width,
                                      child: const Center(
                                        child: Icon(Icons.add),
                                      ),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  : Image.file(
                                      File(image!.path),
                                      height: Get.height / 5,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    )),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }
}

class MyDropDownButton extends StatefulWidget {
  String dropdownValue;
  final List<String> items;

  MyDropDownButton({Key? key, required this.dropdownValue, required this.items})
      : super(key: key);

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  // String dropdownValue = widget.dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: widget.dropdownValue,
      dropdownColor: Colors.white,
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Colors.black.withOpacity(0.6),
      ),
      // elevation: 16,
      // style: const TextStyle(color: Colors.deepPurple),
      underline: const SizedBox(
        height: 0,
        width: 0,
      ),
      onChanged: (String? newValue) {
        setState(() {
          AddEventController controller = Get.put(AddEventController());

          if (widget.items[0] == "Select Age") {
            controller.age = newValue;
          } else if (widget.items[0] == "Select Degree") {
            controller.degree = newValue;
          }

          widget.dropdownValue = newValue!;
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        );
      }).toList(),
    );
  }
}

customTextField(String hint, TextEditingController controller,
    FormFieldValidator<String?> validator,
    {TextInputType type = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
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
  );
}

Future<String> uploadImageToFirebase(XFile _imageFile) async {
  String fileName = const Uuid().v4();
  Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('uploads/${fileName}');

  UploadTask uploadTask = firebaseStorageRef.putFile(File(_imageFile.path));

  TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
  print('//////////////////////');
  String downloadurl = await snapshot.ref.getDownloadURL();
  return downloadurl;
}
