import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class AIState extends State<AI> with WidgetsBindingObserver {
  late final Interpreter _interpreter;
  late final Tensor _inputTensor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _interpreter = await Interpreter.fromAsset('assets/lite-model_movinet_a2_stream_kinetics-600_classification_tflite_float16_2.tflite');
      _inputTensor = _interpreter.getInputTensors().first;
      print(_inputTensor);
    });
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI'),
      ),
    );
  }
}

class AI extends StatefulWidget {
  const AI({super.key});

  @override
  State<AI> createState() => AIState();
}

