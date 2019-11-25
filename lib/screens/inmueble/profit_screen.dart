import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/gastos_provider.dart';
import '../../providers/payments_provider.dart';
import '../../providers/floors_provider.dart';
import '../../providers/config.dart';

class ProfitScreen extends StatefulWidget {
  static const routeName = '/profitscreen';

  @override
  _ProfitScreenState createState() => _ProfitScreenState();
}

class _ProfitScreenState extends State<ProfitScreen> {
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

    final gastosMes = gastosData.gastosMeses(floorId, selectedYear);

    final pagosMes = pagosData.pagosMeses(floorId, selectedYear);
    final valorReal = floorData.valorReal(floorId);

    var totalGastos = 0.0;
    var totalPagos = 0.0;

    gastosMes.forEach((key, value) {
      totalGastos += value;
    });

    pagosMes.forEach((key, value) {
      totalPagos += value;
    });

    var contador = 12;

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

    return Scaffold(
      appBar: AppBar(
        title: Text('BAI'),
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
                          pagosMes['enero'] == 0 && gastosMes['enero'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['enero'].toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(gastosMes['enero']
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'enero'] -
                                                          gastosMes['enero'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'enero'] -
                                                              gastosMes[
                                                                  'enero']) *
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
                          pagosMes['febrero'] == 0 && gastosMes['febrero'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(
                                                  gastosMes['febrero']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'febrero'] -
                                                          gastosMes['febrero'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'febrero'] -
                                                              gastosMes[
                                                                  'febrero']) *
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
                          pagosMes['marzo'] == 0 && gastosMes['marzo'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['marzo'].toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(gastosMes['marzo']
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'marzo'] -
                                                          gastosMes['marzo'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'marzo'] -
                                                              gastosMes[
                                                                  'marzo']) *
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
                          pagosMes['abril'] == 0 && gastosMes['abril'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['abril'].toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(gastosMes['abril']
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'abril'] -
                                                          gastosMes['abril'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'abril'] -
                                                              gastosMes[
                                                                  'abril']) *
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
                          pagosMes['mayo'] == 0 && gastosMes['mayo'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['mayo'].toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(
                                                  gastosMes['mayo'].toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes['mayo'] -
                                                          gastosMes['mayo'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(
                                                  ((pagosMes['mayo'] -
                                                                  gastosMes[
                                                                      'mayo']) *
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
                          pagosMes['junio'] == 0 && gastosMes['junio'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['junio'].toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(gastosMes['junio']
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'junio'] -
                                                          gastosMes['junio'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'junio'] -
                                                              gastosMes[
                                                                  'junio']) *
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
                          pagosMes['julio'] == 0 && gastosMes['julio'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['julio'].toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(gastosMes['julio']
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'julio'] -
                                                          gastosMes['julio'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'julio'] -
                                                              gastosMes[
                                                                  'julio']) *
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
                          pagosMes['agosto'] == 0 && gastosMes['agosto'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(gastosMes['agosto']
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'agosto'] -
                                                          gastosMes['agosto'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'agosto'] -
                                                              gastosMes[
                                                                  'agosto']) *
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
                          pagosMes['septiembre'] == 0 &&
                                  gastosMes['septiembre'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['septiembre']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(
                                                  gastosMes['septiembre']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text(
                                                  (pagosMes['septiembre'] -
                                                              gastosMes[
                                                                  'septiembre'])
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'septiembre'] -
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
                          pagosMes['octubre'] == 0 && gastosMes['octubre'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(
                                                  gastosMes['octubre']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text((pagosMes[
                                                              'octubre'] -
                                                          gastosMes['octubre'])
                                                      .toString() +
                                                  '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'octubre'] -
                                                              gastosMes[
                                                                  'octubre']) *
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
                          pagosMes['noviembre'] == 0 &&
                                  gastosMes['noviembre'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['noviembre']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(
                                                  gastosMes['noviembre']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text(
                                                  (pagosMes['noviembre'] -
                                                              gastosMes[
                                                                  'noviembre'])
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'noviembre'] -
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
                          pagosMes['diciembre'] == 0 &&
                                  gastosMes['diciembre'] == 0
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Card(
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
                                              trailing: Text(
                                                  pagosMes['diciembre']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('Gastos'),
                                              trailing: Text(
                                                  gastosMes['diciembre']
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI'),
                                              trailing: Text(
                                                  (pagosMes['diciembre'] -
                                                              gastosMes[
                                                                  'diciembre'])
                                                          .toString() +
                                                      '€'),
                                            ),
                                            ListTile(
                                              title: Text('BAI %'),
                                              trailing: Text(((pagosMes[
                                                                  'diciembre'] -
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
                            totalPagos.toString() + '€',
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
                            totalGastos.toString() + '€',
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
                            (totalPagos - totalGastos).toString() + '€',
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
                            ((totalPagos - totalGastos) *
                                        contador *
                                        100 /
                                        valorReal)
                                    .toStringAsFixed(2) +
                                '%',
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
