import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String texto = "";
  int numeroAl = Random().nextInt(100);
  int intentos = 10;
  int min = 0, max = 0;

  void resetGame(var context, bool victoria, String titulo, String desc) {
    setState(() {
      numeroAl = Random().nextInt(100);
      min = 0;
      max = 0;
      intentos = 10;

      Alert(
          context: context,
          title: titulo,
          desc: desc,
          style: AlertStyle(
            backgroundColor: victoria ? Colors.green : Colors.red,
            titleStyle: const TextStyle(
                color: Colors.white,
                fontFamily: "Arial",
                fontWeight: FontWeight.bold),
            descStyle: const TextStyle(
                color: Colors.white,
                fontFamily: "Arial",
                fontStyle: FontStyle.italic),
          ),
          buttons: <DialogButton>[
            DialogButton(
              color: Colors.grey[200],
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: Text(
                victoria ? "Aceptar" : "Reintentar",
                style: TextStyle(color: Colors.grey[800], fontSize: 20),
              ),
            )
          ]).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                color: const Color.fromARGB(255, 197, 197, 197),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Tienes $intentos intentos",
                      style: const TextStyle(color: Colors.black),
                    ),
                    TextField(
                      onSubmitted: (String str) {
                        if (str == "") {
                          str = "Introduce un número";
                        } else {
                          try {
                            int numero = int.parse(str);
                            setState(() {
                              if (numeroAl == numero && intentos > 1) {
                                str = "¡Ganaste! :D";
                                resetGame(context, true, str,
                                    "Adivinaste el número. Felicidades");
                              } else if (numero > numeroAl && intentos > 1) {
                                str = "Muy alto";
                                max = numero;
                                intentos--;
                              } else if (numero < numeroAl && intentos > 1) {
                                str = "Muy bajo";
                                min = numero;
                                intentos--;
                              } else if (intentos <= 1) {
                                str = "Perdiste :c";
                                resetGame(context, false, str,
                                    "Tus intententos se han terminado. Vuelve a intentar");
                              }
                            });
                          } catch (e) {
                            str = "Introduce solo números";
                          }
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(str),
                          duration: Durations.long1,
                          backgroundColor: Colors.blueGrey,
                        ));
                      },
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.white,
                          prefixIcon: const Icon(Icons.egg),
                          hintText: "Escribe algo",
                          helperText: min.toString(),
                          counterText: max.toString(),
                          focusColor: Colors.white,
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200]),
                    )
                  ],
                ))));
  }
}
