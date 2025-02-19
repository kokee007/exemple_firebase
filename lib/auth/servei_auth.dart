import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Fer registre.
  Future<UserCredential> registreAmbEmailIpassword(
      String email, password) async {
    print("email:" + email);

    try {
      UserCredential credencialUsuari =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

    _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
      "email": email,
      "uid": credencialUsuari.user!.uid,
      "nom": "",
    });


      return credencialUsuari;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
