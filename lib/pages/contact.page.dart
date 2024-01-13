import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:voyage/menu/drawer.widget.dart';


import '../model/contact.model.dart';
import '../services/contact.service.dart';
import 'ajout_modif_contact.page.dart';

class ContactPage extends StatefulWidget {
  final ContactService contactService = ContactService();

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(), // Ajoute un tiroir de navigation
      appBar: AppBar(
        title: Text("Contacts"), // Titre de la barre d'applications
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: FormHelper.submitButton(
                "Ajout", // Bouton pour ajouter un contact
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AjoutModifContactPage();
                  })).then((value) {
                    setState(() {});
                  });
                },
                borderRadius: 10,
                borderColor: Colors.blue,
                btnColor: Colors.blue,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _fetchData(), // Appel à la méthode pour récupérer les données
          ],
        ),
      ),
    );
  }

  Widget _fetchData() {
    return FutureBuilder<List<Contact>>(
      future: widget.contactService.listeContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.hasData) {
          return _buildDataTable(contacts.data!); // Construction du tableau avec les contacts
        } else if (contacts.hasError) {
          return Center(
            child: Text("Error fetching contacts"), // Affiche une erreur en cas de problème lors de la récupération des contacts
          );
        }
        return Center(
          child: CircularProgressIndicator(), // Affiche un indicateur de chargement en attendant que les données soient chargées
        );
      },
    );
  }

  Widget _buildDataTable(List<Contact> list) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListUtils.buildDataTable(
        context,
        ["Nom", "Téléphone", "Action"], // Colonnes du tableau
        ["nom", "tel", ""],
        false,
        0,
        list,
            (Contact c) {
          // Action lorsque l'utilisateur appuie sur le bouton pour modifier un contact
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjoutModifContactPage(
                modifMode: true,
                contact: c,
              ),
            ),
          ).then((value) {
            setState(() {});
          });
        },
            (Contact c) {
          // Action lorsque l'utilisateur appuie sur le bouton pour supprimer un contact
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Supprimer Contact"),
                content: const Text("Etes vous sûr de vouloir supprimer ce Contact"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormHelper.submitButton(
                        "Oui",
                            () {
                          widget.contactService.supprimerContact(c).then((value) {
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          });
                        },
                        width: 100,
                        borderRadius: 5,
                        btnColor: Colors.green,
                        borderColor: Colors.green,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      FormHelper.submitButton(
                        "Non",
                            () {
                          Navigator.of(context).pop();
                        },
                        width: 100,
                        borderRadius: 5,
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
        headingRowColor: Colors.orange,
        isScrollable: true,
        columnTextFontSize: 20,
        columnTextBold: false,
        columnSpacing: 50,
        onSort: (columnIndex, columnName, asc) {},
      ),
    );
  }
}
