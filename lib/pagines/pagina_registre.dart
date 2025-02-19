import 'package:exemple_firebase/Components/boto_auth.dart';
import 'package:exemple_firebase/Components/textfield_auth.dart';
import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:flutter/material.dart';

class PaginaRegistre extends StatelessWidget {
  const PaginaRegistre({super.key});

  void ferRegistre(
      BuildContext context, String email, String password, String confPassword) {
    if (password.isEmpty || email.isEmpty) {
      return;
    }

    if (password != confPassword) {
      //Gestio del cas
      return;
    }
    try {
      ServeiAuth().registreAmbEmailIpassword(email, password);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPassword = TextEditingController();
    final TextEditingController tecConfPass = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2500, 183, 159),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                Icon(
                  Icons.fireplace,
                  size: 120,
                  color: Color.fromARGB(255, 255, 240, 218),
                ),

                SizedBox(height: 25),

                //Frase
                Text(
                  "Crea un compte nou",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 240, 218),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 25),

                //Text divisori
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 255, 240, 218),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Registra't",
                          style: TextStyle(
                              color: Color.fromARGB(255, 355, 240, 218)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 255, 240, 218),
                        ),
                      ),
                    ],
                  ),
                ),

                //TextField Email
                TextfieldAuth(
                  controller: tecEmail,
                  obscureText: false,
                  hintText: "Escriu el teu email...",
                ),

                //TextField Password
                TextfieldAuth(
                  controller: tecPassword,
                  obscureText: true,
                  hintText: "Escriu la teva contrasenya...",
                ),

                //TextField Confirmar password
                TextfieldAuth(
                  controller: tecConfPass,
                  obscureText: true,
                  hintText: "Reescriu la contrasenya...",
                ),

                SizedBox(
                  height: 10,
                ),

                //no estas registrat?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ja ets membre?"),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      child: Text(
                        "Fes login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 40, 71, 97),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                //Botó registra't
                BotoAuth(
                  text: "REGISTRA'T",
                  onTap: () => ferRegistre(
                    context,
                    tecEmail.text,
                    tecPassword.text,
                    tecConfPass.text,
                  ),
                ),
                BotoAuth(
                  text: "Logout",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
