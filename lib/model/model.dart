class StudentModel {
  int? id;
  final String photo;
  final String name;
  final String course;
  final String number;
  final String age;
  final String location;

  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.course,
    required this.number,
    required this.photo,
    required this.location,
  });

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final course = map['course'] as String;
    final number = map['number'] as String;
    final photo = map['photo'] as String;
    final location = map['location'] as String;
    return StudentModel(
        id: id,
        name: name,
        age: age,
        course: course,
        number: number,
        photo: photo,
        location: location);
  }
}
