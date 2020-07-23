import 'package:colomer_dental/src/fondos/fondoNews.dart';
import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:colomer_dental/src/widget_Personales/newsWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FondoNews _fondoNews = FondoNews();
  @override
  Widget build(BuildContext context) {
    NoticiasModel noticiasModel = NoticiasModel();
    noticiasModel.titulo = "prueba";
    noticiasModel.contenido = "esto es una prueba";
    noticiasModel.fotoStatus = true;
    noticiasModel.fotoUrl =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSQgaKxVn789NhYDVGyPSl3lHw0IjY1WC_4Jg&usqp=CAU";
    final size = MediaQuery.of(context).size;
    NoticiasModel noticiasModel2 = NoticiasModel();
    noticiasModel2.titulo = "prueba";
    noticiasModel2.contenido =
        "vale, esto es una prueba seria de mas de una linea de texto para ver como lo separa";
    noticiasModel2.fotoStatus = false;
    List<NoticiasModel> lista = [noticiasModel, noticiasModel2];
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned(
              left: 30,
              top: -size.height * 0.55,
              child: _fondoNews.fondo(context, Colors.blue[200]),
            ),
            Positioned(
              right: 30,
              top: -size.height * 0.55,
              child: _fondoNews.fondo(context, Colors.lightBlue),
            ),
            pref.correo == 'familiacolomer@colomer.com'
                ? Positioned(
                    top: size.height * 0.08,
                    right: 20,
                    child: IconButton(
                        icon: Icon(
                          Icons.add_box,
                          color: Colors.blue[800],
                        ),
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pushNamed(context, '/add');
                        }))
                : Container(),
            SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Noticias',
                          style:
                              GoogleFonts.galada(fontSize: size.width * 0.15)),
                    ),
                    Expanded(
                      //padding: EdgeInsets.only(top: 10, bottom: 15),
                      child: ListView.builder(
                          itemCount: lista.length,
                          itemBuilder: (BuildContext context, int i) {
                            print(lista[i].titulo);
                            NewsAppear news = NewsAppear();

                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: news.newsBox(context, lista[i]),
                            );
                          }),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
