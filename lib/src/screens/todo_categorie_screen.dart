import 'package:flutter/material.dart';
import 'package:projet_final_appmobile/src/components/custom_button.dart';
import 'package:projet_final_appmobile/src/components/custom_button_back.dart';
import 'package:projet_final_appmobile/src/components/custom_message.dart';
import 'package:projet_final_appmobile/src/data/services/categorie_services.dart';
import 'package:projet_final_appmobile/src/data/entities/categorie_entity.dart';
import 'package:projet_final_appmobile/src/data/services/todo_services.dart';
import 'package:projet_final_appmobile/src/data/entities/todo_entity.dart';
import 'package:projet_final_appmobile/src/screens/ajout_todo_screen.dart';
import 'package:projet_final_appmobile/src/components/custom_message.dart';

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
  @override
  _loadTodos() async {
    widget.todos = await widget.dbHelperTodo.getTodoByCategorieId(widget.id);
    //Check the "mounted" property of this object before calling "setState()
    if (mounted)
    {
      setState(() {});
    }
  }


  Widget build(BuildContext context) {
    //La même raison que dans la page home_categories_screen.dart
    _loadTodos();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        leading: CustomButtonBack(
            onPressed: () {
              Navigator.pop(context);
            },
            text: '<'),
      ),
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
          padding: const EdgeInsets.all(1),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 15),
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
                          left: 30, right: 30, bottom: 5),
                      child: Text(
                        'Tout vos tâches',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
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
                      left: 30, right: 30, top: 50),
                    child: FutureBuilder(
                      future: widget.dbHelperTodo.getTodoByCategorieId(widget.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            _loadTodos();
                          } else {
                            return Center(
                              child: CustomMessage(
                                text: 'Veuillez ajouter un todo',
                              ),
                            );
                          }
                          return ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.todos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                  tileColor: const Color.fromARGB(
                                      255, 70, 70, 70),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                      ),
                                  leading: Checkbox(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5))),
                                      value: widget.todos[index].isDone == 0 ? false : true,
                                      side: const BorderSide(
                                          color: Color.fromARGB(255, 191, 0, 255), width: 2),
                                      activeColor: const Color.fromARGB(25, 255, 255, 255),
                                      fillColor: MaterialStateProperty.all(
                                          const Color.fromARGB(255, 191, 0, 255)),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          widget.todos[index].isDone = value! == true ? 1 : 0;
                                          widget.dbHelperTodo
                                              .updateTodo(
                                                  widget.todos[index])
                                              .then((value) {});
                                        });
                                      }),
                                  title: Text(widget.todos[index].nom,
                                      style:
                                          TextStyle(color: Colors.white,
                                          decoration: widget.todos[index].isDone == 0 ? TextDecoration.none : TextDecoration.lineThrough)),
                                  subtitle: Text(
                                      widget.todos[index].description,
                                      style:
                                          TextStyle(color: const Color.fromARGB(150, 255, 255, 255),
                                          decoration: widget.todos[index].isDone == 0 ? TextDecoration.none : TextDecoration.lineThrough)),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.black,
                                          size: 30),
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
                                ),
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