import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exemple_firebase/Models/misstge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ServeiChat {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsuaris() {
    return _firestore.collection("Usuaris").snapshots().map((event) {

      return event.docs.map((document) {

        return document.data();
      }).toList();
    });
  }

  Future<void> enviarMissatge(String idReceptor, String missatge) async {

    // La salaa de chat es entre dos usuaris. La creem a partir dels seus uid's

    String idUsuariActual = _auth.currentUser!.uid;
    String emailUsuariActual = _auth.currentUser!.email!;
    Timestamp timestamp = Timestamp.now();

    Missatge nouMissatge = Missatge(
      idAutor: idUsuariActual,
      emailAutor: emailUsuariActual,
      idReceptor: idReceptor,
      missatge: missatge,
      timestamp: timestamp,
    );

    List<String> idUsuaris = [idUsuariActual, idReceptor ];
    //Odene, la llista alfabeticament (aixi sempre es igual, independentment de l'usuari que te la sessió oberta)
    idUsuaris.sort(); 


    String idSalaChat = idUsuaris.join("_");

    await _firestore
    .collection("SalesChat")
    .doc(idSalaChat)
    .collection("Missatges")
    .add(
      nouMissatge.retornaMapaMissatge(),
    );
    
  }
}
