import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart'; // for WriteBuffer
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart'; // for InputImageData, BarcodeScanner

class AdminScanPage extends StatefulWidget {
  const AdminScanPage({super.key});

  @override
  _AdminScanPageState createState() => _AdminScanPageState();
}

class _AdminScanPageState extends State<AdminScanPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCameraReady = false;
  final BarcodeScanner barcodeScanner = BarcodeScanner();
  bool isProcessing = false; // To prevent double scans

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
      enableAudio: false, // Optional: You don’t need audio
    );

    await _cameraController!.initialize();
    if (!mounted) return;
    setState(() {
      isCameraReady = true;
    });

    // ✅ Start image stream for scanning
    _cameraController!.startImageStream((CameraImage image) {
      if (!isProcessing) {
        isProcessing = true;
        processCameraImage(image); // 🔥 Call your barcode scan here
      }
    });
  }

  Future<void> processCameraImage(CameraImage image) async {
    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize =
          Size(image.width.toDouble(), image.height.toDouble());

      // ✅ Use InputImageMetadata instead of InputImageData
      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: imageSize,
          rotation: InputImageRotation.rotation0deg, // Adjust this if needed
          format: InputImageFormat.yuv420,
          bytesPerRow: image.planes.first.bytesPerRow,
        ),
      );

      // ✅ Process the image with MLKit
      final barcodes = await barcodeScanner.processImage(inputImage);

      if (barcodes.isNotEmpty) {
        final scannedUser = barcodes.first.rawValue;
        print('✅ Scanned User Data: $scannedUser');

        // ✅ Identify which gym the admin is scanning for
        final adminEmail = FirebaseAuth.instance.currentUser?.email;
        final gymId = getGymIdFromAdmin(adminEmail);

        if (gymId.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('gyms')
              .doc(gymId)
              .update({
            'curOccupancy': FieldValue.increment(1),
          });

          // ✅ Optional: Log the user check-in if needed
          await FirebaseFirestore.instance
              .collection('gyms')
              .doc(gymId)
              .collection('checkIns')
              .add({
            'userId': scannedUser,
            'timestamp': FieldValue.serverTimestamp(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Check-in successful at $gymId')),
          );

          await _cameraController
              ?.stopImageStream(); // Stop scanning after success
        }
      }
    } catch (e) {
      print('Error during barcode scan: $e');
    } finally {
      isProcessing = false;
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    barcodeScanner.close();
    super.dispose();
  }

  String getGymIdFromAdmin(String? email) {
    switch (email) {
      case 'tempeadmin@gmail.com':
        return 'tempe';
      case 'scottsdaleadmin@gmail.com':
        return 'scottsdale';
      case 'phoenixadmin@gmail.com':
        return 'phoenix';
      case 'peoriaadmin@gmail.com':
        return 'peoria';
      case 'mesaadmin@gmail.com':
        return 'mesa';
      case 'glendaleadmin@gmail.com':
        return 'glendale';
      case 'gilbertadmin@gmail.com':
        return 'gilbert';
      case 'chandleradmin@gmail.com':
        return 'chandler';
      default:
        return '';
    }
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
