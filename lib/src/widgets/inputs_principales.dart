import 'package:chatapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';


class InputsPrincipales extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool autocorrect;

  const InputsPrincipales({
    Key key,
    @required this.icon,
    @required this.placeholder,
    @required this.textController,
     this.keyboardType: TextInputType.text,
     this.isPassword: false,
    @required this.autocorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(top: size.iScreen(2.0)),
      padding: EdgeInsets.only(
          top: size.iScreen(0.1),
          left: size.iScreen(0.1),
          bottom: size.iScreen(0.1),
          right: size.iScreen(2.0)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.iScreen(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5,
          )
        ],
      ),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder,
        ),
      ),
    );
  }
}
