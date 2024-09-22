import 'package:database_app/database/user_database.dart';
import 'package:database_app/model/user_model.dart';
import 'package:flutter/material.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({super.key});

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  List<UserModel> listuser = [];
  void getFetchData() async {
    await DatabaseHelper().getUsers().then((value) {
      setState(() {
        listuser = value;
      });
    });
  }

  @override
  void initState() {
    getFetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('STAFF'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: listuser.length,
        itemBuilder: (context, index) => Card(
          color: Colors.pinkAccent,
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person_2_rounded),
            ),
            title: Text(
              listuser[index].name.toString(),
            ),
            subtitle: Text(
              '\$ ${listuser[index].salary.toString()}',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseHelper()
              .insertUser(
                user: UserModel(name: 'Thida', salary: 350),
              )
              .whenComplete(() => getFetchData());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
