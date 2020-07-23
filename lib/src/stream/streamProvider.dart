import 'dart:async';

import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:colomer_dental/src/connect/connection.dart';

class PublicacionesStream {
  final publicacionesStreamController =
      StreamController<List<NoticiasModel>>.broadcast();
  Stream<List<NoticiasModel>> get noticiasStream =>
      publicacionesStreamController.stream;

  PublicacionesProvider _publicacionesProvider = PublicacionesProvider();

  void dispose() {
    publicacionesStreamController?.close();
  }

  obtenerPublicaciones() async {
    publicacionesStreamController.sink
        .add(await _publicacionesProvider.obtenerNoticias());
  }
}
