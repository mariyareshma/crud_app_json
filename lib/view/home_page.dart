import 'package:crud_app_json/model/person_model.dart';
import 'package:crud_app_json/view/person_widget.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import '../data/json_file.dart';
import 'add_edit_Person.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<PersonDetails?> addEditPerson(PersonDetails? person) async {
    return await showDialog<PersonDetails?>(
        context: context,
        builder: (context) {
          return Dialog(
            child: AddEditPerson(
              person: person,
            ),
          );
        });
  }

  Future<bool?> showConfirmation(PersonDetails? item) async {
    return await showDialog<bool?>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Are You Sure Wants to Delete'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Ok')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }

  List<PersonDetails> filteredList = <PersonDetails>[];
  List<PersonDetails> originalList = <PersonDetails>[];

  var searchPerson = '';

  Future getDataFromPath() async {
    originalList = await readAllFile();
  }

  Future<List<PersonDetails>> filterResults() async {
    await getDataFromPath();

    filteredList = originalList
        .where((element) =>
            element.name!.contains(searchPerson) ||
            element.age!.toString().contains(searchPerson))
        .toList();

    return filteredList;
  }

  List<String> getSuggestions() {
    var suggestion = <String>[];
    for (var item in originalList) {
      if (suggestion.contains(item.name) == false) suggestion.add(item.name!);
    }
    return suggestion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Crud Search'),
        suggestionTextStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        suggestions: getSuggestions(),
        onSearch: (value) async {
          searchPerson = value;

          await filterResults();
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newPerson = await addEditPerson(null);
          if (newPerson != null) {
            await addToPerson(newPerson);
            filterResults();
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;

            return ListView(
              children: getPersonWidgets(data!),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: filterResults());
  }

  List<Widget> getPersonWidgets(List<PersonDetails> persons) {
    return persons
        .map((e) => GestureDetector(
              onLongPress: () async {
                var canDelete = await showConfirmation(e);
                if (canDelete != null && canDelete) {
                  await deleteFromPerson(e);
                  filterResults();
                  setState(() {});
                }
              },
              onTap: () async {
                var newPerson = await addEditPerson(e);
                if (newPerson != null) {
                  await editPerson(newPerson);
                  filterResults();
                  setState(() {});
                }
              },
              child: PersonWidget(person: e),
            ))
        .toList();
  }

  Widget searchBar() {
    return SizedBox(
      height: 40,
      child: EasySearchBar(
        appBarHeight: 40,
        title: const Text('Crud Search'),
        //suggestions: getSuggestions(),
        onSearch: (value) async {
          searchPerson = value;

          await filterResults();
          setState(() {});
        },
      ),
    );
  }
}
