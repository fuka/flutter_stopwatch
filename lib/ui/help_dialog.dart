import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  final _content = """
  ・タップ：
  　　オン／オフの切り替え
  
  ・ロングタップ：
  　　リセット
  """;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("使い方"),
      content: Text(_content),
      actions: <Widget>[
        FlatButton(
          child: const Text('閉じる'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
