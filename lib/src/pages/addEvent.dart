import 'dart:io';

import 'package:colomer_dental/src/connect/connection.dart';
import 'package:colomer_dental/src/models/noticiasModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({Key key}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  File _image;
  final _picker = ImagePicker();
  NoticiasModel _noticiasModel = NoticiasModel();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final PublicacionesProvider _publicacionesProvider = PublicacionesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cloud_upload),
          onPressed: () async {
            if (!_formKey.currentState.validate())
              return null;
            else {
              _noticiasModel.fecha = DateTime.now().toString();
              if (_image == null) {
                _noticiasModel.fotoStatus = false;
                await _publicacionesProvider.addNew(_noticiasModel);
              } else {
                String _direccionFoto =
                    await _publicacionesProvider.subirFotoMySQL(_image);
                _noticiasModel.fotoUrl = _direccionFoto;
                _noticiasModel.fotoStatus = true;
                await _publicacionesProvider.addNew(_noticiasModel);
              }
              showDialog(
                  context: context,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ));
              Navigator.pushReplacementNamed(context, '/bottom');
            }
          }),
      appBar: AppBar(
        title: Text('Añadir un evento'),
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () async {
                final _foto = await _picker.getImage(
                    source: ImageSource.camera, imageQuality: 40);
                _image = File(_foto.path);
                setState(() {});
              })
        ],
      ),
      body: SingleChildScrollView(
        child: _cuerpo(context),
      ),
    );
  }

  Widget _cuerpo(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            child: _image == null
                ? Image(image: AssetImage('assets/loading/camera_icon.png'))
                : Image.file(File(_image.path)),
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Título'),
            onChanged: (valor) {
              _noticiasModel.titulo = valor;
              setState(() {});
            },
            validator: (value) {
              if (value.length < 1) return 'Debes introducir algún título';
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Contenido'),
            onChanged: (valor) {
              _noticiasModel.contenido = valor;
              setState(() {});
            },
            validator: (value) {
              if (value.length < 1)
                return 'Debes introducir algún tipo de descripción';
              return null;
            },
          ),
        ],
      ),
    );
  }
}
