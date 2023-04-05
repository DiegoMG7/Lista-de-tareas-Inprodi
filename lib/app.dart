import 'package:flutter/material.dart';
import 'package:lista_de_tareas/Presentation/Screens/home.dart';
import 'package:lista_de_tareas/Presentation/Screens/nueva_tarea.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppRouted(),
      //home: Home(),
    );
  }
}

class MyAppRouted extends StatelessWidget {
  const MyAppRouted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true
      ),
      initialRoute: "/",
      routes: {
        "/" : (context) => const Home(),
        "/editar_tarea": (context) => NuevaTarea()
      }
    );
  }
}

