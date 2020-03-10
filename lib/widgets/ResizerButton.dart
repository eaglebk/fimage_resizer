import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResizerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool state;

  const ResizerButton({Key key, this.onPressed, this.title, this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      color: Theme.of(context).primaryColor,
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: state ? onPressed : null,
    );
  }
}
