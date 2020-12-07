import 'package:chatapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({
    Key key,
    @required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    return Center(
      child: Container(
        width: size.wScreen(100.0),
        padding: EdgeInsets.only(
          top: size.iScreen(5.0),
        ),
        child: Column(
          children: [
            Image(
                image: AssetImage('assets/imgs/logo.png'),
                width: size.iScreen(15.0)),
            Text(
              this.titulo,
              style: GoogleFonts.roboto(
                  fontSize: size.iScreen(2.5),
                  color: Colors.black87,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
