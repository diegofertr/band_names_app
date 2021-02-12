import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band( id: '1', name: 'Metallica', votes: 6 ),
    Band( id: '2', name: 'Queen', votes: 1 ),
    Band( id: '3', name: 'Heroes del Silencio', votes: 2 ),
    Band( id: '4', name: 'The Strokes', votes: 5 )
  ];

  // final _controllerInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle( color: Colors.black87 )),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( context , i ) => _bandTile( bands[i] )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        elevation: 1,
        onPressed: addNewBand
        // onPressed: () {
          // showCupertinoDialog(
          //   context: context, builder: (BuildContext context) {
          //     return CupertinoAlertDialog(
          //       title: Text('New Band'),
          //       actions: [
          //         TextButton.icon(
          //           icon: Icon( Icons.cancel ),
          //           label: Text('Cancel'),
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           }
          //         ),
          //         TextButton.icon(
          //           icon: Icon( Icons.save ),
          //           label: Text('Save Band'),
          //           onPressed: () {
          //             print('Saving band');
          //             print(_controllerInput.text);
          //             final newBand = Band(
          //               id: '${bands.length + 1}',
          //               name: _controllerInput.text,
          //               votes: 0
          //             );

          //             setState(() {
          //               bands.add(newBand);
          //               _controllerInput.clear();
          //             });

          //             Navigator.of(context).pop();
          //           }
          //         ),
          //       ],
          //       // content: Text('Input dialog'),
          //       content: CupertinoTextField(
          //         controller: _controllerInput,
          //       ),
          //     );
          //   },
          // );
        // },
      ),
    );
  }

  Widget _bandTile( Band band ) {
    return Dismissible(
      key: Key( band.id ),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ) {
        print( direction );
        print(' id: ${band.id} ');
        // TODO: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle( color: Colors.white ))
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text( band.name.substring(0, 2) ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text( band.name ),
        trailing: Text( '${ band.votes }', style: TextStyle( fontSize: 20 ) ),
        onTap: () {
          print( band.name );
        },
      ),
    );
  }

  addNewBand() {

    final textController = new TextEditingController();

    if ( Platform.isAndroid ) {
      return showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text( 'New Band' ),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList( textController.text )
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text( 'New Band' ),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList( textController.text ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context)
            )
          ],
        );
      }
    );

  }


  void addBandToList( String name ) {
    print( name );
    if (name.length > 1) {
      this.bands.add( new Band(
        id: DateTime.now().toString(),
        name: name,
        votes: 0
      ) );

      setState(() {});
    }

    Navigator.pop(context);

  }

}