import 'package:cloud_firestore/cloud_firestore.dart';

class Ads {
  final String title;
  final String description;
  final String imageUrl;
  final String adsID;

  Ads({this.title, this.description, this.imageUrl, this.adsID});
  factory Ads.fromDoc(DocumentSnapshot doc) {
    var data = doc.data();
    return Ads(
      adsID: data['adsID'],
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }
}
