import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_with_db/controller/provider.dart';
import 'package:student_app_with_db/model/model.dart';
import 'package:student_app_with_db/view/add_page.dart';
import 'package:student_app_with_db/view/widget/list_tile.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  //final String title;

  int? stindex;
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(builder: (context, provdr, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 139, 153, 226),
          title: provdr.isSearch
              ? TextField(
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      provdr.toggleSearch();
                      provdr.getallstudent();
                    },
                  )),
                  onChanged: (value) {
                    provdr.search(value);
                  },
                )
              : const Text('Student app'),
          automaticallyImplyLeading: true,
          actions: [
            Visibility(
              visible: !provdr.isSearch,
              child: IconButton(
                onPressed: () {
                  provdr.toggleSearch();
                },
                icon: const Icon(Icons.search),
              ),
            )
          ],
          centerTitle: true,
        ),
        body: SafeArea(
            child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: provdr.searchresults.length,
          itemBuilder: (context, index) {
            stindex = index;

            return ListTiles(
              student: provdr.searchresults,
              index: index,
            );
          },
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Provider.of<StudentProvider>(context, listen: false)
                  .controllerClear();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentPage(),
                  ));
            },
            child: const Icon(Icons.add)),
      );
    });
  }
}
