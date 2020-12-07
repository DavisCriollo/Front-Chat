import 'package:chatapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Labels extends StatelessWidget {
  const Labels({
    @required this.size,
    @required this.ruta,
    @required this.titulo,
    @required this.action,
  });

  final Responsive size;
  final String ruta;
  final String titulo;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.titulo,
            style: GoogleFonts.roboto(
                fontSize: size.iScreen(2.0),
                color: Colors.black54,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: size.iScreen(2.0),
          ),
          GestureDetector(
            child: Text(
              this.action,
              style: GoogleFonts.roboto(
                  fontSize: size.iScreen(2.0),
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
          ),
        ],
      ),
    );
  }
}
