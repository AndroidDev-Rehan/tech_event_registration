import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tech_event_registration/models/feature.dart';
import '../../../controllers/addevent.dart';
import '../../../utils/const/colors.dart';
import '../../widgets/datepicker.dart';
import '../../widgets/timepicker.dart';
import '../addevent/addeventpage.dart';


class AddAdvertisementPage extends StatefulWidget {
  const AddAdvertisementPage({Key? key}) : super(key: key);

  @override
  State<AddAdvertisementPage> createState() => _AddAdvertisementPageState();
}

class _AddAdvertisementPageState extends State<AddAdvertisementPage> {
  XFile? image;
  final TextEditingController _titlecontroller = TextEditingController();

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
          title: const Text(
            'Add Advertisement',
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
        body: SingleChildScrollView(
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
                  const Text('Advertisement Title',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField('title', _titlecontroller, (value) => null),
                  const SizedBox(
                    height: 10,
                  ),
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
      );
    });
  }
}
