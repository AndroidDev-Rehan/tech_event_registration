import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/bindings/binding.dart';
import 'utils/authWrapper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: "Care-Corner",
      theme: ThemeData(
        primaryColor: Colors.purple
      ),
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      home:const AuthWrapper(),
    //  home: const Scaffold(),
    );
  }
}
