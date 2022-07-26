import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'todo.dart';

class ClearListApp extends StatefulWidget {
  Future<Database> database;

  ClearListApp(this.database);

  @override
  State<ClearListApp> createState() => _ClearListAppState();
}

class _ClearListAppState extends State<ClearListApp> {
  Future<List<Todo>>? clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('완료한 일'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Text(todo.content!),
                                Container(
                                  height: 1,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  }else{return Text('No data');}

                default:
                  return CircularProgressIndicator();
              }
            },
          future: clearList,),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('완료한 일 삭제'),
              content: Text('완료한 일을 모두 삭제할까요?'),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop(true);
                }, child: Text('예')),
                TextButton(onPressed: (){
                  Navigator.of(context).pop(false);
                }, child: Text('아니오'))
              ],
            );
          });
          if (result==true){
            _removeAllTodos();
          }
        },
        child: Icon(Icons.remove),
      ),
    );
  }

  void _removeAllTodos() async {
    final Database database = await widget.database;
    database.rawDelete('delete from todos where active =1');
    setState((){
      clearList = getClearList();
    });
  }

  Future<List<Todo>> getClearList() async {
    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database
        .rawQuery('select title, content, id from todos where active=1');
    return List.generate(maps.length, (i) {
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          id: maps[i]['id']);
    });
  }
}
