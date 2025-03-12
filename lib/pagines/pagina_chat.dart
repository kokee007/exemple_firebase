import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exemple_firebase/Components/bombolla_missatges.dart';
import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:exemple_firebase/chat/servei_chat.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
  final String idReceptor;

  const PaginaChat({
    super.key,
    required this.idReceptor,
  });

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  final TextEditingController tecMissatge = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

  Future.delayed(Duration(milliseconds: 500), () {
      ferScrollCapAvall();
    });
  }

  void ferScrollCapAvall(){
    scrollController.animateTo(
        scrollController.position.maxScrollExtent +100,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Sala chat"),
      ),
      body: Column(
        children: [
          //Zona missatges
          _crearZonaMostrarMissatges(),
          //Zona escriure missatges
          _crearZonaEscriureMissatges(),
        ],
      ),
    );
  }

  Widget _crearZonaMostrarMissatges() {
    return Expanded(
      child: StreamBuilder(
          stream: ServeiChat().getMissatges(
              ServeiAuth().getUsuarisActual()!.uid,
              widget
                  .idReceptor), //PER TROBAR EL ID DEL RECEPTOR i el id de l'usuari actual
          builder: (context, snapshot) {
            // Cas que ho hagi error.
            if (snapshot.hasError) {
              return Text("Error carregant missatges");
            }

            //Cas carregant les dades
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Carregant missatges...");
            }

            //Retornar dades (missatges)
            return ListView(
              controller: scrollController,
              reverse: false,
              children: snapshot.data!.docs
                  .map((document) => _construirItemMissatge(document))
                  .toList(),
            );
          }),
    );
  }

  Widget _construirItemMissatge(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return BombollaMissatges(
      missatge: data["missatge"], //Aqui es pot
      idAutor: data["idAutor"],
    );
  }

  Widget _crearZonaEscriureMissatges() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: tecMissatge,
            decoration: InputDecoration(
              hintText: "Escriu el teu missatge",
            ),
          )),
          IconButton(
            onPressed: enviarMissatge,
            icon: Icon(Icons.send, color: Colors.white),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  void enviarMissatge() {
    if (tecMissatge.text.isNotEmpty) {
      ServeiChat().enviarMissatge(
        widget.idReceptor,
        tecMissatge.text,
      );

      tecMissatge.clear();
      Future.delayed(Duration(milliseconds: 100), () {
      ferScrollCapAvall();
    });
      
    }
  }
}
