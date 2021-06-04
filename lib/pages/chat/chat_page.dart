import 'package:flutter/material.dart';
import '../../config/my_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final String nomeDaSala;

  ChatPage({this.nomeDaSala});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 55),
              child: todasMensagens(),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: 50,
              child: campoDeTexto("Mensagem"),
            )
          ],
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

  Widget buildMensagem() {
    return Container(
      margin: EdgeInsets.only(left: 30, bottom: 10),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(width: 10),
          Column(
            children: [
              Text(
                "Nome da pessoa",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                "Nova mensagem",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget todasMensagens() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            widget.nomeDaSala,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 100),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
          buildMensagem(),
        ],
      ),
    );
  }
}
