import 'package:crud_app_json/model/person_model.dart';
import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({Key? key, this.person}) : super(key: key);
  final PersonDetails? person;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Name:${person!.name!}'),
        subtitle: Text('Age:${person!.age!.toString()}'));
  }
}
