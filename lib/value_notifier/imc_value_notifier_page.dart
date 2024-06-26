// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import '../widgets/imc_gouge.dart';

class ImcValueNotifier extends StatefulWidget {
  const ImcValueNotifier({super.key});

  @override
  State<ImcValueNotifier> createState() => _ImcValueNotifierState();
}

class _ImcValueNotifierState extends State<ImcValueNotifier> {
  final MoneyMaskedTextController _controllerPeso =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final MoneyMaskedTextController _controllerAltura =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final formKey = GlobalKey<FormState>();
  var imc = ValueNotifier(0.0);

  Future<void> _calculaIMC({
    required double peso,
    required double altura,
  }) async {
    imc.value = 0;
    await Future.delayed(const Duration(seconds: 1));
    imc.value = peso / pow(altura, 2);
  }

  @override
  void dispose() {
    _controllerPeso.dispose();
    _controllerAltura.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC setState'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: imc,
                  builder: (_, imcVale, __) {
                    return ImcGouge(imc: imcVale);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerPeso,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso',
                    hintText: 'Digite o valor',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controllerAltura,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Altura',
                    hintText: 'Digite o valor',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      var forValid = formKey.currentState?.validate() ?? false;
                      if (forValid) {
                        var formatter = NumberFormat.simpleCurrency(
                            locale: 'pt_BR', decimalDigits: 2);
                        double peso =
                            formatter.parse(_controllerPeso.text) as double;
                        double altura =
                            formatter.parse(_controllerAltura.text) as double;

                        _calculaIMC(peso: peso, altura: altura);
                      }
                    },
                    child: const Text('Calcular IMC'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
