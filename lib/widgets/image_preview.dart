import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImagePreview extends StatefulWidget {
   Function saveImage;

   ImagePreview(this.saveImage);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  File? imageFile;

  Future<void> _imagePicker() async {
    final _picker = ImagePicker();
    final _imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (_imageFile==null){
      return;
    }
    
   final _imagePath=File(_imageFile.path);

    setState(() {
      imageFile=_imagePath;
    });

    final _appDir=await sysPath.getApplicationDocumentsDirectory();
    
    final _imageName=path.basename(_imageFile.path);
    final savedImage= await _imagePath.copy('${_appDir.path}/$_imageName');
    print(savedImage);
   widget.saveImage(savedImage);

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 110,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.lightGreen),
          ),
          child: imageFile == null
              ? Center(
                  child: Text(
                    'Chose a Image',
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        // Expanded(
        //   child: FlatButton.icon(
        //     onPressed: _imagePicker,
        //     icon: Icon(
        //       Icons.camera,
        //       color: Theme.of(context).accentColor,
        //     ),
        //     label: Text(
        //       'Chose a Photo',
        //       style: TextStyle(color: Theme.of(context).accentColor),
        //     ),
        //     // color: Theme.of(context).accentColor,
        //   ),
        // ),
      ],
    );
  }
}
