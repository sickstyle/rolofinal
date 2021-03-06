import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/gastos_provider.dart';
import '../../providers/payments_provider.dart';
import '../../providers/floors_provider.dart';
import '../../providers/config.dart';

class MbTeorico extends StatefulWidget {
  static const routeName = '/MbTeorico';

  @override
  _MbTeoricoState createState() => _MbTeoricoState();
}

class _MbTeoricoState extends State<MbTeorico> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Pagos>(context).fetchAndSetPagos();

      Provider.of<Config>(context).fetchConfig();

      Provider.of<Gastos>(context).fetchAndSetGastos().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final floorId = ModalRoute.of(context).settings.arguments as String;
    final gastosData = Provider.of<Gastos>(context);
    final floorData = Provider.of<Floors>(context);
    final pagosData = Provider.of<Pagos>(context);

    final selectedYear = Provider.of<Config>(context).fecha;
    final valorReal = floorData.valorReal(floorId);

    final gastosFijos = gastosData.gastosFijos(floorId, selectedYear);

    final gastosMes = gastosData.gastosMesesMbt(floorId, selectedYear);
    final pagosMes = pagosData.pagosMeses(floorId, selectedYear);
    final pagosFijos = pagosData.pagosFijos(floorId, selectedYear);

    var totalGastos = 0.0;
    var totalPagos = 0.0;

    gastosMes.forEach((key, value) {
      totalGastos += value;
    });

    pagosMes.forEach((key, value) {
      totalPagos += value;
    });

    var contador = 12;

    var contador2 = 0;

    var meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ].forEach((m) {
      if (pagosMes[m] == 0 && gastosMes[m] == 0) {
        contador--;
      }
    });

    gastosMes.forEach((key, value) {
      if (value == 0) {
        gastosMes[key] = gastosFijos;
      } else {
        gastosMes[key] += gastosFijos;
      }
    });

    pagosMes.forEach((key, value) {
      if (value == 0) {
        pagosMes[key] = pagosFijos;
        contador2++;
      }
    });

    var totalAlquiler = totalPagos + pagosFijos * contador2;
    var totalGas = totalGastos + gastosFijos * 12;
    var bai = totalAlquiler - totalGas;
    var bai2 = bai * 100 / valorReal;

    return Scaffold(
      appBar: AppBar(
        title: Text('Margen Bruto Teorico'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Enero',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['enero']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['enero']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['enero'] -
                                                    gastosMes['enero'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['enero'] -
                                                        gastosMes['enero']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Febrero',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['febrero']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['febrero']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['febrero'] -
                                                    gastosMes['febrero'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['febrero'] -
                                                        gastosMes['febrero']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Marzo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['marzo']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['marzo']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['marzo'] -
                                                    gastosMes['marzo'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['marzo'] -
                                                        gastosMes['marzo']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Abril',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['abril']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['abril']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['abril'] -
                                                    gastosMes['abril'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['abril'] -
                                                        gastosMes['abril']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Mayo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['mayo']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['mayo']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['mayo'] -
                                                    gastosMes['mayo'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['mayo'] -
                                                        gastosMes['mayo']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Junio',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['junio']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['junio']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['junio'] -
                                                    gastosMes['junio'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['junio'] -
                                                        gastosMes['junio']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Julio',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['julio']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['julio']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['julio'] -
                                                    gastosMes['julio'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['julio'] -
                                                        gastosMes['julio']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Agosto',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['agosto']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['agosto']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['agosto'] -
                                                    gastosMes['agosto'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['agosto'] -
                                                        gastosMes['agosto']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Septiembre',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['septiembre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['septiembre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['septiembre'] -
                                                    gastosMes['septiembre'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(
                                            ((pagosMes['septiembre'] -
                                                            gastosMes[
                                                                'septiembre']) *
                                                        contador *
                                                        100 /
                                                        valorReal)
                                                    .toStringAsFixed(2) +
                                                '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Octubre',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['octubre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['octubre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['octubre'] -
                                                    gastosMes['octubre'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['octubre'] -
                                                        gastosMes['octubre']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Noviembre',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['noviembre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['noviembre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['noviembre'] -
                                                    gastosMes['noviembre'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['noviembre'] -
                                                        gastosMes[
                                                            'noviembre']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.teal.shade100,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    color: Colors.teal.shade300,
                                    child: ListTile(
                                      title: Text(
                                        'Diciembre',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.teal.shade100,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text('Alquiler'),
                                        trailing: Text(pagosMes['diciembre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('Gastos'),
                                        trailing: Text(gastosMes['diciembre']
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI'),
                                        trailing: Text((pagosMes['diciembre'] -
                                                    gastosMes['diciembre'])
                                                .toStringAsFixed(2) +
                                            '€'),
                                      ),
                                      ListTile(
                                        title: Text('BAI %'),
                                        trailing: Text(((pagosMes['diciembre'] -
                                                        gastosMes[
                                                            'diciembre']) *
                                                    contador *
                                                    100 /
                                                    valorReal)
                                                .toStringAsFixed(2) +
                                            '%'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    )),
                    color: Colors.blue.shade200,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          title: Text(
                            'Total Alquiler:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            totalAlquiler.toStringAsFixed(2) + '€',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                            'Total Gastos:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            totalGas.toStringAsFixed(2) + '€',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                            'BAI:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            bai.toStringAsFixed(2) + '€',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                            'BAI %:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            bai2.toStringAsFixed(2) + '%',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
