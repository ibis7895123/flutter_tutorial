import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // itemBuilder コールバックは、単語の組み合わせの suggest ごとに1回呼び出され、
      // 各 suggest を ListTile の行に配置します。
      // 偶数行の場合、この関数は、単語の組み合わせのための ListTile 行を追加します。
      // 奇数列の場合は、エントリを視覚的に分離するための Divider Widget が追加されます。
      // なお、小さな端末では、この区切り線が見にくくなる場合があります。
      itemBuilder: (context, i) {
        // ListView の各行の前に、高さ 1 ピクセルの仕切り Widget を追加します。
        if (i.isOdd) return const Divider();

        // i ~/ 2 という式は i を 2 で割って整数の結果を返します。
        // 例えば、1, 2, 3, 4, 5 は 0, 1, 1, 2, 2 になります。
        // これは、ListView の単語ペアの実際の数を計算し、Divider Widget を除いたものです。
        final index = i ~/ 2;

        // もし、利用可能な単語の組み合わせが終了したら、
        // さらに10個の単語を生成して候補リストに追加します。
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}
