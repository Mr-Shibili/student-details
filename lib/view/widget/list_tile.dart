import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_with_db/model/model.dart';
import 'package:student_app_with_db/view/add_page.dart';

import '../../controller/provider.dart';

class ListTiles extends StatelessWidget {
  ListTiles({
    super.key,
    required this.student,
    this.index,
  });
  List<StudentModel> student = [];
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(builder: (context, provider, _) {
      return ListTile(
        leading: CircleAvatar(
            backgroundImage: MemoryImage(base64Decode(student[index!].photo))),
        //trailing: Text(student[index!].id!.toString()),
        title: Row(
          children: [
            Text(student[index!].name),
            const Spacer(),
            IconButton(
                onPressed: () {
                  provider.edittocontroller(
                      student[index!], student[index!].id!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStudentPage(
                            isEdit: true,
                            stdata: student[index!],
                            id: student[index!].id!),
                      ));
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  provider.deletestudent(
                    student[index!],
                  );
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      );
    });
  }
}
