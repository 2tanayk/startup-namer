import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

// The app extends StatelessWidget, which makes the app itself a widget.
// In Flutter, almost everything is a widget, including alignment, padding, and layout.
// Stateless widgets are immutable, meaning that their properties can’t change—all values are final.
class MyApp extends StatelessWidget {
  //A widget’s main job is to provide a build() method
  // that describes how to display the widget in terms of other,lower level widgets.
  @override
  Widget build(BuildContext context) {
    //An application that uses material design.
    //A convenience widget that wraps a number of widgets that are commonly required for
    // material design applications
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

//Stateful widgets maintain state that might change during the lifetime of the widget.
// Implementing a stateful widget requires at least two classes:
// 1) a StatefulWidget class that creates an instance of
// 2) a State class. 
//The StatefulWidget class is, itself,immutable and can be thrown away and regenerated,
//but the State class persists over the lifetime of the widget.
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  //This method builds the ListView that displays the suggested word pairing.
  Widget _buildSuggestions() {
    //The ListView class provides a builder property, itemBuilder,
    //that’s a factory builder and callback function specified as an anonymous function.
    //Two parameters are passed to the function—the BuildContext,
    //and the row iterator, i. 
    //The iterator begins at 0 and increments each time the function is called. 
    //It increments twice for every suggested word pairing: once for the ListTile, and once for the Divider. 
    //This model allows the suggested list to continue growing as the user scrolls.
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          //The expression i ~/ 2 divides i by 2 and returns an integer result.
          //This calculates the actual number of word pairings in the ListView, minus the divider widgets.
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            //If you’ve reached the end of the available word pairings, 
            //then generate 10 more and add them to the suggestions list.
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    //The Scaffold widget, from the Material library, provides a default app bar,
    // and a body property that holds the widget tree for the home screen.
    // The widget subtree can be quite complex.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}
