import 'dart:math';

import 'package:flutter/material.dart';



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
  int numeroAl = Random().nextInt(10);
  int intentos = 10;
  int min = 0, max = 0;

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
              color: Colors.blue,
              child: TextField(
                onSubmitted: (String str) {
                  if (str == "") {
                    str = "Introduce un número";
                  } else {
                    try {
                      setState(() {
                        int numero = int.parse(str);

                        if (numeroAl == numero && intentos > 0) {
                          str = "Ganaste";
                          showDialog(context: context, builder: builder);
                        } else if (numero > numeroAl && intentos > 0) {
                          str = "Muy alto";
                          max = numero;
                          intentos--;
                        } else if (numero < numeroAl && intentos > 0) {
                          str = "Muy bajo";
                          min = numero;
                          intentos--;
                        } else if (intentos <= 0) {
                          str = "Perdiste :c";
                        }
                      });
                    } catch (e) {
                      str = "Introduce solo números";
                    }
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(str),
                    duration: Durations.long1,
                    backgroundColor: Colors.amber,
                  ));
                },
                keyboardType: TextInputType.number,
                autofocus: true,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    prefixIconColor: Colors.white,
                    prefixIcon: Icon(Icons.egg),
                    hintText: "Escribe algo",
                    helperText: min.toString(),
                    counterText: max.toString(),
                    focusColor: Colors.white,
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[200]),
              )),
        ));
  }
}
_confirmRegister() {
var baseDialog = BaseAlertDialog(
    title: "Confirm Registration",
    content: "I Agree that the information provided is correct",
    yesOnPressed: () {},
    noOnPressed: () {},
    yes: "Agree",
    no: "Cancel");
showDialog(context: context, builder: (BuildContext context) => baseDialog);
}