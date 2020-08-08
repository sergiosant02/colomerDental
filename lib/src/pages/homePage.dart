import 'package:colomer_dental/src/fondos/fondoNews.dart';
import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:colomer_dental/src/stream/streamProvider.dart';
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
  PublicacionesStream _publicacionesStream = PublicacionesStream();
  final FondoNews _fondoNews = FondoNews();

  @override
  void initState() {
    super.initState();
    _publicacionesStream.obtenerPublicaciones();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      child: StreamBuilder(
                          stream: _publicacionesStream.noticiasStream,
                          builder: (context,
                              AsyncSnapshot<List<NoticiasModel>> snap) {
                            if (!snap.hasData)
                              return CircularProgressIndicator();
                            List<NoticiasModel> lista = snap.data;
                            return ListView.builder(
                                itemCount: lista.length,
                                itemBuilder: (BuildContext context, int i) {
                                  print(lista[i].titulo);
                                  NewsAppear news = NewsAppear();

                                  return Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: news.newsBox(context, lista[i]),
                                  );
                                });
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
