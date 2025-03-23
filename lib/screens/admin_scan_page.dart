import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class AdminScanPage extends StatefulWidget {
  const AdminScanPage({super.key});

  @override
  _AdminScanPageState createState() => _AdminScanPageState();
}

class _AdminScanPageState extends State<AdminScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras![0],
      ResolutionPreset.medium,
    );

    await _cameraController!.initialize();
    if (!mounted) return;
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D7815),
        centerTitle: true,
        elevation: 2,
        title: const Text(
          'Az Canyon College',
          style: TextStyle(
            fontFamily: 'Inter Tight',
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: isCameraReady
          ? CameraPreview(_cameraController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
