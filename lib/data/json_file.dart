import 'dart:convert';
import 'dart:io';
import 'package:crud_app_json/model/person_model.dart';
import 'package:path_provider/path_provider.dart';

const String personDetail = 'personDetails.json';

//get full file path
Future<String> getFullFilePath() async {
  var appDir = (await getApplicationDocumentsDirectory()).path;
  return '$appDir\\$personDetail';
}

Future<List<PersonDetails>> readAllFile() async {
  var fullFilePath = await getFullFilePath();
  var items = <PersonDetails>[];

//read file
  var file = File(fullFilePath);
  if (!file.existsSync()) return items;

  var fileContents = file.readAsStringSync();

  var jsonFile = jsonDecode(fileContents);

  for (var jsonItem in jsonFile) {
    var itemObj = PersonDetails.fromJson(jsonItem);
    items.add(itemObj);
  }
  return items;
}

Future writePersonToFile(List<PersonDetails> files) async {
  var json = [];
  for (var file in files) {
    var itemJson = file.toJson();
    json.add(itemJson);
  }
  var jsonString = jsonEncode(json);
  var fullFilePath = await getFullFilePath();
  var file = File(fullFilePath);

  file.writeAsStringSync(jsonString, mode: FileMode.write, flush: true);
}

//create a function to add a learning to the list
Future addToPerson(PersonDetails fileObj) async {
  var listofPerson = await readAllFile();
  listofPerson.add(fileObj);
  await writePersonToFile(listofPerson);
}

//create a function to delete Person from the list
Future deleteFromPerson(PersonDetails fileObj) async {
  var listofPerson = await readAllFile();
  listofPerson.removeWhere((element) => element.id == fileObj.id);
  await writePersonToFile(listofPerson);
}

//create a function to edit a Person list
Future editPerson(PersonDetails fileObj) async {
  var listofPerson = await readAllFile();
  var index = listofPerson.indexWhere((element) => element.id == fileObj.id);
  listofPerson[index] = fileObj;
  await writePersonToFile(listofPerson);
}
