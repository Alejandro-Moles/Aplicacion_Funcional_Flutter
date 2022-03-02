// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:async';

import 'package:aplicacion_funcional/aniadirTarea.dart';
import 'package:aplicacion_funcional/verTarea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pantalla2 extends StatelessWidget {
  Pantalla2(this.usuario);

  final String usuario;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pantalla2"),
        ),
        body: Stack(
          children: [
            FondoApli(),
            Container(
              padding: EdgeInsets.all(30),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.supervised_user_circle_rounded,
                          size: 150,
                          color: Colors.black,
                        ),
                        Column(
                          children: [
                            Text(
                              "Bienvenido",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amberAccent),
                            ),
                            Text(
                              this.usuario,
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Card(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RaisedButton(
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AniadirTarea()));
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add_box_rounded,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                  Text(
                                    "Añadir Tarea",
                                    style: TextStyle(fontSize: 30),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RaisedButton(
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              onPressed: () {
                                verFecha(context);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 100,
                                  ),
                                  Text(
                                    "Mirar Tareas",
                                    style: TextStyle(fontSize: 30),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void verFecha(BuildContext context) async {
    try {
      var url = 'http://iesayala.ddns.net/AlejandroMoles/verFecha.php';
      Uri myUri = Uri.parse(url);
      var response =
          await http.post(myUri).timeout(const Duration(seconds: 90));

      var fecha = response.body.toString();

      var url2 = 'http://iesayala.ddns.net/AlejandroMoles/verNombre.php';
      Uri myUri2 = Uri.parse(url2);
      var response2 =
          await http.post(myUri2).timeout(const Duration(seconds: 90));

      var nombre = response2.body.toString();

      var url3 = 'http://iesayala.ddns.net/AlejandroMoles/verDescripcion.php';
      Uri myUri3 = Uri.parse(url3);
      var response3 =
          await http.post(myUri3).timeout(const Duration(seconds: 90));

      var desc = response3.body.toString();

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerTarea(fecha, nombre, desc)));
    } on TimeoutException catch (e) {
      print("Error de espera, tardo mucho tiempo su peticion");
    }
  }
}

class FondoApli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, color: Colors.black38);
  }
}
