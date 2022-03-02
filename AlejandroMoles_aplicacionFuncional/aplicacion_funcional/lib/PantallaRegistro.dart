import 'package:aplicacion_funcional/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({Key? key}) : super(key: key);

  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final usuario = TextEditingController();
  final contrasenia = TextEditingController();

  String usu = '';
  String pass = '';

  void registrarse(usu, pass, BuildContext context) async {
    try {
      var url =
          'http://iesayala.ddns.net/AlejandroMoles/registro.php/?Usuario=$usu&Contrasenia=$pass';
      Uri myUri = Uri.parse(url);
      var response =
          await http.post(myUri).timeout(const Duration(seconds: 90));
      if (response.body == "1") {
        print("Registrado");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PantallaPrincipal()));
      } else {
        print("No se ha podido registrar");
      }
    } on TimeoutException catch (e) {
      print("Error de espera, tardo mucho tiempo su peticion");
    } on Error catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PantallaRegistro"),
        ),
        body: Stack(
          children: [
            FondoApli(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: usuario,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          //tendra un icono de search
                          Icons.account_circle_outlined,
                          color: Colors.white,
                        ),

                        //un hint text, que es el que se mostrara hasta que se escriba algo en el textfield
                        hintText: "Usuario",
                        hintStyle: TextStyle(color: Colors.white),
                        helperText: "Inserte aqui su nombre de Usuario",
                        helperStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 6)),
                        labelText: 'USER',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: contrasenia,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          //tendra un icono de search
                          Icons.lock,
                          color: Colors.white,
                        ),
                        //un hint text, que es el que se mostrara hasta que se escriba algo en el buscador
                        hintText: "Contraseña",
                        hintStyle: TextStyle(color: Colors.white),
                        helperText: "Inserte aqui su contraseña",
                        helperStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.all(20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 5)),
                        labelText: 'PASSWORD',
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    child: RaisedButton(
                        onPressed: () {
                          usu = usuario.text;
                          pass = contrasenia.text;
                          registrarse(usu, pass, context);
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        color: Colors.indigo,
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        child: Text(
                          'Registrarse',
                          style: TextStyle(fontFamily: 'rbold', fontSize: 30),
                        )))
              ],
            )
          ],
        ));
  }
}

class FondoApli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/fondo.png',
          fit: BoxFit.fill,
        ));
  }
}
