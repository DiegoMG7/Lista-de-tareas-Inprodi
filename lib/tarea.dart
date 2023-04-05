class Tarea{
  int id;
  String titulo;
  String descripcion;
  String foto;


  Tarea(this.id, this.titulo, this.descripcion, this.foto);

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'nombre' : titulo,
      'especie' : descripcion,
      'foto' : foto
    };
  }
}