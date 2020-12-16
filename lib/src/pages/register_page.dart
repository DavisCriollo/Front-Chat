import 'package:chatapp/src/helpers/mostar_alerta.dart';
import 'package:chatapp/src/services/auth_service.dart';
import 'package:chatapp/src/utils/responsive.dart';
import 'package:chatapp/src/widgets/boton_login.dart';
import 'package:chatapp/src/widgets/inputs_principales.dart';
import 'package:chatapp/src/widgets/labels.dart';
import 'package:chatapp/src/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
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
                  titulo: 'Registro',
                ),
                _Form(),
                Labels(
                    size: size,
                    ruta: 'login',
                    titulo: '¿Ya tienes cuenta ?',
                    action: 'Ingresa ahora !'),
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
  final nameController = TextEditingController();
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
            icon: FontAwesomeIcons.userAlt,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameController,
            autocorrect: false,
          ),
          InputsPrincipales(
            icon: FontAwesomeIcons.envelope,
            placeholder: 'correo@correo.com',
            keyboardType: TextInputType.text,
            textController: emailController,
            isPassword: false,
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
            label: 'Crear Cuenta',
            onPressed: autService.autenticando
                ? null
                : () async {
                    print(nameController.text);
                    print(emailController.text);
                    print(passwordController.text);
                    FocusScope.of(context).unfocus();

                    final registroOk = await autService.register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim());
                    if (registroOk==true) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostarAlerta(context, 'Registro Incorrecto',
                          registroOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
