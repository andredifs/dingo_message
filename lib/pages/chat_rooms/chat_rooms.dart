import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat/chat_page.dart';

class ChatRoomsPage extends StatefulWidget {
  final String nomeUsuario;

  ChatRoomsPage({this.nomeUsuario});

  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState();
}

TextEditingController textEditingController = TextEditingController();
Stream salas;

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  @override
  void initState() {
    salas = FirebaseFirestore.instance.collection("chatRooms").snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Salas\nDisponíveis",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text(widget.nomeUsuario),
              SizedBox(height: 50),
              campoDeTexto("texto básico"),
              SizedBox(height: 10),
              add(),
              SizedBox(height: 10),
              todasSalas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget todasSalas() {
    return StreamBuilder(
        stream: salas,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return CircularProgressIndicator();
          }
          final listaSalas = snapshot.data.docs;
          return Column(
            children: [
              for (int i = 0; i < listaSalas.length; i++)
                buildSala(listaSalas[i]["nome_da_sala"],
                    listaSalas[i]["horario_da_sala"]),
            ],
          );
        });
  }

  Widget buildSala(String nomedaSala, int horarioDaSala) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ChatPage(
              nomeDaSala: nomedaSala,
              horarioDaSala: horarioDaSala,
              userName: widget.nomeUsuario,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nomedaSala),
            Icon(
              Icons.circle,
              color: Colors.greenAccent[700],
            ),
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

  Widget add() {
    return GestureDetector(
      onTap: () {
        int horario = DateTime.now().millisecondsSinceEpoch;
        if (textEditingController.text.isNotEmpty) {
          criarSala(textEditingController.text, horario, widget.nomeUsuario);
          textEditingController.text = "";
        }
      },
      child: Icon(Icons.add),
    );
  }

  void criarSala(String salaNome, int horario, String useName) {
    var salaDados = {
      "nome_da_sala": salaNome,
      "horario": horario,
      "criado por": useName,
    };

    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(horario.toString())
        .set(salaDados);
  }
}
