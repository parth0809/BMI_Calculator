import 'package:flutter/cupertino.dart';

class IconContext extends StatelessWidget {
  final String str;
  final IconData icon;
  IconContext(this.str, this.icon)
  {
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          str,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF8d8e98),
          ),
        )
      ],
    );
  }
}
