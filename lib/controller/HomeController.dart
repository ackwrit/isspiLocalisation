import 'package:cartegpsipssijuin2022/controller/MapScaffold.dart';
import 'package:cartegpsipssijuin2022/controller/NodataController.dart';
import 'package:cartegpsipssijuin2022/services/LocationManager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeControllerState();
  }

}

class HomeControllerState extends State<HomeController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Position>(
        future: LocationManager().start(),
        builder: (context, position){
        if(position.hasData){
          return MapScaffold(maPosition: position.data!,);
        }
        else
          {
            return NoDataController();
          }

        }
    );
  }

}