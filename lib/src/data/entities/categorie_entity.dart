import 'package:projet_final_appmobile/src/data/entities/todo_entity.dart';

class CategorieEntity {
  final int id;
  final String nom;

  CategorieEntity(this.id, this.nom);

  static CategorieEntity FromMap(Map<String, dynamic> map) {
    var entity = CategorieEntity(map['id'], map['nom']);
    return entity;
  }

  Map<String, dynamic> toMap() {
    return {'nom': nom};
  }

  @override
  String toString() {
    return 'categorieEntity{id: $id, nom: $nom}';
  }
}
