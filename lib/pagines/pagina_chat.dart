import 'package:exemple_firebase/chat/servei_chat.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
final String idReceptor;

  const PaginaChat({super.key,
  required this.idReceptor,
  });

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  @override
  final TextEditingController tecMissatge = TextEditingController();

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

  _crearZonaMostrarMissatges() {
    return Expanded(child: Text("1"));
  }

  _crearZonaEscriureMissatges() {
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
    }
  }
}
