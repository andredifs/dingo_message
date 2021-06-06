import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final String nomeDaSala;
  final int horarioDaSala;
  final String userName;

  ChatPage({this.nomeDaSala, this.horarioDaSala, this.userName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textEditingController = TextEditingController();

  Stream mensagens;

  @override
  void initState() {
    mensagens = FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(widget.horarioDaSala.toString())
        .collection("mensagens")
        .snapshots();
    super.initState();
  }

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
      child: Row(
        children: [
          Expanded(
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
          ),
          GestureDetector(onTap: () {
            if (textEditingController.text.isNotEmpty) {
              int horarioDaMensagem = DateTime.now().millisecondsSinceEpoch;
              addMensagem(widget.userName, horarioDaMensagem,
                  textEditingController.text);
              textEditingController.text = "";
            }
          })
        ],
      ),
    );
  }

  Widget buildMensagem(String enviadoPor, String conteudo) {
    return Container(
      margin: EdgeInsets.only(left: 30, bottom: 10),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(width: 10),
          Column(
            children: [
              Text(
                enviadoPor,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                conteudo,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget todasMensagens() {
    return StreamBuilder(
      stream: mensagens,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }
        final listaMensagens = snapshot.data.docs;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                widget.nomeDaSala,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 100),
              for (int i = 0; i < listaMensagens.lengt; i++)
                buildMensagem(listaMensagens[i]["enviado_por"],
                    listaMensagens[i]["conteudo"]),
            ],
          ),
        );
      },
    );
  }

  void addMensagem(String userName, int horarioDaMensagem, String conteudo) {
    var mensagem = {
      "conteudo": conteudo,
      "horario": horarioDaMensagem,
      "enviado_por": userName,
    };
    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(widget.horarioDaSala.toString())
        .collection("mensagens")
        .doc(horarioDaMensagem.toString())
        .set(mensagem);
  }
}
