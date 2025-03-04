import 'package:exemple_firebase/Components/item_usuari.dart';
import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:exemple_firebase/chat/servei_chat.dart';
import 'package:exemple_firebase/pagines/pagina_chat.dart';
import 'package:flutter/material.dart';

class PaginaInici extends StatelessWidget {


  const PaginaInici({
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text(ServeiAuth().getUsuarisActual()!.email.toString()),
        actions: [
          IconButton(
            onPressed: () {
              ServeiAuth().ferLogout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ServeiChat().getUsuaris(),
        builder: (context, snapshot){

          // Cas que hi hagi un error
          if (snapshot.hasError) {
           return Text("Error en el snapshot.");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {

            return Text("Carregant dades...");
          }

          // Es retornen les dades.
          return ListView(
            children: snapshot.data!.map<Widget>(
              (dadesUsuari) => _construeixItemUsuari(dadesUsuari, context)
            ).toList(),
          );
        },
      ),
    );
  }

  Widget _construeixItemUsuari(Map<String, dynamic> dadesUsuari, BuildContext context) {

    if (dadesUsuari["email"] == ServeiAuth().getUsuarisActual()!.email){
      return Container();

    }

    return ItemUsuari(
      emailUsuari: dadesUsuari["email"]
      , onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  PaginaChat(idReceptor: dadesUsuari["uid"],),
          ),
        );
      },);
  }
}
