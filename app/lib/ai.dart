import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart';

class AIState extends State<AI> with WidgetsBindingObserver {
  late final Interpreter _interpreter;
  late final Tensor _inputTensor;

  late CameraController controller;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();




    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var _cameras = await availableCameras();

      controller = CameraController(_cameras[0], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        controller.startImageStream(imageAnalysis);
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });

      _interpreter = await Interpreter.fromAsset('assets/lite-model_movinet_a2_stream_kinetics-600_classification_tflite_float16_2.tflite');
      _inputTensor = _interpreter.getInputTensors().first;
      print(_inputTensor);
    });
  }

  Future<void> imageAnalysis(CameraImage cameraImage) async {
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;
    print(cameraImage);
    _isProcessing = false;
    if (mounted) {
      setState(() {
        // showed_result = .....
      });
    }
  }

  @override
  void dispose() {
    _interpreter.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI'),
      ),
      body: Stack(
        children: [
          CameraPreview(controller),
        ],
      ),
    );
  }
}

class AI extends StatefulWidget {
  const AI({super.key});

  @override
  State<AI> createState() => AIState();
}

