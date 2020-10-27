import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FaqApi extends ChangeNotifier {
  var faqRef = FirebaseFirestore.instance.collection('faq');

  Future<QuerySnapshot> getAllFaq() async {
    return await faqRef.get();
  }
}
