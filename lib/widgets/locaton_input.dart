import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
    String _locationPreviewUrl ='';

Future<void> _userCurrentLocationData() async{
  final location= await Location().getLocation();
  print(location.latitude);
  print(location.longitude);
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.greenAccent),
          ),
          alignment: Alignment.center,
          child: _locationPreviewUrl==''
              ? Text(
                  'Input a location!',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _locationPreviewUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // FlatButton.icon(
            //   onPressed: () {},
            //   icon: Icon(Icons.location_on),
            //   label: Text('Curent location'),
            //   textColor: Theme.of(context).accentColor,
            // ),
            // FlatButton.icon(
            //   onPressed: () {},
            //   icon: Icon(Icons.map),
            //   label: Text('Pick a location'),
            //   textColor: Theme.of(context).accentColor,
            // ),
          ],
        )
      ],
    );
  }
}
