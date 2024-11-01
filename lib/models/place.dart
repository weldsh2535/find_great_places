import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlaceHolder{
  final double? latitude;
  final double? logtitude;
  final String? address;

  PlaceHolder([
     this.latitude,
     this.logtitude,
    this.address,
  ]);
}

class Place{
  final String id;
  final String title;
  final PlaceHolder? location;
  final File image;

Place({
  required this.id,
  required this.title,
   this.location,
  required this.image,
});
}