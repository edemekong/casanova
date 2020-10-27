import 'package:casanova/ui/views/start_view/auth_page/signup_login_views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../model/user/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthApi with ChangeNotifier {
  var userRef = FirebaseFirestore.instance.collection('users');
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = FacebookLogin();

  Users users = Users();
  String message;

  Future<Users> getCurrentUser(String userID) async {
    DocumentSnapshot documents = await userRef.doc(userID).get();
    users = Users.fromDoc(documents);
    return users;
  }

  Future<void> loginUser(context,
      {@required String email, @required String password}) async {
    final currentUser = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    await getCurrentUser(currentUser.user.uid);
  }

  Future<void> signUpUser({
    @required String email,
    @required String password,
    @required String firstName,
    @required String phone,
    @required String lastName,
  }) async {
    final currentUser = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await userRef.doc(currentUser.user.uid).set(users.userToDoc(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        userID: currentUser.user.uid));
    await getCurrentUser(currentUser.user.uid);
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleAuth =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken,
      );
      var signedUser = await firebaseAuth.signInWithCredential(credential);
      var user = signedUser.user;

      message = 'Google user ${user.email}, registered Successfully, Welcome!!';
      await userRef.doc(user.uid).set(users.userToDoc(
          email: user.email,
          firstName: user.displayName,
          lastName: user.displayName,
          phone: user.phoneNumber,
          imageUrl: user.photoURL,
          userID: user.uid));
      print(users.email);
      notifyListeners();
      await getCurrentUser(_googleSignIn.currentUser.id);
    } catch (e) {
      message = 'An Error Occured!!';
      notifyListeners();
    }
  }

  loginWithFacebook() async {
    final FacebookLoginResult result =
        await facebookLogin.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        print(message);

        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        print(message);
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        print(message);

        break;
    }
  }

  void _showMessage(String message) {
    message = message;
  }

  Stream<String> get onAuthStateChanged => firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  Future<void> signOut(context) async {
    await firebaseAuth.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => SignUpLogin()));
  }

  // Reset Password
  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  signInWithOtp(String smsCode, String verId) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: smsCode,
    );
    signInWithCredential(authCredential);
  }

  Future<void> verifyPhone(String phoneNo) async {
    String verID;
    String smsCode;
    bool codeSent = false;

    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signInWithCredential(authResult);
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {};

    final PhoneCodeSent smsSent = (String verificationID, [int forceResend]) {
      verID = verificationID;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verificationID) {
      verID = verificationID;
    };

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  Future<void> signInWithEmailAndPasswordForSharedPref(context,
      {String email, String password}) async {
    try {
      final currentUser = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password));
      DocumentSnapshot documents =
          await userRef.doc(currentUser.user.uid).get();
      users = Users.fromDoc(documents);
      await getCurrentUser(currentUser.user.uid);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithCredential(AuthCredential authCredential) async {
    await firebaseAuth.signInWithCredential(authCredential);
  }

  handleAuth() {
    return StreamBuilder(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return null;
        } else {
          return null;
        }
      },
    );
  }
}
