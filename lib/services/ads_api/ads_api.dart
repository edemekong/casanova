import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdsApi extends ChangeNotifier {
  var adsRef = FirebaseFirestore.instance.collection('ads');
  Stream<QuerySnapshot> getAds() {
    return adsRef.snapshots();
  }
}
