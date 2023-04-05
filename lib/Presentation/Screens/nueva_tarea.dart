import 'package:lista_de_tareas/db.dart';
import 'package:lista_de_tareas/tarea.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_tareas/image_helper.dart';

final imageHelper = ImageHelper();

class NuevaTarea extends StatefulWidget {
  const NuevaTarea({Key? key}) : super(key: key);

  @override
  State<NuevaTarea> createState() => _NuevaTareaState();
}

class _NuevaTareaState extends State<NuevaTarea> {

  var _imageBase64;

  io.File? _image;

  final _formKey = GlobalKey<FormState>();
 //para validar el form
  final tituloController = TextEditingController();

  final descripcionController = TextEditingController();

  String fotoController = "";

  //final fotoController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //Tarea tarea = ModalRoute.of(context).settings.arguments; inicialmente iba a usar esta sentencia pero quiero creer que ya no es aceptada
    //final args = ModalRoute.of(context)!.settings.arguments as Tarea;  esta sentencia es la que se muestra en la documentacion pero la de abajo igual me la acepto entonces espero este bien
    //Tarea tarea = ModalRoute.of(context)!.settings.arguments as Tarea;
    final tarea = ModalRoute.of(context)!.settings.arguments as Tarea; // esta es la buena
    tituloController.text = tarea.titulo;
    descripcionController.text = tarea.descripcion;
    fotoController = tarea.foto;


    return Scaffold(
      appBar: AppBar(title:const Center(child:Text('Nueva Tarea'))),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 70,
                      foregroundImage: _image != null ? FileImage(_image!) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () async{
                          final files = await imageHelper.pickImage();
                          if(files != null){
                            setState(() => _image = io.File(files.path));
                          }
                          fotoController = imageHelper.sendBase64();
                          print("AAAAAAAAAAAAAAAAAAAAAAAA");
                          //print(files.path);
                          print(fotoController);
                          print(fotoController);
                          print(fotoController);
                          //print(fotoController);
                          print("CCCCCCCCCCCCCCCCCCCCCCC");
                        },
                        elevation: 2.0,
                        fillColor: const Color(0xFFF5F6F9),
                        padding: const EdgeInsets.all(15.0),
                        shape: const CircleBorder(),
                        child: const Icon(Icons.camera_alt_outlined, color: Colors.blue,),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: tituloController,
                  validator: (value){
                    if ( value!.isEmpty){//hay que probarlo
                      return "El titulo es obligatorio";
                    }
                    else{
                      return null;
                    }
                  },
                decoration: const InputDecoration(
                    labelText: "Titulo"
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descripcionController,
                validator: (value){
                  if (value!.isEmpty){//hay que probarlo
                    return "La descripcion es obligatoria";
                  }
                  else{
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Descripcion"
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()){ //por probar
                      if(tarea.id > 0){
                        tarea.titulo = tituloController.text;
                        tarea.descripcion = descripcionController.text;
                        tarea.foto = fotoController;
                        DB.update(tarea);
                      }
                      else{
                        print(fotoController);
                        print(fotoController);
                        print(fotoController);
                        print("PPPPPPPPPPPPPPPPPPPPP");
                        DB.insert(tituloController.text, descripcionController.text,fotoController);
                        //DB.insert(tarea);
                      }
                      Navigator.pushNamed(context,"/");
                    }
                  },
                  child: const Text("Guardar")
              )
            ],
          ),
        ),
      )
    );
  }
}

