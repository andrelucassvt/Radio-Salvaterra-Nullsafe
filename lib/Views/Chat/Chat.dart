import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:radiosalvaterrafm/Views/Chat/Component/Comentarios.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User currentUser; 
  TextEditingController mensagem = TextEditingController();
  GlobalKey<FormState> validacao = GlobalKey<FormState>();
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      FirebaseAuth.instance
        .authStateChanges()
        .listen((user) {
          setState(() {
            currentUser = user;            
          });
        });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Chat Salvaterra FM',
          maxLines: 1,
          ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Form(
        key: validacao,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Mensagens2').orderBy("Time",descending: false).snapshots(),
                builder: (context,snapshot){
                  
                  if (snapshot.hasError) {
                    return Center(
                      child: AutoSizeText(
                        'Erro ao carregar dados :(',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    );
                  } else if(!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } 
                  List<DocumentSnapshot> doc = snapshot.data.docs.toList();
                  if(doc.isEmpty){
                    return Center(
                      child: AutoSizeText(
                        'Sem comentários :(',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ); 
                  }
                  return ListView.builder(
                    itemCount: doc.length,
                    itemBuilder: (context,index){
                      return Comentarios(
                        nome: doc[index]['sendName'],
                        perfil: doc[index]['sendPhotourl'],
                        texto: doc[index]['Texto'],
                      );
                    },
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: mensagem,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          hintText: 'Enviar uma mensagem',
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Campo vazio!!";
                          }
                        },
                      )),
                    //Botao enviar
                    IconButton(
                      icon: Icon(Icons.send),
                        onPressed: (){
                          //Valida se o usuario está logado ou não
                          if (currentUser == null) {
                            _getUser();
                          
                          //Valida se o usuario escreveu algo ou não
                          } else if(validacao.currentState.validate()){

                            enviarMensagem(
                              texto: mensagem.text
                            ).then((value) {
                              ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  SnackBar(
                                    content: Text('Mensagem enviada'),)
                                  );
                            mensagem.clear();
                            }).catchError((_){
                              ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  SnackBar(
                                    content: Text('Mensagem não enviada'),)
                                  );
                              mensagem.clear();   
                            });

                          }
                        },
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }







  Future enviarMensagem({String texto})async{
    Map<String, dynamic> data = {
      "uid" : currentUser.uid,
      "sendName": currentUser.displayName,
      "Texto": texto,
      "sendPhotourl": currentUser.photoURL,
      "Time": FieldValue.serverTimestamp()
    };
    return await FirebaseFirestore.instance.collection('Mensagens2').add(data);
  }
  Future<User> _getUser() async {
      if (currentUser != null) return currentUser;

      try {
        final GoogleSignInAccount googleSignInAccount = (await googleSignIn
            .signIn());
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        var authResult = await FirebaseAuth.instance
            .signInWithCredential(credential);

        final User user = authResult.user;

        return user;
      } catch (error) {
        return null;
      }
   }
}