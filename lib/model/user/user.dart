import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Users {
  String userID;
  String firstName;
  String lastName;
  String email;
  String fullName;
  String phone;
  String address;
  String imageUrl;
  double serviceValues;
  String password;

  Users(
      {this.firstName,
      this.userID,
      this.lastName,
      this.email,
      this.fullName,
      this.phone,
      this.address,
      this.serviceValues,
      this.password,
      this.imageUrl});

  factory Users.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    return Users(
      userID: doc.id,
      firstName: data['firstName'],
      lastName: data['lastName'],
      fullName: data['fullName'],
      phone: data['phone'],
      address: data['address'],
      email: data['email'],
      imageUrl: data['imageUrl'],
      password: data['password'],
      serviceValues: data['serviceValue'],
    );
  }

  Map<String, dynamic> toDoc() {
    var data = Map<String, dynamic>();
    data['userID'] = this.userID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.firstName + " " + this.lastName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['imageUrl'] =
        'https://scontent-los2-1.xx.fbcdn.net/v/t1.0-9/110195364_2817051085250329_2406961046516895270_o.jpg?_nc_cat=103&_nc_sid=84a396&_nc_eui2=AeFYs6INspmoNphqeZH5Q3bCgY0YH9L6FwSBjRgf0voXBExbx4Eh9MQeoyy4n--ppkCo4tQNs-oNrRNLLXfAo6eS&_nc_ohc=PoVBL2CSh94AX9fG-mA&_nc_ht=scontent-los2-1.xx&oh=caaaafc59aac5423e864c389e26bd9b5&oe=5F6DB90B';
    data['serviceValue'] = this.serviceValues;
    return data;
  }

  Map<String, dynamic> userToDoc({
    @required String userID,
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String phone,
    String address,
    String imageUrl,
    double serviceValues,
  }) {
    var data = Map<String, dynamic>();
    data['userID'] = userID;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['fullName'] = firstName + " " + lastName;
    data['phone'] = phone ?? '';
    data['address'] = address ?? '';
    data['email'] = email;
    data['imageUrl'] = imageUrl == null
        ? 'https://firebasestorage.googleapis.com/v0/b/my-daily-wash.appspot.com/o/app_data%2Fuser_profile_pics%2Fdefault_user_pics%2FFace-Profile-User-Man-Boy-Person-Avatar-512.png?alt=media&token=85a6009e-5d4a-425f-a22a-37ea7c2323f5'
        : imageUrl;
    data['serviceValue'] = 0.0005;
    return data;
  }
}
