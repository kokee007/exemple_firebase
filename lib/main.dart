import 'package:exemple_firebase/pagines/pagina_registre.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,

      
      home: PaginaRegistre(),
      );
  }
}

/*
1) Tenir node .js instalat
  - En acabar es pot comprobar fent:
  node -v
  npm -v

  2) Anar a la web de firebase i clicar a "go to console"
    -Tenir en compte el compte de google, "alexalvarez@ceroca.cat"

3)Desde la consola de Firebase, creem un projecte.

4)Anem al menú Compilación i habilitem: 
  Authentication i FireStore Database.

5) En una cmd, per exemple la del VS code, fem:
npm install -g firebase-tools
(aixo instala Firebase al dispositiu)

6)en terminal del visual
- Flutter pub global activate flutterfire_cli
- dart pub global activate flutterfire_cli

7)-flutter configure ´FALTA!´
-Seleccionem el projecte de firebase
amb el que volem vincular



export PATH= "$HOME/ .pub-cache/bin
*/
