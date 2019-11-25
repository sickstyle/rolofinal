import 'package:flutter/material.dart';
import '../../screens/inquilino/active_inquilinos.dart';

import '../../screens/inquilino/soft_deleted_inquilinos.dart';
import '../../screens/inquilino/inquilinos_form.dart';

enum PageEnum { inmueble, inquilino }

class InquilinoFloor extends StatefulWidget {
  static const routeName = '/inquilinosFloor';

  InquilinoFloor({Key key}) : super(key: key);

  @override
  _InquilinoFloorState createState() => _InquilinoFloorState();
}

class _InquilinoFloorState extends State<InquilinoFloor> {
  @override
  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inquilinos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: <Widget>[
          floorId == null
              ? Container()
              : IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(InquilinoForm.routeName,
                        arguments: floorId.toString() + ',null');
                  },
                ),
          floorId == null
              ? Container()
              : IconButton(
                  icon: Icon(Icons.restore_page),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(SoftDeletedInquilinos.routeName);
                  },
                )
        ],
      ),
      body: Center(
        child: ActiveInquilinos(
          floorId: floorId,
        ),
      ),
    );
  }
}
