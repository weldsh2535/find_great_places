import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_places_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetchandSetDb(),
        builder: (ctx, state) =>
            state.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'There are no great places yet, Start adding some!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // RaisedButton.icon(
                          //   onPressed: () {
                          //     Navigator.of(context)
                          //         .pushNamed(AddPlaceScreen.routName);
                          //   },
                          //   icon: Icon(Icons.add),
                          //   label: Text('Add Places'),
                          //   color: Theme.of(context).accentColor,
                          //   textColor: Colors.white,
                          // ),
                        ],
                      ),
                    ),
                    builder: (context, gP, ch) {
                      final bool isEmpty = gP.places.length <= 0;
                      if (isEmpty) {
                        return ch!;
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: gP.places.length,
                            itemBuilder: (ctx, i) {
                              print(gP.places[i].title);
                              return Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            FileImage(gP.places[i].image),
                                      ),
                                      title: Text(gP.places[i].title),
                                      onTap: () {},
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            }),
                      );
                    },
                  ),
      ),
    );
  }
}
