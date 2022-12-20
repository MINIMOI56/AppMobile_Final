class TodoEntity {
  final int id;
  final int categorieId;
  final String nom;
  final String description;

  TodoEntity(this.id, this.categorieId , this.nom, this.description);

  static TodoEntity FromMap(Map<String, dynamic> map) {
    var entity = TodoEntity(map['id'], map['categorieId'] , map['nom'], map['description']);
    return entity;
  }

  Map<String, dynamic> toMap() {
    return {'categorieId':categorieId, 'nom': nom, 'description': description};
  }

  @override
  String toString() {
    return 'todoEntity{id: $id, categorieId: $categorieId nom: $nom, description: $description}';
  }
}
