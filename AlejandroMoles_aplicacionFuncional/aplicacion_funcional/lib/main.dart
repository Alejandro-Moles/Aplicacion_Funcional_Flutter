import 'package:aplicacion_funcional/Pantalla2.dart';
import 'package:aplicacion_funcional/PantallaRegistro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Aplicacion Funcional",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        home: PantallaPrincipal());
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final usuario = TextEditingController();
  final contrasenia = TextEditingController();

  String usu = '';
  String pass = '';

  void ingresar(usu, pass, BuildContext context) async {
    try {
      var url =
          'http://iesayala.ddns.net/AlejandroMoles/login.php/?Usuario=$usu&Contrasenia=$pass';
      Uri myUri = Uri.parse(url);
      var response = await http.post(myUri, body: {
        'Usuario': usu,
        'Contrasenia': pass
      }).timeout(const Duration(seconds: 90));

      if (response.body == "1") {
        print("Conectado");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Pantalla2(usu)));
      } else {
        print("No se ha podido conectar");
      }
    } on TimeoutException catch (e) {
      print("Error de espera, tardo mucho tiempo su peticion");
    } on Error catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicacion Funcional"),
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
                      labelStyle: TextStyle(color: Colors.white, fontSize: 30)),
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
                      labelStyle: TextStyle(color: Colors.white, fontSize: 30)),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: RaisedButton(
                      onPressed: () {
                        usu = usuario.text;
                        pass = contrasenia.text;
                        ingresar(usu, pass, context);
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                      color: Colors.indigo,
                      textColor: Colors.white,
                      shape: StadiumBorder(),
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontFamily: 'rbold', fontSize: 30),
                      ))),
              Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PantallaRegistro()));
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
      ),
    );
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
