import 'dart:io';
import 'package:casanova/model/user/user.dart';
import 'package:casanova/services/auth_api/auth_api.dart';
import 'package:casanova/services/user_api/user_api.dart';
import 'package:casanova/ui/views/widgets/snacks.dart';
import 'package:casanova/ui/views/widgets/toast.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as Im;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../base_view_model.dart';

enum ProfileState { Initial, Loading, Done }

class ProfileViewModel extends BaseViewModel {
  final StorageReference storageRef = FirebaseStorage.instance.ref();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final userApi = GetIt.I.get<UserApi>();
  final authApi = GetIt.I.get<AuthApi>();

  File imagefile;
  final picker = ImagePicker();
  String postId = Uuid().v4();
  bool isUploadingForImage = false;
  bool isUploading = false;
  String message;
  String imageUrl;
  ProfileState profileState = ProfileState.Initial;

  handleTakePhoto(BuildContext context, Users users) async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 675, maxWidth: 960);
    imagefile = File(pickedFile.path);
    isUploadingForImage = true;
    profileState = ProfileState.Loading;
    notifyListeners();

    await compresImage();
    await uploadImage(file: imagefile, users: users);
    await userApi.updateProfilePicture(
        userId: users.userID, imageUrl: imageUrl);
    await authApi.getCurrentUser(users.userID);
    profileState = ProfileState.Initial;

    showToast('Image Added');
    notifyListeners();
  }

  handleChoosePhoto(BuildContext context, Users users) async {
    profileState = ProfileState.Loading;
    notifyListeners();

    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imagefile = File(pickedFile.path);
    isUploadingForImage = true;
    profileState = ProfileState.Loading;
    notifyListeners();

    await compresImage();
    await uploadImage(file: imagefile, users: users);
    await userApi.updateProfilePicture(
        userId: users.userID, imageUrl: imageUrl);
    await authApi.getCurrentUser(users.userID);
    profileState = ProfileState.Initial;
    showSnackbarSuccess(context, msg: 'Successfully, added image!');
    notifyListeners();
  }

  handleClearImage() {
    imagefile = null;
    imageUrl = '';
    showToast('Image Cleared');
    notifyListeners();
  }

  compresImage() async {
    if (imagefile != null) {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      Im.Image imageFile = Im.decodeImage(imagefile.readAsBytesSync());
      final compressImageFile = File('$path/img_$postId.jpg')
        ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
      imagefile = compressImageFile;
      notifyListeners();
    } else {
      imagefile = File('');
    }
  }

  uploadImage({File file, Users users}) async {
    try {
      isUploadingForImage = true;
      StorageUploadTask uploadTask = storageRef
          .child("users_pictures/${users.userID}/${users.firstName}$postId.jpg")
          .putFile(file);
      StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
      String downloadUrl = await storageSnap.ref.getDownloadURL();
      imageUrl = downloadUrl;
      isUploadingForImage = false;
    } catch (e) {
      isUploadingForImage = false;
      message = e.toString();
      print(e);
    }
    notifyListeners();
  }

  changePicture() {}

  updateProfile(Users users) {}
}
