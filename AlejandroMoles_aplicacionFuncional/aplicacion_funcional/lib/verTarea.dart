import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class VerTarea extends StatelessWidget {
  VerTarea(this.Fecha, this.Nombre, this.Descripcion);

  final String Fecha;
  final String Nombre;
  final String Descripcion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver Tarea"),
      ),
      body: Stack(
        children: [
          FondoApli(),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        this.Fecha,
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SafeArea(
                      child: Row(
                    children: [
                      Icon(
                        Icons.auto_stories,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        this.Nombre,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  SafeArea(
                      child: Row(
                    children: [
                      Icon(
                        Icons.description,
                        size: 50,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        this.Descripcion,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FondoApli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, color: Colors.black38);
  }
}
