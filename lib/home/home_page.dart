// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/setState/imc_setState_page.dart';

import '../change_notfier/imc_change_notifier_page.dart';
import '../value_notifier/imc_value_notifier_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goToPage(BuildContext context, Widget Page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcSetState()),
              child: const Text('SetStatte'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcValueNotifier()),
              child: const Text('ValueNotifaier'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const ImcChangeNotifier()),
              child: const Text('changeNotifier'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Bloc Patter (Streams)'),
            )
          ],
        ),
      ),
    );
  }
}
