import 'dart:math';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _plzTextController = TextEditingController();
  Future<String>? plzOutput;

  @override
  void initState() {
    super.initState();
    // TODO: initiate controllers √
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Postleitzahl"),
                    controller: _plzTextController,
                  ),
                  const SizedBox(height: 32),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: implementiere Suche √
                      setState(() {
                        plzOutput = getCityFromZip(_plzTextController.text);
                      });
                    },
                    child: const Text("Suche"),
                  ),
                  const SizedBox(height: 32),
                  FutureBuilder(
                    future: plzOutput,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error.toString()}'));
                      }
                      return Text("Ergebnis: ${snapshot.data}",
                          style: Theme.of(context).textTheme.labelLarge);
                    },
                    initialData: "Noch keine PLZ gesucht",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: dispose controllers √
    _plzTextController.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
