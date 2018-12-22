import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  final String content = """
  ・タップ：
  　　オン／オフの切り替え
  
  ・ロングタップ：
  　　リセット
  """;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("使い方"),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text('閉じる'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
