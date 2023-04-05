import 'dart:core';
import 'package:lista_de_tareas/tarea.dart';
import 'package:lista_de_tareas/db.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_tareas/Presentation/Screens/nueva_tarea.dart';
import 'package:image_picker/image_picker.dart';
import 'nueva_tarea.dart';

//void main() => runApp(const BottomSheetApp());

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedNavBarIndex = 0; //para el bottomnavbar

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true
      ),
      home: Scaffold(
        appBar: AppBar(title:const Center(child:Text('Home'))),
        body: const ListadoTareas(),
        floatingActionButton: FloatingActionButton( //de acuerdo a la documentacion de flutter esta es la mejor manera de hace run embed de un floatingactionbutton
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: (){
            Navigator.pushNamed(context,"/editar_tarea",arguments: Tarea(0,"","",""));//id titulo descripcion
          },
          //backgroundColor: Colors.white,
          child: const Icon(Icons.add_sharp, size:40),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedNavBarIndex,
          onTap: (newIndex){
            setState(() {
              selectedNavBarIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long,size: 40,),
              //activeIcon: const Icon(Icons.person_3),
              label: '',
              backgroundColor:colors.primary,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.check_sharp, size: 40,),
              //activeIcon: const Icon(Icons.person_3),
              label: '',
              backgroundColor:colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class ListadoTareas extends StatefulWidget {
  const ListadoTareas({Key? key}) : super(key: key);

  @override
  State<ListadoTareas> createState() => _ListadoTareasState();
}

class _ListadoTareasState extends State<ListadoTareas> {

  List<Tarea> tareas = [];

  @override
  void initState(){
    cargaTareas();
    super.initState();
  }

  cargaTareas() async{
    List<Tarea> auxTarea = await DB.tareas();

    setState(() {
      tareas = auxTarea;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tareas.length,
        itemBuilder:
            (context, i) =>
        Dismissible(key: Key(i.toString()),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.red,
            padding: const EdgeInsets.only(left: 5),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
          onDismissed: (direction){
          DB.delete(tareas[i]);
          },
          child: Center(
            child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: SizedBox(
                width: 380,
                height: 180,
                child: ListTile(
                  title: Text(tareas[i].titulo),
                  trailing: MaterialButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NuevaTarea(),
                            settings: RouteSettings(
                              arguments: tareas[i],
                            )
                          ),
                      );
                    },
                    /*onPressed: (){
                      Navigator.pushNamed(context,"/editar_tarea",arguments: tareas[i]);
                      //Navigator.pushNamed(context,"/editar_tarea",arguments: Tarea(0,"",""));
                    },*/
                    child: const Icon(Icons.edit),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}

class EliminarTarea extends StatelessWidget {
  const EliminarTarea({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

