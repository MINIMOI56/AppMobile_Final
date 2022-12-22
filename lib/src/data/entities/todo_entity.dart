class TodoEntity {
  final int id;
  final int categorieId;
  final String nom;
  final String description;
  int isDone;

  TodoEntity(this.id, this.categorieId , this.nom, this.description, this.isDone);

  static TodoEntity FromMap(Map<String, dynamic> map) {
    var entity = TodoEntity(map['id'], map['categorieId'] , map['nom'], map['description'], map['isDone']);
    return entity;
  }

  Map<String, dynamic> toMap() {
    return {'categorieId':categorieId, 'nom': nom, 'description': description, 'isDone': isDone};
  }

  @override
  String toString() {
    return 'todoEntity{id: $id, categorieId: $categorieId nom: $nom, description: $description, isDone: $isDone}';
  }
}
