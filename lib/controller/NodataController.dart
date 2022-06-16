import 'package:flutter/material.dart';


class NoDataController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoDataControllerState();
  }

}
class NoDataControllerState extends State<NoDataController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Aucune donnée",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
    );
  }

}