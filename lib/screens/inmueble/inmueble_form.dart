import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/floor.dart';
import '../../providers/floors_provider.dart';

class FloorForm extends StatefulWidget {
  static const routeName = '/floorForm';
  @override
  _FloorFormState createState() => _FloorFormState();
}

class _FloorFormState extends State<FloorForm> {
  var _isInit = true;

  var _isLoading = false;

  var _editedFloor = Floor(
    id: null,
    calle: '',
    numero: '',
    puerta: '',
    planta: '',
    provincia: '',
    zipcode: '',
    isDeleted: false,
    comision: 0,
    costeCompra: 0,
    alquiler: 0,
    ivaItp: 0,
    gastoNotaria: 0,
    reformas: 0,
    mobiliario: 0,
    observaciones: '',
    preName: '',
    preLastName: '',
    preDireccion: '',
    preTelefono: '',
    preEmail: '',
    preObservaciones: '',
    admName: '',
    admDireccion: '',
    admTelefono: '',
    admEmail: '',
    admMovil: '',
    aseName: '',
    aseContacto: '',
    aseTelefono: '',
    aseObservaciones: '',
    aseEmail: '',
  );

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final floorId = ModalRoute.of(context).settings.arguments as String;

      if (floorId != null) {
        _editedFloor =
            Provider.of<Floors>(context, listen: false).findById(floorId);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final _formGKey = GlobalKey<FormState>();

//Datos generales del inmuebles

  final _numeroFocusNode = FocusNode();
  final _plantaFocusNode = FocusNode();
  final _puertaFocusNode = FocusNode();
  final _codigoPostalFocusNode = FocusNode();
  final _provinciaFocusNode = FocusNode();
  final _observacionesFocusNode = FocusNode();

  //Gastos de Compra

  final _costoCompraFocusNode = FocusNode();
  final _ivaItpFocusNode = FocusNode();
  final _gastoNotariaFocusNode = FocusNode();
  final _comisionFocusNode = FocusNode();
  final _mobilarioFocusNode = FocusNode();
  final _reformasFocusNode = FocusNode();
  final _alquilerFocusNode = FocusNode();

//DATOS DEL PRESIDENTE

  final _preNameFocusNode = FocusNode();
  final _preLastNameFocusNode = FocusNode();
  final _preDireccionFocusNode = FocusNode();
  final _preTelefonoFocusNode = FocusNode();
  final _preEmailFocusNodo = FocusNode();
  final _preObservacionesFocusNode = FocusNode();

//DATOS DEL ADMINISTRADOR

  final _admNameFocusNode = FocusNode();
  final _admDireccionFocusNode = FocusNode();
  final _admTelefonoFocusNode = FocusNode();
  final _admEmailFocusNode = FocusNode();
  final _admMovilFocusNode = FocusNode();

//DATOS ASEGURADOR

  final _aseNameFocusNode = FocusNode();
  final _aseContactoFocusNode = FocusNode();
  final _aseTelefonoFocusNode = FocusNode();
  final _aseEmailFocusNode = FocusNode();
  final _aseObservacionesFocusNode = FocusNode();

  @override
  void dispose() {
//Datos General Dispose

    _numeroFocusNode.dispose();
    _plantaFocusNode.dispose();
    _puertaFocusNode.dispose();
    _codigoPostalFocusNode.dispose();
    _provinciaFocusNode.dispose();
    _observacionesFocusNode.dispose();
//Gastos de  compra Dispose
    _costoCompraFocusNode.dispose();
    _ivaItpFocusNode.dispose();
    _gastoNotariaFocusNode.dispose();
    _comisionFocusNode.dispose();
    _mobilarioFocusNode.dispose();
    _reformasFocusNode.dispose();
    _alquilerFocusNode.dispose();

    //DATOS PRESIDENTE
    _preNameFocusNode.dispose();
    _preLastNameFocusNode.dispose();
    _preDireccionFocusNode.dispose();
    _preTelefonoFocusNode.dispose();
    _preEmailFocusNodo.dispose();
    _preObservacionesFocusNode.dispose();

    //DATOS ADMIN

    _admNameFocusNode.dispose();
    _admDireccionFocusNode.dispose();
    _admTelefonoFocusNode.dispose();
    _admEmailFocusNode.dispose();
    _admMovilFocusNode.dispose();

    // DATOS ASEGURADOR

    _aseNameFocusNode.dispose();
    _aseContactoFocusNode.dispose();
    _aseTelefonoFocusNode.dispose();
    _aseEmailFocusNode.dispose();
    _aseObservacionesFocusNode.dispose();

    super.dispose();
  }

  void _saveForm() {
    _formGKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedFloor.id == null) {
      Provider.of<Floors>(context, listen: false)
          .addFloor(_editedFloor)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Ha ocurrido un error'),
            content: Text('Asegurate que tienes conexion a internet'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }).then((_) {
        setState(
          () {
            _isLoading = false;
          },
        );
        Navigator.of(context).pop();
      });
    } else {
      Provider.of<Floors>(context, listen: false)
          .updateFloor(_editedFloor)
          .then((_) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _editedFloor.id == null
            ? Text('Registrar Piso')
            : Text('Editar Piso'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formGKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.teal.withOpacity(0.6),
                        child: ListTile(
                          title: Text(
                            'Direccion',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      TextFormField(
                          initialValue: _editedFloor.calle,
                          decoration: InputDecoration(
                            labelText: 'Calle',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_numeroFocusNode);
                          },
                          onSaved: (value) {
                            _editedFloor.calle = value;
                          }),
                      TextFormField(
                        initialValue: _editedFloor.numero,
                        decoration: InputDecoration(labelText: 'Numero'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _numeroFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_plantaFocusNode);
                        },
                        onSaved: (value) {
                          _editedFloor.numero = value;
                        },
                      ),
                      TextFormField(
                          initialValue: _editedFloor.planta,
                          decoration: InputDecoration(labelText: 'Planta'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _plantaFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_puertaFocusNode);
                          },
                          onSaved: (value) {
                            _editedFloor.planta = value;
                          }),
                      TextFormField(
                          initialValue: _editedFloor.puerta,
                          decoration: InputDecoration(labelText: 'Puerta'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _puertaFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_codigoPostalFocusNode);
                          },
                          onSaved: (value) {
                            _editedFloor.puerta = value;
                          }),
                      TextFormField(
                          initialValue: _editedFloor.zipcode,
                          decoration:
                              InputDecoration(labelText: 'Codigo Postal'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _codigoPostalFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_provinciaFocusNode);
                          },
                          onSaved: (value) {
                            _editedFloor.zipcode = value;
                          }),
                      TextFormField(
                          initialValue: _editedFloor.provincia,
                          decoration: InputDecoration(labelText: 'Provincia'),
                          textInputAction: TextInputAction.next,
                          focusNode: _provinciaFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_observacionesFocusNode);
                          },
                          onSaved: (value) {
                            _editedFloor.provincia = value;
                          }),
                      TextFormField(
                        initialValue: _editedFloor.observaciones,
                        decoration: InputDecoration(labelText: 'Observaciones'),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        focusNode: _observacionesFocusNode,
                        onSaved: (value) {
                          _editedFloor.observaciones = value;
                        },
                      ),
                      Container(
                        color: Colors.teal.withOpacity(0.6),
                        child: ListTile(
                          title: Text(
                            'Gastos de compra y alquiler',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: _editedFloor.alquiler.toString(),
                        decoration: InputDecoration(labelText: 'Alquiler'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _alquilerFocusNode,
                        onSaved: (value) {
                          _editedFloor.alquiler = double.parse(value);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_costoCompraFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.costeCompra.toString(),
                        decoration:
                            InputDecoration(labelText: 'Coste de compra'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _costoCompraFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_ivaItpFocusNode);
                        },
                        onSaved: (value) {
                          _editedFloor.costeCompra = double.parse(value);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.ivaItp.toString(),
                        decoration: InputDecoration(labelText: 'Iva/ITP'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _ivaItpFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_gastoNotariaFocusNode);
                        },
                        onSaved: (value) {
                          _editedFloor.ivaItp = double.parse(value);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.gastoNotaria.toString(),
                        decoration:
                            InputDecoration(labelText: 'Gastos Notaria'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _gastoNotariaFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_comisionFocusNode);
                        },
                        onSaved: (value) {
                          _editedFloor.gastoNotaria = double.parse(value);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.comision.toString(),
                        decoration: InputDecoration(labelText: 'Comision'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _comisionFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_mobilarioFocusNode);
                        },
                        onSaved: (value) {
                          _editedFloor.comision = double.parse(value);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.mobiliario.toString(),
                        decoration: InputDecoration(labelText: 'Mobiliario'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _mobilarioFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_reformasFocusNode);
                        },
                        onSaved: (value) {
                          _editedFloor.mobiliario = double.parse(value);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.reformas.toString(),
                        decoration: InputDecoration(labelText: 'Reformas'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _reformasFocusNode,
                        onSaved: (value) {
                          _editedFloor.reformas = double.parse(value);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_preNameFocusNode);
                        },
                      ),
                      Container(
                        color: Colors.teal.withOpacity(0.6),
                        child: ListTile(
                          title: Text(
                            'Datos del presidente',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: _editedFloor.preName,
                        decoration: InputDecoration(labelText: 'Nombre'),
                        textInputAction: TextInputAction.next,
                        focusNode: _preNameFocusNode,
                        onSaved: (value) {
                          _editedFloor.preName = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_preLastNameFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.preLastName,
                        decoration: InputDecoration(labelText: 'Apellidos'),
                        textInputAction: TextInputAction.next,
                        focusNode: _preLastNameFocusNode,
                        onSaved: (value) {
                          _editedFloor.preLastName = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_preDireccionFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.preDireccion,
                        decoration: InputDecoration(labelText: 'Direccion'),
                        textInputAction: TextInputAction.next,
                        focusNode: _preDireccionFocusNode,
                        onSaved: (value) {
                          _editedFloor.preDireccion = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_preTelefonoFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.preTelefono,
                        decoration: InputDecoration(labelText: 'Telefono'),
                        textInputAction: TextInputAction.next,
                        focusNode: _preTelefonoFocusNode,
                        onSaved: (value) {
                          _editedFloor.preTelefono = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_preEmailFocusNodo);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.preEmail,
                        decoration: InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        focusNode: _preEmailFocusNodo,
                        onSaved: (value) {
                          _editedFloor.preEmail = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_preObservacionesFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.preObservaciones,
                        decoration: InputDecoration(labelText: 'Observaciones'),
                        textInputAction: TextInputAction.next,
                        focusNode: _preObservacionesFocusNode,
                        onSaved: (value) {
                          _editedFloor.preObservaciones = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_admNameFocusNode);
                        },
                      ),
                      Container(
                        color: Colors.teal.withOpacity(0.6),
                        child: ListTile(
                          title: Text(
                            'Datos del administrador',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: _editedFloor.admName,
                        decoration: InputDecoration(labelText: 'Nombre'),
                        textInputAction: TextInputAction.next,
                        focusNode: _admNameFocusNode,
                        onSaved: (value) {
                          _editedFloor.admName = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_admDireccionFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.admDireccion,
                        decoration: InputDecoration(labelText: 'Direccion'),
                        textInputAction: TextInputAction.next,
                        focusNode: _admDireccionFocusNode,
                        onSaved: (value) {
                          _editedFloor.admDireccion = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_admTelefonoFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.admTelefono,
                        decoration: InputDecoration(labelText: 'Telefono'),
                        textInputAction: TextInputAction.next,
                        focusNode: _admTelefonoFocusNode,
                        onSaved: (value) {
                          _editedFloor.admTelefono = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_admEmailFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.admEmail,
                        decoration: InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        focusNode: _admEmailFocusNode,
                        onSaved: (value) {
                          _editedFloor.admEmail = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_admMovilFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.admMovil,
                        decoration: InputDecoration(labelText: 'Movil'),
                        textInputAction: TextInputAction.next,
                        focusNode: _admMovilFocusNode,
                        onSaved: (value) {
                          _editedFloor.admMovil = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_aseNameFocusNode);
                        },
                      ),
                      Container(
                        color: Colors.teal.withOpacity(0.6),
                        child: ListTile(
                          title: Text(
                            'Datos del asegurador',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: _editedFloor.aseName,
                        decoration: InputDecoration(labelText: 'Compañia'),
                        textInputAction: TextInputAction.next,
                        focusNode: _aseNameFocusNode,
                        onSaved: (value) {
                          _editedFloor.aseName = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_aseContactoFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.aseContacto,
                        decoration: InputDecoration(labelText: 'Contacto'),
                        textInputAction: TextInputAction.next,
                        focusNode: _aseContactoFocusNode,
                        onSaved: (value) {
                          _editedFloor.aseContacto = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_aseTelefonoFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.aseTelefono,
                        decoration: InputDecoration(labelText: 'Telefono'),
                        textInputAction: TextInputAction.next,
                        focusNode: _aseTelefonoFocusNode,
                        onSaved: (value) {
                          _editedFloor.aseTelefono = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_aseEmailFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.aseTelefono,
                        decoration: InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        focusNode: _aseEmailFocusNode,
                        onSaved: (value) {
                          _editedFloor.aseEmail = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_aseObservacionesFocusNode);
                        },
                      ),
                      TextFormField(
                        initialValue: _editedFloor.aseObservaciones,
                        decoration: InputDecoration(labelText: 'Observaciones'),
                        textInputAction: TextInputAction.done,
                        focusNode: _aseObservacionesFocusNode,
                        onSaved: (value) {
                          _editedFloor.aseObservaciones = value;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
