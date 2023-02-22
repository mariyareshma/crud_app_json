class PersonDetails {
  String? name;
  int? age;
  String? id;

  PersonDetails({this.name, this.age}) {
    id = DateTime.now().toString();
  }

  PersonDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    data['id'] = id;
    return data;
  }
}
