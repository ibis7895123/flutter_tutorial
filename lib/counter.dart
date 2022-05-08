import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: Counter(),
      ),
    ),
  ));
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({required this.count, Key? key}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  const CounterIncrementor({required this.onPressed, Key? key})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  // このクラスは、State の設定です。
  // 親から提供され、ステートのビルドメソッドで使用される値 (この場合は何もない) を保持します。
  // Widgetのサブクラスのフィールドは、常に final とマークされます。
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // このsetStateの呼び出しは、
      // FlutterフレームワークにこのStateで何かが変更されたことを伝え、
      // 以下のbuildメソッドを再実行させ、
      // ディスプレイに更新された値を反映させることができるようにします。
      // もしsetState()を呼ばずに_counterを変更した場合、
      // buildメソッドは再度呼ばれないので、何も起こらないように見えます。
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // このメソッドは、例えば上記の_incrementメソッドで行われるように、
    // setStateが呼ばれるたびに再実行されます。
    // Flutter フレームワークは、ビルドメソッドの再実行を高速化するように最適化されています。
    // そのため、ウィジェットのインスタンスを個別に変更するのではなく、
    // 更新が必要なものを再構築すればよいのです。
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CounterIncrementor(onPressed: _increment),
        const SizedBox(width: 16),
        CounterDisplay(count: _counter),
      ],
    );
  }
}
