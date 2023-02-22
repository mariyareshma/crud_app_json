class Autogenerated {
  String? name;
  int? age;
  String? id;

  Autogenerated({this.name, this.age}) {
    id = DateTime.now().toString();
  }

  Autogenerated.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    return data;
  }
}