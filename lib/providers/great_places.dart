import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String title, File image) {
    Place newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
    );
    
    
    _places.add(newPlace);
    notifyListeners();
    DbHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }


Future<void> fetchandSetDb()async{
 final dataList=await DbHelper.fetchDb('places');

final placesList= dataList.map((place){
  return Place(id: place['id'], title: place['title'], image: File(place['image'],),);
 }).toList();

_places=placesList;
notifyListeners();
}
}
