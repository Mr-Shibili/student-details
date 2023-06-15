import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_app_with_db/controller/provider.dart';

import 'package:student_app_with_db/model/model.dart';

class AddStudentPage extends StatelessWidget {
  AddStudentPage({this.isEdit, this.stdata, this.id});
  final _formKey = GlobalKey<FormState>();
  int? id;
  bool? isEdit;
  StudentModel? stdata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 168, 219),
        title: const Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Consumer<StudentProvider>(builder: (context, provider, _) {
                  return GestureDetector(
                    onTap: () async {
                      await provider.pickImage();
                    },
                    child: CircleAvatar(
                      maxRadius: 90,
                      backgroundImage: provider.image != null
                          ? MemoryImage(base64Decode(provider.image!))
                          : null,
                    ),
                  );
                }),
                TextFormField(
                  controller: context.watch<StudentProvider>().nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter student name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: context.watch<StudentProvider>().ageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter student age',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: context.watch<StudentProvider>().courseController,
                  decoration: const InputDecoration(
                    hintText: 'Enter student course',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter course';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: context.watch<StudentProvider>().numberController,
                  decoration: const InputDecoration(
                    hintText: 'Enter student number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  // keyboardType: TextInputType.number,
                  controller:
                      context.watch<StudentProvider>().locationController,
                  decoration: const InputDecoration(
                    hintText: 'Enter student location',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                Consumer<StudentProvider>(builder: (context, studentData, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (studentData.image == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('please add an image'),
                              backgroundColor: Colors.red,
                            ));
                          }
                          if (isEdit == true) {
                            studentData.updatestudent(stdata!, id);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Edited data ✓'),
                              backgroundColor: Colors.green,
                            ));
                            Navigator.pop(context);
                          } else {
                            studentData.addStudent();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Added student ✓'),
                              backgroundColor: Colors.green,
                            ));
                            studentData.controllerClear();
                          }
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
