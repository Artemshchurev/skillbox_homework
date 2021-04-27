import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/models/todo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TodoView extends StatelessWidget {
  static const String routeName = '/todo';

  final String id;

  TodoView(this.id);
  final CollectionReference _todos = FirebaseFirestore.instance.collection('todos');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _todos.doc(id).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        }

        Map<String,dynamic> todo = snapshot.data.data();

        return Scaffold(
          appBar: AppBar(
            title: Text(todo['title']),
          ),
          body: Column(

          ),
        );
      }
    );
  }
}
