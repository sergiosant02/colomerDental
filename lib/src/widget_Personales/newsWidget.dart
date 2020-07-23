import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class NewsAppear {
  Widget newsBox(BuildContext context, NoticiasModel _noticiasModel) {
    final size = MediaQuery.of(context).size;
    final tarjeta = Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 3, blurRadius: 10)
          ]),
      width: size.width * 0.85,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            _noticiasModel.titulo,
            style: GoogleFonts.fjallaOne(fontSize: size.width * 0.1),
            maxLines: 3,
          ),
          Text(
            _noticiasModel.contenido,
            style: GoogleFonts.caveat(fontSize: size.width * 0.08),
            maxLines: 90,
          ),
          if (_noticiasModel.fotoStatus) ...[
            Image(
              image: NetworkImage('http://concoapps.000webhostapp.com' +
                  _noticiasModel.fotoUrl),
              width: size.width * 0.85,
              fit: BoxFit.scaleDown,
            )
          ]
        ],
      ),
    );
    return tarjeta;
  }
}
