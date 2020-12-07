import 'package:chatapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotonAzul extends StatelessWidget {
  const BotonAzul({
    Key key,
    @required this.emailController,
    @required this.passwordController,
    @required this.size,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Responsive size;

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed,
      child: Container(
        width: size.wScreen(100.0),
        height: size.hScreen(5.5),
        child: Center(
          child: Text(
            this.label,
            style: GoogleFonts.roboto(
                fontSize: size.iScreen(2.0),
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
