import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArMeasurementScreen extends StatefulWidget{
  @override
  _ArMeasurementScreenState createState() => _ArMeasurementScreenState();
}

class _ArMeasurementScreenState extends State<ArMeasurementScreen>
{
  late ARKitController arKitController;
  late ARKitPlane plane;
  late ARKitNode node;
  late vector.Vector3 lastPosition;
  late String anchorId;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: "Distance Tracker App",),
    body: Container(

    ),
  );


  void addAnchor(ARKitAnchor anchor)
  {
    if(!(anchor is ARKitPlaneAnchor))
      {
        return;
      }
    addPlane();
  }
  void addPlane(ARKitController, ARKitPlaneAnchor anchor)
  {
    anchorId = anchor.identifier;

    plane = ARKitPlane(
      width: anchor.extent.x,
      height: anchor.extent.z,
      materials:
      [
        ARKitMaterial(
          transparency: 0.5,
          diffuse: ARKitMaterialProperty(vector.Colors.white,),
        ),
      ],
    );

    node = ARKitNode(
      geometry: plane,
      position: vector.Vector3(anchor.center.x, 0, anchor.center.z),
      rotation: vector.Vector4(1, 0, 0, -math.pi/2),
    );

  }
}

