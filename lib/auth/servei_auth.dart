import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //usuari actual.
  User? getUsuarisActual() {
    return _auth.currentUser;
  }

  //Fer logout
  Future<void> ferLogout() async {
    return await _auth.signOut();
  }

  //Fer loginn.
  Future<String?> loginAmbEmailIPassword(String email, String password) async {
    try {
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Comprobem si l'usuari ja esta donat d'alta a Firestore (a FirebaseAuth, si
      // hem arrivbat aqui, ja sbem que si hi es)). Si no estigues donat d'alta
      // el done, d'alta a Firestore. Fet per si de cas es dones d'alta un usuari
      // directament des de la consola de Firebase i no a traves de la nostra App.

      final QuerySnapshot querySnapshot = await _firestore
          .collection("Usuaris")
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
          "email": email,
          "uid": credencialUsuari.user!.uid,
          "nom": "",
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return "Error: ${e.message}";
    }
  }

  //Fer registre.
  Future<String?> registreAmbEmailIpassword(String email, password) async {
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

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "Ja hi ha un usuari amb aquest email.";

        case "invalid-email":
          return "email no valid.";

        case "operation-not-allowed":
          return "Email i/o password no habilitats.";

        case "weak-password":
          return "cal un password no habilitats.";

        default:
          return "Error ${e.message}";
      }
    } catch (e) {
      return "Error  $e";
    }
  }
}
