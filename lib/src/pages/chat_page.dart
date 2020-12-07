import 'dart:io';

import 'package:chatapp/src/utils/responsive.dart';
import 'package:chatapp/src/widgets/mensaje_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _inputTextChat = new TextEditingController();

  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;

  List<ChatMessage> _message = [
// ChatMessage(uid: '123',texto: 'Hola Mundo dahsdjkhak',),
// ChatMessage(uid: '159',texto: 'Hola ',),
// ChatMessage(uid: '129',texto: ' como estas',),
// ChatMessage(uid: '14',texto: 'Hola bien',),
// ChatMessage(uid: '123',texto: ' si',),
// ChatMessage(uid: '45',texto: 'Hola chao',),
// ChatMessage(uid: '123',texto: 'bueno',),
  ];

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              child: Text('Te',
                  style: GoogleFonts.roboto(
                      fontSize: size.iScreen(2.0),
                      color: Colors.black54,
                      fontWeight: FontWeight.normal)),
              backgroundColor: Colors.blue[100],
            ),
            Container(
              margin: EdgeInsets.only(left: size.iScreen(2.0)),
              child: Text('Teodoro Quiñonez',
                  style: GoogleFonts.roboto(
                      fontSize: size.iScreen(2.0),
                      color: Colors.black54,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _message.length,
                itemBuilder: (_, i) => _message[i],
                reverse: true,
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat(Responsive size) {
    return SafeArea(
      child: Container(
        margin:
            EdgeInsets.only(left: size.iScreen(2.0), right: size.iScreen(0.5)),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _inputTextChat,
                onSubmitted: _onSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar Mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              // color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(0)),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _estaEscribiendo
                          ? () => _onSubmit(_inputTextChat.text.trim())
                          : null,
                    )
                  : Container(
                      child: IconTheme(
                      data: IconThemeData(color: Colors.blueAccent),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.send,
                        ),
                        onPressed: _estaEscribiendo
                            ? () => _onSubmit(_inputTextChat.text.trim())
                            : null,
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }

  _onSubmit(String texto) {
    if(texto.length==0) return;
    print(texto);
    _inputTextChat.clear();
    _focusNode.requestFocus();
    final _newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(vsync: this,duration: Duration(milliseconds: 300)),
    );
    _message.insert(0, _newMessage);
    _newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

@override
  void dispose() {
    // TODO: OFF DEL SOCKET
    for(ChatMessage messaje  in _message)
    {
      messaje.animationController.dispose();
    }
    super.dispose();
  }




}
