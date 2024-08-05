class Model {

  final int idModel;
  final String marca;
  final String modelo;
  final double capacidadAgua;
  final String tipo;

  Model({
    required this.idModel,
    required this.marca,
    required this.modelo,
    required this.capacidadAgua,
    required this.tipo,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      idModel: json['id_modelo'],
      marca: json['marca'],
      modelo: json['modelo'],
      capacidadAgua: json['capacidadAgua'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_model': idModel,
      'marca': marca,
      'modelo': modelo,
      'capacidadAgua': capacidadAgua,
      'tipo': tipo,
    };
  }
}