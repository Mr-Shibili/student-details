import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app_with_db/model/model.dart';

class StudentProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List<StudentModel> searchresults = [];
  bool isSearch = false;

  String? image;
  late Database db;
  StudentProvider._privateConstructor();
  static final StudentProvider instance = StudentProvider._privateConstructor();

  Future<void> initDataBase() async {
    db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,age TEXT,course TEXT,number TEXT,photo TEXT,location TEXT)');
      },
    );
    getallstudent();
    notifyListeners();
  }

  Future<void> addStudent() async {
    var value = StudentModel(
        name: nameController.text,
        age: ageController.text,
        course: courseController.text,
        number: nameController.text,
        location: locationController.text,
        photo: image!);

    db.rawInsert(
        'INSERT INTO student (name,age,course,number,photo,location)VALUES(?,?,?,?,?,?)',
        [
          value.name,
          value.age,
          value.course,
          value.number,
          value.photo,
          value.location
        ]);

    getallstudent();
    notifyListeners();
  }

  Future<void> getallstudent() async {
    final values = await db.rawQuery("SELECT * FROM student");

    searchresults.clear();

    for (var map in values) {
      final student = StudentModel.fromMap(map);

      searchresults.add(student);
    }
    notifyListeners();
  }

  void edittocontroller(StudentModel student, int id) {
    nameController.text = student.name;
    ageController.text = student.age;
    courseController.text = student.course;
    numberController.text = student.number;
    locationController.text = student.location;
    image = student.photo;

    notifyListeners();
  }

  Future<void> deletestudent(StudentModel student) async {
    await db.rawDelete('DELETE FROM student WHERE id = ?', [student.id]);

    getallstudent();
    notifyListeners();
  }

  Future<void> updatestudent(StudentModel val, id) async {
    log(id.toString());
    Map<String, Object?> values = {
      'id': id,
      'name': nameController.text,
      'age': ageController.text,
      'course': courseController.text,
      'number': numberController.text,
      'location': locationController.text,
      'photo': image
    };

    await db.update(
      'student',
      values,
      where: 'id=?',
      whereArgs: [id],
    );

    await getallstudent();
    notifyListeners();
  }

  void controllerClear() {
    nameController.clear();
    ageController.clear();
    courseController.clear();
    numberController.clear();
    locationController.clear();
    image = null;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? data = await picker.pickImage(source: ImageSource.gallery);
    image = base64Encode(File(data!.path).readAsBytesSync());
    notifyListeners();
  }

  void search(String val) {
    if (val.isEmpty) {
      getallstudent();
      return;
    } else {
      searchresults = searchresults
          .where((element) => element.name.startsWith(val))
          .toList();
    }
    notifyListeners();
  }

  void toggleSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }
}
