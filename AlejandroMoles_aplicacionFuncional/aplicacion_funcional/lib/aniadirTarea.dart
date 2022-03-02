import 'package:aplicacion_funcional/Pantalla2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AniadirTarea extends StatefulWidget {
  const AniadirTarea({Key? key}) : super(key: key);

  @override
  _AniadirTareaState createState() => _AniadirTareaState();
}

class _AniadirTareaState extends State<AniadirTarea> {
  late DateTime? _dateTime = null;

  final Nombre = TextEditingController();
  final Descripcion = TextEditingController();

  String nombre = '';
  String descripcion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir Tarea"),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.date_range_sharp,
                          size: 60,
                          color: Colors.indigo,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                            shape: StadiumBorder(),
                            child: Text(
                              "Selecciona una fecha",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2222))
                                  .then((date) {
                                setState(() {
                                  _dateTime = date!;
                                });
                              });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // ignore: prefer_const_constructors
                    TextField(
                      controller: Nombre,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.auto_stories,
                            color: Colors.blue,
                            size: 40,
                          ),

                          //un hint text, que es el que se mostrara hasta que se escriba algo en el textfield
                          hintText: "Nombre de la tarea",
                          hintStyle: TextStyle(color: Colors.white),
                          helperText: "Inserte aqui el nombre de la tarea",
                          helperStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          contentPadding: EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 6)),
                          labelText: 'Titulo',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // ignore: prefer_const_constructors
                    TextField(
                      controller: Descripcion,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            //tendra un icono de search
                            Icons.description,
                            color: Colors.blue,
                            size: 40,
                          ),

                          //un hint text, que es el que se mostrara hasta que se escriba algo en el textfield
                          hintText: "Descripcion de la tarea",
                          hintStyle: TextStyle(color: Colors.white),
                          helperText: "Inserte aqui la descripcion de la tarea",
                          helperStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                          contentPadding: EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 6)),
                          labelText: 'Descripcion',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 30)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                        onPressed: () {
                          print(_dateTime.toString().substring(0, 10));
                          nombre = Nombre.text;
                          descripcion = Descripcion.text;
                          if (nombre == "" ||
                              descripcion == "" ||
                              _dateTime == null) {
                          } else {
                            registarse(nombre, descripcion, _dateTime);
                          }
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                        color: Colors.indigo,
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        child: Text(
                          'Añadir',
                          style: TextStyle(fontFamily: 'rbold', fontSize: 30),
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void registarse(String nombre, String descripcion, DateTime? dateTime) async {
    try {
      var fecha = _dateTime.toString().substring(0, 10);
      var url =
          'http://iesayala.ddns.net/AlejandroMoles/ingresar_tarea.php/?Fecha=$fecha&Nombre=$nombre&Descripcion=$descripcion';
      Uri myUri = Uri.parse(url);
      var response =
          await http.post(myUri).timeout(const Duration(seconds: 90));
      if (response.body == "1") {
        print("Registrado");
        Descripcion.clear();
        Nombre.clear();
      } else {
        print("No se ha podido registrar");
      }
    } on TimeoutException catch (e) {
      print("Error de espera, tardo mucho tiempo su peticion");
    } on Error catch (e) {}
  }
}

class FondoApli extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, color: Colors.black38);
  }
}
