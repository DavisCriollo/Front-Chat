import 'package:chatapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;
  const ChatMessage({
    Key key,
    this.texto,
    this.uid,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut
        ),
              child: Container(
          child: this.uid == '123' ? _myMessage(size) : _notMessage(size),
        ),
      ),
    );
  }

  Widget _myMessage(Responsive size) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.iScreen(1.5), vertical: size.iScreen(0.5)),
        margin: EdgeInsets.only(
          bottom: size.iScreen(0.3),
          left: size.iScreen(10.0),
          right: size.iScreen(0.5),
        ),
        child: Text(
          this.texto,
          style: GoogleFonts.roboto(
              fontSize: size.iScreen(1.5),
              color: Colors.white,
              fontWeight: FontWeight.normal),
        ),
        decoration: BoxDecoration(
            color: Color(0xFF4D9EF6),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            )),
      ),
    );
  }

  Widget _notMessage(Responsive size) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.iScreen(1.5), vertical: size.iScreen(0.5)),
        margin: EdgeInsets.only(
          bottom: size.iScreen(0.3),
          left: size.iScreen(0.5),
          right: size.iScreen(10.0),
        ),
        child: Text(
          this.texto,
          style: GoogleFonts.roboto(
              fontSize: size.iScreen(1.5),
              color: Colors.black,
              fontWeight: FontWeight.normal),
        ),
        decoration: BoxDecoration(
            color: Color(0xFFE4E5E8),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            )),
      ),
    );
  }
}
