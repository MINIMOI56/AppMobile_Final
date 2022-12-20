import 'package:flutter/material.dart';
import 'package:projet_final_appmobile/src/components/custom_button.dart';
import 'package:projet_final_appmobile/src/screens/ajout_categorie_screen.dart';
import 'package:projet_final_appmobile/src/data/services/categorie_services.dart';
import 'package:projet_final_appmobile/src/data/entities/categorie_entity.dart';

class HomeCategorieScreen extends StatefulWidget {
  HomeCategorieScreen({super.key});

  final dbHelper = CategorieService();

  List<CategorieEntity> categories = [];

  var listIndex;

  @override
  _HomeCategorieScreenState createState() => _HomeCategorieScreenState();
}

class _HomeCategorieScreenState extends State<HomeCategorieScreen> {
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
                          top: 20, left: 30, right: 30, bottom: 15),
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
                        top: 20, left: 30, right: 30, bottom: 15),
                    child: FutureBuilder(
                        future: widget.dbHelper.getCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            widget.categories = snapshot.data!;
                          } else {
                            return const Text('Veuillez ajouter une catégorie',
                                style: TextStyle(color: Colors.white));
                          }
                          return ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  tileColor: const Color.fromARGB(
                                      255, 70, 70, 70),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(widget.categories[index].nom,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.black),
                                      onPressed: () {
                                        setState(() {
                                          widget.dbHelper
                                              .deleteCategorie(
                                                  widget.categories[index].id)
                                              .then((value) {
                                            widget.categories.removeAt(index);
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
