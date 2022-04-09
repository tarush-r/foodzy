import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kjsce_hack_2022/screens/home_screen.dart';

class AuthenticationProvider with ChangeNotifier {
  String phoneNo;
  String smsCode;
  String verificationId;

  bool codeSent = false;

  signOut() {
    FirebaseAuth.instance.signOut();
    phoneNo = null;
    smsCode = null;
    codeSent = false;
    verificationId = null;
  }

  signIn(AuthCredential authCreds) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCreds);
    await checkUserInFireStore(userCredential);
  }

  checkUserInFireStore(UserCredential userCredential) async {
    QuerySnapshot userDocs = await userRef
        .where('phone_no', isEqualTo: userCredential.user.phoneNumber)
        .get();
    if (userDocs.docs.isEmpty) {
      userRef.add({
        'phone_no': userCredential.user.phoneNumber,
        'id': userCredential.user.uid
      });
    }
  }

  signInWithOTP() {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    signIn(authCreds);
  }

  Future<void> verifyPhone() async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed = (exception) {
      print(exception.message);
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      this.codeSent = true;
      notifyListeners();
      // setState(() {
      // });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
