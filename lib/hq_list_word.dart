import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './hq_counter.dart';
import './hq_deatil.dart';
class HqWordListApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcom to Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blue,
      ),
      home: new RandomWords(),
    );
  }
}
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
      return new RandomWordState();
    }
}
class RandomWordState extends State<RandomWords>{

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();
  
  Widget _buildSuggestions(){

    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){
        if (i.isOdd){
          return new Divider();
        }
        final index = i ~/ 2;
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color:alreadySaved ? Colors.red:null,
      ),
      onTap: (){
        setState(() {
                  if(alreadySaved){
                    _saved.remove(pair);
                  }else{
                    _saved.add(pair);
                  }
                });
      },
    );
  }
  void _detailPage(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          return  HqDetailPage();
        }
      )
    );
  }
  void _counterPage(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          return MyHomePage(title: '计数器');
        }
      )
    );
  }
  void _pushSaved(){
    Navigator.of(context).push(
      
      new MaterialPageRoute(
        builder: (context){
          final tiles = _saved.map(
            (pair){
              return new ListTile(
                title:new Text(pair.asPascalCase,style:_biggerFont),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('已收藏的'),
            ),
            body: new ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }
  @override
    Widget build(BuildContext context) {
      // final wp = new WordPair.random();
      // return new Text(wp.asPascalCase);

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("单词生成器"),
          leading:new IconButton(icon: new Icon(Icons.list) ,iconSize: 40, onPressed: _detailPage,),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.favorite),color: Colors.red,iconSize: 40, onPressed: _pushSaved,),
            new IconButton(icon: new Icon(Icons.add_circle),iconSize: 40, onPressed: _counterPage),
            
          ],
        ),
        body: _buildSuggestions(),
        
      );
    }
}
