import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BombollaMissatges extends StatelessWidget {
  final String missatge;
  final String idAutor;

  const BombollaMissatges({
    super.key,
    required this.missatge,
    required this.idAutor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Align(
        alignment: idAutor == ServeiAuth().getUsuarisActual()!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: idAutor == ServeiAuth().getUsuarisActual()!.uid
                ? Colors.green
                : Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(missatge),
          ),
        ),
      ),
    );
  }
}
