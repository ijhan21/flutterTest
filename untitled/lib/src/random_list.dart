import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:untitled/src/bloc/Bloc.dart';

import 'saved.dart';

// ctrl alt L => 커맨드 정리
class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RandomListState();
  }
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: const Text("naming app"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                bloc.savedStream;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>SavedList(saved: _saved))
                );
              })
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      //0, 2, 4, 6, 8 ... : real items
      //1, 3, 5, 7, 9 ... : dividers // 구분선도 아이템임
      if (index.isOdd) {
        return const Divider();
      }

      var realIndex = index ~/ 2;

      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[realIndex]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair); //saved 안에 pair가 있는지

    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onTap: () {
        setState(() {
          if (alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);
          // print(pair.asPascalCase);
          // print(_saved.toString());
          // print(alreadySaved.toString());
          //
        });
      },
    );
  }
}
