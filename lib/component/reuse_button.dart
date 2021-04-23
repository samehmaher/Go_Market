import 'package:flutter/material.dart';
import 'package:go_market/component/style.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.buttonName,
    this.onPress,
  }) : super(key: key);

  final String buttonName;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: onPress,
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}