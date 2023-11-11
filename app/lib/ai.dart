import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;
import 'dart:math';

class ImageUtils {
  static const iosBytesOffset = 28;

  // Converts a [CameraImage] object to [image_lib.Image] object
  static image_lib.Image? convertCameraImage(CameraImage cameraImage) {
    if (cameraImage.format.group == ImageFormatGroup.yuv420) {
      return convertYUV420ToImage(cameraImage);
    } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
      return convertBGRA8888ToImage(cameraImage);
    } else {
      return null;
    }
  }

  // Converts a [CameraImage] in BGRA888 format to [imageLib.Image] in RGB format
  static image_lib.Image convertBGRA8888ToImage(CameraImage cameraImage) {
    image_lib.Image img = image_lib.Image.fromBytes(
        width: cameraImage.planes[0].width!,
        height: cameraImage.planes[0].height!,
        bytes: cameraImage.planes[0].bytes.buffer,
        rowStride: cameraImage.planes[0].bytesPerRow,
        bytesOffset: iosBytesOffset,
        order: image_lib.ChannelOrder.bgra);
    return img;
  }

  // Converts a [CameraImage] in YUV420 format to [imageLib.Image] in RGB format
  static image_lib.Image convertYUV420ToImage(CameraImage cameraImage) {
    final imageWidth = cameraImage.width;
    final imageHeight = cameraImage.height;

    final yBuffer = cameraImage.planes[0].bytes;
    final uBuffer = cameraImage.planes[1].bytes;
    final vBuffer = cameraImage.planes[2].bytes;

    final int yRowStride = cameraImage.planes[0].bytesPerRow;
    final int yPixelStride = cameraImage.planes[0].bytesPerPixel!;

    final int uvRowStride = cameraImage.planes[1].bytesPerRow;
    final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = image_lib.Image(width: imageWidth, height: imageHeight);

    for (int h = 0; h < imageHeight; h++) {
      int uvh = (h / 2).floor();

      for (int w = 0; w < imageWidth; w++) {
        int uvw = (w / 2).floor();

        final yIndex = (h * yRowStride) + (w * yPixelStride);

        // Y plane should have positive values belonging to [0...255]
        final int y = yBuffer[yIndex];

        // U/V Values are subsampled i.e. each pixel in U/V chanel in a
        // YUV_420 image act as chroma value for 4 neighbouring pixels
        final int uvIndex = (uvh * uvRowStride) + (uvw * uvPixelStride);

        // U/V values ideally fall under [-0.5, 0.5] range. To fit them into
        // [0, 255] range they are scaled up and centered to 128.
        // Operation below brings U/V values to [-128, 127].
        final int u = uBuffer[uvIndex];
        final int v = vBuffer[uvIndex];

        // Compute RGB values per formula above.
        int r = (y + v * 1436 / 1024 - 179).round();
        int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
        int b = (y + u * 1814 / 1024 - 227).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        image.setPixelRgb(w, h, r, g, b);
      }
    }
    return image;
  }
}

class AIState extends State<AI> with WidgetsBindingObserver {
  late final Interpreter _interpreter;
  late final List<Tensor> _inputTensors;

  late CameraController controller;
  bool _isProcessing = false;

  final ValueNotifier<int> action = ValueNotifier<int>(0);

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
      _interpreter.allocateTensors();
      _inputTensors = _interpreter.getInputTensors();
      //print(_inputTensors.where((x) => x.name == "image"));
    });
  }

  static getImageMatrix(CameraImage cameraImage) {
    var origImage = ImageUtils.convertCameraImage(cameraImage)!;
    var inputImage = image_lib.copyResize(origImage, width: 224, height: 224);
    final imageMatrix = List.generate(
      inputImage.height,
      (y) => List.generate(
        inputImage.width,
        (x) {
          final pixel = inputImage.getPixel(x, y);
          // normalize -1 to 1
          return [
            (pixel.r - 127.5) / 127.5,
            (pixel.g - 127.5) / 127.5,
            (pixel.b - 127.5) / 127.5
          ];
          //return [pixel.r, pixel.g, pixel.b];
        },
      ),
    );

    return [[imageMatrix]];
  }

  static Map<int, Object> prepareOutput() {
    final outputMap = <int, Object>{};
    return outputMap;
  }

  Future<void> imageAnalysis(CameraImage cameraImage) async {
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;
    //final outputData = prepareOutput();
    // print(_inputTensors);
    //print(_inputTensors.elementAt(60));
    _inputTensors.elementAt(60).setTo(getImageMatrix(cameraImage));
    _interpreter.invoke();
    var output = [List.filled(600, 0.0)];
     _interpreter.getOutputTensors().where((x) => x.name == "StatefulPartitionedCall:0").first.copyTo(output);
    _isProcessing = false;
    if (mounted) {
      setState(() {
        action.value = output[0].indexOf(output[0].reduce(max));
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
          ValueListenableBuilder<int>(
            valueListenable: action,
            builder: (BuildContext context, int value, child) {
              return RichText(
                text: TextSpan(
                  text: value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                )
              );
            },
          ),
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

