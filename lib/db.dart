import 'package:lista_de_tareas/tarea.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class DB{ //metodos y funciones estaticas para que no se pueda instanciar la db
  static Future<Database> _openDB() async{
    return openDatabase(join(await getDatabasesPath(),'tareas.db'), //llamada a la ruta de la bd y el fichero de los datos tareas
        onCreate: (db, version) async{ //si no esta creada la db se ejecuta esto
          return db.execute(
              '''create table tareas (id integer primary key autoincrement not null,titulo text not null,descripcion text not null,foto text null)'''
            //"CREATE TABLE tareas (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, especie TEXT)",
          );
        }, version: 1
    );
  }

  //procedemos al CRUD

  static Future<void> insert(String titulo, String descripcion, String foto) async{
    Database database = await _openDB();
    final data = {'titulo' : titulo, 'descripcion': descripcion, 'foto' : foto};
    database.insert("tareas", data);

    List<Map> list = await database.rawQuery('SELECT * FROM tareas'); // para ver si el registro va bien
    print(list);
    //tarea.id = await database.insert("tareas", tarea.toMap());
    //database.insert("tareas", tarea.toMap()); //insertamos los valores del modelo tarea
  }
  
  static Future<void> delete(Tarea tarea) async{
    Database database = await _openDB();
    database.delete("tareas", where:"id = ?", whereArgs: [tarea.id]); //a borrar donde coincida con el id ? puede que lo cambie dependiende como integre con la UI
    await deleteDatabase(join(await getDatabasesPath(),'tareas.db'));
  }

  static Future<void> update(Tarea tarea) async{
    Database database = await _openDB();
    database.update("tareas", tarea.toMap(), where: "id = ?", whereArgs: [tarea.id]);
    List<Map> list = await database.rawQuery('SELECT * FROM tareas');// para ver si el registro va bien
    print(list);
  }

  static Future<List<Tarea>> tareas() async{
    Database database = await _openDB();
    List<Map<String, dynamic>> tareasMap = await database.query("tareas");

    return List.generate(tareasMap.length, (i){
      return Tarea(
          tareasMap[i]['id'],
          tareasMap[i]['titulo'],
          tareasMap[i]['descripcion'],
          tareasMap[i]['foto']
      );
    });
  }
}