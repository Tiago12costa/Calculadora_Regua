import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(ReguaCertaApp());
}

class ReguaCertaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RéguaCerta Centerless',
      theme: ThemeData(
        primaryColor: Color(0xFF004080),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFF6600),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dcController = TextEditingController();
  final daController = TextEditingController();
  final dpController = TextEditingController();

  String resultado = '';

  void calcular() {
    final double? dc = double.tryParse(dcController.text);
    final double? da = double.tryParse(daController.text);
    final double? dp = double.tryParse(dpController.text);

    if (dc == null || da == null || dp == null) {
      setState(() {
        resultado = 'Por favor, preencha todos os campos corretamente.';
      });
      return;
    }

    final constante = (8 * pi) / 360;
    final parte1 = (da + dp);
    final parte2 = (dc + dp);
    final parte3 = (da + dc + 2 * dp);

    final ap = constante * parte1 * (parte2 / parte3);

    setState(() {
      resultado = 'Altura de ajuste da régua: ${ap.toStringAsFixed(2)} mm';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RéguaCerta - Cálculo Centerless'),
        backgroundColor: Color(0xFF004080),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: dcController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ø Rebolo de Corte (Dc)'),
            ),
            TextField(
              controller: daController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ø Rebolo de Arraste (Da)'),
            ),
            TextField(
              controller: dpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Ø da Peça (Dp)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcular,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6600),
              ),
              child: Text('Calcular Altura'),
            ),
            SizedBox(height: 20),
            Text(
              resultado,
              style: TextStyle(fontSize: 18, color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
