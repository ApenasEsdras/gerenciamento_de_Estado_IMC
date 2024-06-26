// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/change_notfier/imc_change_notifier_controller.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import '../widgets/imc_gouge.dart';

class ImcChangeNotifier extends StatefulWidget {
  const ImcChangeNotifier({super.key});

  @override
  State<ImcChangeNotifier> createState() => _ImcChangeNotifierState();
}

class _ImcChangeNotifierState extends State<ImcChangeNotifier> {
  final controller = ImcChangeNotifierController();

  final MoneyMaskedTextController _controllerPeso =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final MoneyMaskedTextController _controllerAltura =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final formKey = GlobalKey<FormState>();

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
        title: const Center(child: Text('Calcule seu IMC')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return ImcGouge(imc: controller.imc);
                    }),
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

                        controller.calculaIMC(peso: peso, altura: altura);
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
