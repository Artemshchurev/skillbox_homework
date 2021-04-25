import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  TodoView({Key key}) : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TextEditingController _textController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference _todos = FirebaseFirestore.instance.collection('todos');

  void _saveTodo() async {
    DocumentReference ref = await _todos.add({
      'title': _textController.text,
      'isDone': false,
    });
    print(ref);
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _saveTodo();
      _formKey.currentState.reset();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                      labelText: 'Новая Задача'
                  ),
                  validator: (value) {
                    return value == ''
                        ? 'Введите текст'
                        : null;
                  },
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Создать'),
                )
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('todos').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());

                  return ListView(
                    children: <Widget>[
                      if (snapshot.hasData)
                        ...snapshot.data.docs
                            .map((todo) => ListTile(
                          title: Text(todo['title']),
                          leading: Text('${todo['isDone']}'),
                        )).toList()
                    ],
                  );
                },
              )
          )
        ],
      ),
    );
  }
}