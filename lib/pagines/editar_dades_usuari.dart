import 'dart:typed_data';

import 'package:exemple_firebase/mongoDB/db_conf.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class EditarDadesUsuari extends StatefulWidget {
  const EditarDadesUsuari ({super.key});

  @override
  State<EditarDadesUsuari> createState() => EditarDadesUsuari();
}

class _EditarDadesUsuari extends StatefulWidget<EditarDadesUsuari> {

  mongodb.Db? _db;
  Uint8List? _imatgeEnBytes;
  final ImagePicker imagepicker = ImagePicker();

  @override
  void dispose() {
    // TODO: implement dispose
    _db?.close();
    super.dispose();
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _connectarAmbMongo().then((_) => print("Connectat a Mongo"));
  }

  Future _connectarAmbMongo() async {
    _db = await mongodb.Db.create(DBConf().connectionString); 

    await _db!.open();  

 


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text("Editar dades usuari"),
      ),
      body:Center(
        child: Column(
          children: [
            Text("Editar dades usuari"),
          ],
        ),
      )
    );
  }
}
