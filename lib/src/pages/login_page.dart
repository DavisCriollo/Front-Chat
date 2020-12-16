import 'package:chatapp/src/helpers/mostar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/src/services/auth_service.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:chatapp/src/utils/responsive.dart';
import 'package:chatapp/src/widgets/boton_login.dart';
import 'package:chatapp/src/widgets/inputs_principales.dart';
import 'package:chatapp/src/widgets/labels.dart';
import 'package:chatapp/src/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.hScreen(100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Logo(
                  titulo: 'Menssenger',
                ),
                _Form(),
                Labels(
                  size: size,
                  ruta: 'register',
                  titulo: 'No tienes cuenta ?',
                  action: 'Crea una ahora !',
                ),
                Text(
                  'Términos y condiciones de uso',
                  style: GoogleFonts.roboto(
                      fontSize: size.iScreen(2.0),
                      color: Colors.black54,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final autService = Provider.of<AuthService>(context);
    final Responsive size = Responsive.of(context);
    return Container(
      margin: EdgeInsets.only(top: size.iScreen(2.0)),
      padding: EdgeInsets.symmetric(horizontal: size.iScreen(5.0)),
      child: Column(
        children: [
          InputsPrincipales(
            isPassword: false,
            icon: FontAwesomeIcons.envelope,
            placeholder: 'correo@correo.com',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
            autocorrect: false,
          ),
          InputsPrincipales(
            icon: FontAwesomeIcons.lock,
            placeholder: '******',
            keyboardType: TextInputType.text,
            textController: passwordController,
            isPassword: true,
            autocorrect: false,
          ),
          SizedBox(
            height: size.iScreen(2.0),
          ),
          BotonAzul(
            emailController: emailController,
            passwordController: passwordController,
            size: size,
            label: 'Ingrear',
            onPressed: autService.autenticando
                ? null
                : () async{
                  FocusScope.of(context).unfocus();


                final loginOk= await   autService.login(emailController.text.trim(),
                        passwordController.text.trim());
                        if(loginOk)
                        {
                          Navigator.pushReplacementNamed(context, 'usuarios');
                        }
                        else
                        {
                          mostarAlerta(context,'Login Incorrecto','Revise sus credenciales nuevamente');
                        }
                  },
          )
        ],
      ),
    );
  }
}
