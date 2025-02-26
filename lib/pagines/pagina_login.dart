import 'package:exemple_firebase/Components/boto_auth.dart';
import 'package:exemple_firebase/Components/textfield_auth.dart';
import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
  final Function()? ferClic;
  const PaginaLogin({super.key, required this.ferClic});

  void ferLogin(BuildContext context, String email, String password) async {
    String? error = await ServeiAuth().loginAmbEmailIPassword(
      email,
      password,
    );

    if (error != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 250, 183, 159),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text("Error"),
          content: Text("email i/o password incorrectes."),
        ),
      );
    } else {
      print ("login fet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController tecEmail = TextEditingController();
    final TextEditingController tecPassword = TextEditingController();
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
                  "Benvingut/da de nou",
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
                          "Fes login",
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

                SizedBox(
                  height: 10,
                ),

                //no estas registrat?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Encara no ets membre?"),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: ferClic,
                      child: Text(
                        "Registrat",
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
                  text: "Login",
                  onTap: () => ferLogin(
                    context,
                    tecEmail.text,
                    tecPassword.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
