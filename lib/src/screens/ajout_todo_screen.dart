import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projet_final_appmobile/src/components/custom_button.dart';
import 'package:projet_final_appmobile/src/components/custom_button_ajouter.dart';
import 'package:projet_final_appmobile/src/components/custom_button_annuler.dart';
import 'package:projet_final_appmobile/src/data/services/todo_services.dart';
import 'package:projet_final_appmobile/src/data/services/categorie_services.dart';
import 'package:projet_final_appmobile/src/data/entities/categorie_entity.dart';
import 'package:projet_final_appmobile/src/data/entities/todo_entity.dart';


class AddTodoScreen extends StatefulWidget {
  final int categorieId;

  AddTodoScreen({required int categorieid})
      : categorieId = categorieid;

      final dbHelperCategorie = CategorieService();

  Random randomInstance = Random();
  String todoExists = '';

  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final dbHelperTodo = TodoService();

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  /*
  * This function is called when the user clicks the "Validate" button.à
  * It will check if the score exist (random) if field are not empty.
  */
  void _showIsTodoExist() {
    if (widget.nomController.text != '' &&
        widget.descriptionController.text != '') {
      setState(() {
        widget.todoExists =
            (widget.randomInstance.nextDouble() > .5).toString();
      });

      TodoEntity todo = TodoEntity(
          0, widget.categorieId , widget.nomController.text, widget.descriptionController.text);

      print('Todo: ' + todo.toString());
      print('categorieId: ' + widget.categorieId.toString());

      try {
        widget.dbHelperTodo.insertTodo(todo);
      } catch (e) {
        print('Error: ' + e.toString());
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.nomController.dispose();
    widget.descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  const Padding(
                      padding: EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 15),
                      child: Text(
                        'Ajout de Todo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  const Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
                      child: Text(
                        'Ici vous pouvez ajouter un todo',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      )),
                  const Divider(
                      color: Color.fromARGB(255, 70, 70, 70),
                      thickness: 3,
                      indent: 20,
                      endIndent: 20),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 30, right: 30, bottom: 15),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            controller: widget.nomController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple),
                              ),
                              hintText: 'Nom du todo',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ))),
                          Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 30, right: 30, bottom: 15),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            controller: widget.descriptionController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple),
                              ),
                              hintText: 'Description du todo',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 30, right: 30, bottom: 15),
                      child: Row(children: [
                        CustomButtonAnnuler(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Annuler'),
                        const Spacer(),
                        CustomButtonAjouter(
                            onPressed: () {
                              _showIsTodoExist();
                              print("Todo ajoutée");
                              Navigator.pop(context, {});
                            },
                            text: 'Ajouter')
                      ]))
                ]))));
  }
}
