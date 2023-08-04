import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return {"message": "Tidak dapat mengambil gps", "error": false};
    // return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return {"message": "Izin menggunakan gps ditolak", "error": false};
      // return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return {
      "message": "Settingan hp kamu tidak memperbolehkan mengakses gps",
      "error": true
    };
    // return Future.error(
    //     'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return {
    "position": position,
    "message": "Berhasil mendapatkan posisi device",
    "error": false
  };
}

Future<bool> checkArea() async {
  Map<String, dynamic> dataResponse = await determinePosition();

  if (dataResponse["error"]) {
    return false;
  }

  Position position = dataResponse["position"];
  double distance = Geolocator.distanceBetween(
      -7.589281, 110.7422753, position.latitude, position.longitude);

  if (distance <= 300) {
    return true;
  } else {
    return false;
  }
}

Future<String> uploadFile(XFile pickFile) async {
  UploadTask? uploadTask;
  DateTime now = DateTime.now();
  late String urlPhoto;
  final path = 'attedances/${pickFile.name + now.toIso8601String()}';
  final file = File(pickFile.path);

  try {
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putData(file.readAsBytesSync());

    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    urlPhoto = urlDownload;

    uploadTask = null;
  } on FirebaseException catch (_) {}

  return urlPhoto;
}

Future<XFile?> pickImage() async {
  final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.camera);
  return image;
}

Future<bool> detectFace(File pickedImage) async {
  // input image
  final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(pickedImage);
  final FaceDetector faceDetector = GoogleVision.instance.faceDetector();
  final List<Face> faces = await faceDetector.processImage(visionImage);
  // final List<Face> faces = await faceDetector.processImage(inputImage);
  if (faces.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
