import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtual_approval_flutter/Request.dart';
import 'package:virtual_approval_flutter/Universals.dart';

class DatabaseInteractions {

  static void getTaSecretCode() {
    FirebaseFirestore.instance
        .collection('ta secret codes')
        .doc("ta secret codes")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        Universals.taSecretCode = documentSnapshot.data()["ta secret code"];
      } else {
        print('Document does not exist on the database');
        Universals.taSecretCode = "";
      }
    });
  }

  static void saveUserProfile(String name, String email) {
    FirebaseFirestore.instance.collection('users')
        .doc(email)
        .set({
      "name": name,
      'email': email,
    })
        .then((value) => print("User Profile Added"))
        .catchError((error) => print("Failed to add user profile: $error"));
  }

  static void saveRequest(Request request) {
    FirebaseFirestore.instance.collection(request.status + " requests")
        .doc(request.requestedAt)
        .set({
      'name': request.name,
      'email': request.email,
      'course': request.course,
      'question': request.question,
      'requested at': request.requestedAt,
      'status': request.status,
      "request taken at": request.requestTakenAt,
      "request finished at": request.requestFinishedAt,
      "time spent": request.timeSpent,
      "taken by": request.takenBy,
      "taker email": request.takerEmail,
    })
        .then((value) => print("New Request Added"))
        .catchError((error) => print("Failed to save new request: $error"));
  }

  static void updateNewRequest(Request request) {
    FirebaseFirestore.instance.collection("new requests")
        .doc(request.requestedAt)
        .update({
      'name': request.name,
      'email': request.email,
      'course': request.course,
      'question': request.question,
      'requested at': request.requestedAt,
      'status': request.status,
      "request taken at": request.requestTakenAt,
      "request finished at": request.requestFinishedAt,
      "time spent": request.timeSpent,
      "taken by": request.takenBy,
      "taker email": request.takerEmail,
    })
        .then((value) => print("Request Updated"))
        .catchError((error) => print("Failed to update request: $error"));
  }

  static void deleteRequest(Request request) {
    FirebaseFirestore.instance.collection("new requests")
        .doc(request.requestedAt)
        .delete()
        .then((value) => print("Request Deleted"))
        .catchError((error) => print("Failed to delete request: $error"));
  }

}