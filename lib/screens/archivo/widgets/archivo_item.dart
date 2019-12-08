import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/archivo.dart';
import '../../../providers/archivos_provider.dart';
import '../../../googleDrive.dart';
import 'package:url_launcher/url_launcher.dart';

class ArchivoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final archivo = Provider.of<Archivo>(context);
    final archivos = Provider.of<Archivos>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
      child: ListTile(
        onTap: () {
          var id = archivo.idarchivo;
          launch("https://drive.google.com/open?id=$id");
        },
        title: Text(archivo.title),
        leading: Text(archivo.type),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            GoogleDrive().delete(archivo.idarchivo);
            archivos.delete(archivo.id);
          },
        ),
      ),
    );
  }
}
