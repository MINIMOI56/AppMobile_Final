import 'package:flutter/material.dart';
import 'package:projet_final_appmobile/src/components/custom_button.dart';
import 'package:projet_final_appmobile/src/components/custom_message.dart';
import 'package:projet_final_appmobile/src/screens/ajout_categorie_screen.dart';
import 'package:projet_final_appmobile/src/data/services/categorie_services.dart';
import 'package:projet_final_appmobile/src/data/entities/categorie_entity.dart';
import 'package:projet_final_appmobile/src/screens/todo_categorie_screen.dart';
import '../data/services/todo_services.dart';

class HomeCategorieScreen extends StatefulWidget {
  HomeCategorieScreen({super.key});

  final dbHelperCategorie = CategorieService();
  final dbHelperTodo = TodoService();

  List<CategorieEntity> categories = [];

  var listIndex;

  @override
  _HomeCategorieScreenState createState() => _HomeCategorieScreenState();
}

class _HomeCategorieScreenState extends State<HomeCategorieScreen> {
  @override
  _loadCategories() async {
    widget.categories = await widget.dbHelperCategorie.getCategories();
    setState(() {});
  }

  Widget build(BuildContext context) {
    /*Je lance la fonction _loadCategories() pour charger les catégories
    *pour preparer la vérification de si il y a des déjà des catégories
    *pour afficher le message d'erreur ou non à la ligne 96
    */
    _loadCategories();
    
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCategorieScreen()),
                          );
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
                  const Padding(
                      padding: EdgeInsets.only(
                        top:100, left: 30, right: 30, bottom: 15),
                      child: Text(
                        'Catégories',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  const Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
                      child: Text(
                        'Ici ce trouve tout vos catégories',
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
                      left: 30, right: 30),
                    child: FutureBuilder(
                        future: widget.dbHelperCategorie.getCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {	
                            _loadCategories();
                          } else {
                            return Center(
                              child: CustomMessage(
                                  text: 'Aucune catégorie trouvée'),
                            );
                          }
                          return ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                  tileColor: const Color.fromARGB(
                                      255, 70, 70, 70),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TodoCategorieScreen(
                                                      categorie: widget
                                                          .categories[index])),
                                        );
                                      },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                      ),
                                  title: Text(widget.categories[index].nom,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Color.fromARGB(255,0,0,0),
                                          size: 30),
                                      onPressed: () {
                                        setState(() {widget.dbHelperTodo
                                              .deleteTodoByCategoryId(
                                                  widget.categories[index].id)
                                              .then((value) {});
                                          widget.dbHelperCategorie
                                              .deleteCategorie(
                                                  widget.categories[index].id)
                                              .then((value) {
                                            widget.categories.removeAt(index);
                                          });
                                        });
                                      }),
                                ));
                                
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
