

import 'package:chatapp/src/pages/chat_page.dart';
import 'package:chatapp/src/pages/loading_page.dart';
import 'package:chatapp/src/pages/login_page.dart';
import 'package:chatapp/src/pages/register_page.dart';
import 'package:chatapp/src/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final  Map<String, Widget Function(BuildContext)> routesApp={
'loading':(_)=>LoadingPage(),
'login':(_)=>LoginPage(),
'register':(_)=>RegisterPage(),
'usuarios':(_)=>UsuariosPage(),
'chat':(_)=>ChatPage(),
};