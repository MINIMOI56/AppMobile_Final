import 'package:flutter/material.dart';
import 'package:projet_final_appmobile/src/components/custom_button.dart';
import 'package:projet_final_appmobile/src/data/services/categorie_services.dart';
import 'package:projet_final_appmobile/src/data/entities/categorie_entity.dart';
import 'package:projet_final_appmobile/src/data/services/todo_services.dart';
import 'package:projet_final_appmobile/src/data/entities/todo_entity.dart';
import 'package:projet_final_appmobile/src/screens/ajout_todo_screen.dart';

class TodoCategorieScreen extends StatefulWidget {
  final int id;
  final String nom;

  TodoCategorieScreen({required CategorieEntity categorie})
      : id = categorie.id,
        nom = categorie.nom;

        final dbHelperCategorie = CategorieService();

  List<TodoEntity> todos = [];

  var listIndex;

  final dbHelperTodo = TodoService();

  @override
  _TodoCategorieScreenState createState() => _TodoCategorieScreenState();
}

class _TodoCategorieScreenState extends State<TodoCategorieScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 50, 50, 50),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoScreen(categorieid: widget.id)));
                        },
                        text: '+'),
                  ]))),
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 15),
                      child: Text(
                        widget.nom,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  const Padding(
                      padding: EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 15),
                      child: Text(
                        'Vos tâches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                      const Divider(
                      color: Color.fromARGB(255, 70, 70, 70),
                      thickness: 3,
                      indent: 20,
                      endIndent: 20),
                      Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 30, right: 30, bottom: 15),
                    child: FutureBuilder(
                        future: widget.dbHelperTodo.getTodoByCategorieId(widget.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            widget.todos = snapshot.data!;
                          } else {
                            return const Text('Veuillez ajouter une catégorie',
                                style: TextStyle(color: Colors.white));
                          }
                          return ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.todos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  tileColor: const Color.fromARGB(
                                      255, 70, 70, 70),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                      ),
                                  title: Text(widget.todos[index].nom,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.black),
                                      onPressed: () {
                                        setState(() {
                                          widget.dbHelperTodo
                                              .deleteTodo(
                                                  widget.todos[index].id)
                                              .then((value) {
                                            widget.todos.removeAt(index);
                                          });
                                        });
                                      }),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(height: 2));
                        }),
                  )
                ]),
          )),
    );
  }
}