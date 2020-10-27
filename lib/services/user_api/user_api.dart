import 'package:casanova/view_models/base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserApi extends BaseViewModel {
  var userRef = FirebaseFirestore.instance.collection('users');
  int userCount = 0;

  Stream<QuerySnapshot> fetchAllUser() async* {
    yield* userRef.snapshots();
  }

  UserApi() {
    userLength();
  }

  userLength() {
    var userDoc = userRef.get();
    userDoc.then((value) {
      userCount = value.docs.length;
      notifyListeners();
    });
  }

  Future<void> createUser({Map<String, dynamic> doc, String userId}) async {
    try {
      await userRef.doc(userId).set(doc);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> deleteUser({String userId, Map<String, dynamic> doc}) async {
    try {
      await userRef.doc(userId).delete();
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> updateUser({String userId, Map<String, dynamic> doc}) async {
    try {
      await userRef.doc(userId).update({});
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> updateProfilePicture({String userId, String imageUrl}) async {
    try {
      await userRef.doc(userId).update({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
