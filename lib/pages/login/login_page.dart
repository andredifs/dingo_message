import 'package:flutter/material.dart';
import '../../config/my_colors.dart';
import '../welcome/welcome_page.dart';
import '../chat_rooms/chat_rooms.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingController = TextEditingController();
  String nomeUsuario;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.corBasica,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Usuário",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 250),
                campoDeTexto("@usuario"),
                SizedBox(height: 100),
                GestureDetector(
                  onTap: () {
                    if (textEditingController.text.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ChatRoomsPage(
                            nomeUsuario: textEditingController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: botao("Entrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget campoDeTexto(String recado) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: recado,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget botao(String botao) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MyColors.corPrincipal,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          botao,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
