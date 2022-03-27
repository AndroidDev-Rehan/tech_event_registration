import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import '../../controllers/event.dart';

class Payment {

  Map<String, dynamic>? paymentIntentData;
  Future<void> makePayment(String amount) async {
    final url = Uri.parse(
        "https://us-central1-befriend-me-e07b6.cloudfunctions.net/firstApi/stripePayement");
    final response =
    await http.post(url, body: {'amount': amount,'stripe_secret':'sk_test_51KhdLXDJF8BD6oeLMv7NDIwvGn0Bylrf3sX1eLTMjAZlzcmaLLmHepwLBZ8jbNBsTLQ9JcW8Tcqkxhi1yJjJDL2300DzyIQvIh'});
    paymentIntentData = json.decode(response.body);
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'Us',
            merchantDisplayName: 'Befriend'));
    displayPaymentSheet();
  }

  Future<void> displayPaymentSheet() async {
    try{
      Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true
          ));
      EventController _eventcontroller = Get.put(EventController());
      FirebaseFirestore.instance.collection('Events').doc(_eventcontroller.selectedevent.uid).set({'stlist':FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])},SetOptions(merge: true));
      paymentIntentData=null;
    }
    on StripeException catch (e) {
      debugPrint("error occurs");
      debugPrint(e.error.type);
      debugPrint(e.error.message);
      debugPrint(e.error.code.toString());
      Get.snackbar("Error", e.error.message.toString());

    }
  }
}

