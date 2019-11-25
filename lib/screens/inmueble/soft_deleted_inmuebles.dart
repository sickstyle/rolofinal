import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/floors_provider.dart';
import '../../widgets/floor_item.dart';

class SoftDeletedInmuebles extends StatelessWidget {
  static const routeName = '/softDeletedFloors';

  @override
  Widget build(BuildContext context) {
    final floorsData = Provider.of<Floors>(context);
    final floors = floorsData.inactiveFloors;
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurar/Eliminar Pisos'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: floors.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: floors[i],
          child: FloorItem(
              // floors[i].id,
              // floors[i].direccion,
              // floors[i].alquiler,
              ),
        ),
      ),
    );
  }
}
