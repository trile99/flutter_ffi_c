import 'package:flutter/material.dart';

import 'ffi/monocypher_ffi_bridge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late FFIBridge ffiBridge;
  late MonocypherFFIBridge ffiBridgeManager = MonocypherFFIBridge.shared;

  @override
  void initState() {
    super.initState();

    // ffiBridge = FFIBridge();
    ffiBridgeManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart-C FFI')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                var res = ffiBridgeManager.xed25519Sign(
                  List.generate(64, (index) => index),
                  List.generate(32, (index) => index),
                  List.generate(64, (index) => index),
                  List.generate(64, (index) => index),
                );
                _showSnackbar(res.toString());
              },
              child: const Text('Run Sign Function'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(text)),
    );
}
