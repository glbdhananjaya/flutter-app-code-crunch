import 'dart:async';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AR Measurement')),
        body: ARView(),
      ),
    );
  }
}

class ARView extends StatefulWidget {
  @override
  _ARViewState createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ARKitSceneView(
      onARKitViewCreated: onARKitViewCreated,
      configuration: ARKitConfiguration(
        planeDetection: ARPlaneDetection.horizontal,
        worldAlignment: ARWorldAlignment.gravity,
      ),
      onTap: onARTapHandler,
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
  }

  Future<void> onARTapHandler(List<ARKitTestResult> hits) async {
    for (var hit in hits) {
      // Create a cube and add it to the scene
      final cube = ARKitNode(
        geometry: ARKitBox(
          width: 0.1,
          height: 0.1,
          length: 0.1,
          chamferRadius: 0.01,
        ),
        position: hit.worldTransform.getColumn(3),
        eulerAngles: vector3(0, 0, 0),
      );

      arkitController.add(cube);

      // Remove the cube after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        arkitController.remove(cube);
      });
    }
  }
}
