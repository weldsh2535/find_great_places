import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../widgets/image_preview.dart';
import '../widgets/locaton_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late File? _pickedImage;

  void saveImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void savePlace() {
    bool val = _form.currentState!.validate();
    if (_titleController.text.isEmpty || _pickedImage==null) {
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Please provide all the contents!'),
      //   ),
      // );
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
    );

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
        actions: [
          IconButton(
            onPressed: savePlace,
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Form(
                    key: _form,
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImagePreview(saveImage),
                  SizedBox(height: 4,),
                  LocationInput(),
                ],
              ),
            ),
          )),
          // RaisedButton.icon(
          //   onPressed: savePlace,
          //   icon: Icon(Icons.add),
          //   label: Text('Add Place'),
          //   elevation: 0,
          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   color: Theme.of(context).accentColor,
          //   textColor: Colors.white,
          // ),
        ],
      ),
    );
  }
}
