import 'package:chatapp/src/models/usuario.dart';
import 'package:chatapp/src/services/auth_service.dart';
import 'package:chatapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
// PULL TO REFRESH
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: "María", email: "maria@test.com", online: true),
    Usuario(
        uid: '2',
        nombre: "Fernando",
        email: "fernando@test.com",
        online: false),
    Usuario(uid: '3', nombre: "David", email: "david@test.com", online: false),
    Usuario(uid: '4', nombre: "Elena", email: "elena@test.com", online: false),
    Usuario(
        uid: '5', nombre: "Damian", email: "damian@test.com", online: false),
  ];

  @override
  Widget build(BuildContext context) {

    final authService= Provider.of<AuthService>(context);
    final usuario=authService.usuario;
    final Responsive size = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('${usuario.nombre}',
              style: GoogleFonts.roboto(
                  fontSize: size.iScreen(2.0),
                  color: Colors.black54,
                  fontWeight: FontWeight.normal)),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.black54,
          ),
          onPressed: () {

            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();


          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.iScreen(2.0)),
            // child: Icon(Icons.check_circle,color: Colors.blue[400],),
            child: Icon(
              Icons.offline_bolt,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check,color:Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: _listViewUsuarios(size),
        onRefresh:_cargarUsuarios, 
      ),
    );
  }

  ListView _listViewUsuarios(Responsive size) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => usuarioListTile(usuarios[i], size),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile usuarioListTile(Usuario usuario, Responsive size) {
    return ListTile(
      title: Text(usuario.nombre),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        // backgroundColor: Colors.blue[200],
      ),
      subtitle: Text(usuario.email),
      trailing: Container(
        width: size.iScreen(1.5),
        height: size.iScreen(1.5),
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }




_cargarUsuarios() async
{
  
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  
}




}
