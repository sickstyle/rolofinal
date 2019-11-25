import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/inquilinos_provider.dart';
import './inquilino_item.dart';

class SoftDeletedInquilinos extends StatelessWidget {
  static const routeName = '/softDeletedInquilinos';

  @override
  Widget build(BuildContext context) {
    final inqulinosData = Provider.of<Inquilinos>(context);
    final inquilinos = inqulinosData.inactiveInquilinos;
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurar/Eliminar Inquilinos'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: inquilinos.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: inquilinos[i],
          child: InquilinoItem(
              // floors[i].id,
              // floors[i].direccion,
              // floors[i].alquiler,
              ),
        ),
      ),
    );
  }
}
