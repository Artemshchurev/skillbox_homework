import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/services/auth_service.dart';
import 'package:firebase_project/views/profile_view.dart';
import 'package:flutter/material.dart';

class TodosView extends StatefulWidget {
  static const String routeName = '/todos';

  TodosView({Key key}) : super(key: key);

  @override
  _TodosViewState createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CollectionReference _todos = FirebaseFirestore.instance.collection('todos');
  final AuthService _authService = AuthService();

  void _saveTodo() async {
    await _todos.add({
      'title': _textController.text,
      'isDone': false,
    });
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _saveTodo();
      _formKey.currentState.reset();
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void _setIsDone(String id, bool isDone) {
    _todos.doc(id).update({'isDone': isDone});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            ListTile(
              leading: Text('Профиль'),
              onTap: () {
                Navigator.of(context).pushNamed(ProfileView.routeName);
              },
            ),
            ListTile(
              leading: Text('Выйти'),
              onTap: _authService.signOut,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'Новая Задача'),
                  validator: (value) {
                    return value == '' ? 'Введите текст' : null;
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
            stream: _todos.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());

              return ListView(
                children: <Widget>[
                  if (snapshot.hasData)
                    ...snapshot.data.docs
                        .map((todo) => Dismissible(
                            key: Key(todo.id),
                            background: Container(
                              color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  'Удалить',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              _todos.doc(todo.id).delete();
                            },
                            child: ListTile(
                              title: Text(todo['title']),
                              trailing: Checkbox(
                                onChanged: (bool value) {
                                  _setIsDone(todo.id, value);
                                },
                                value: todo['isDone'],
                              ),
                            ),
                          ))
                        .toList()
                ],
              );
            },
          ))
        ],
      ),
    );
  }
}
