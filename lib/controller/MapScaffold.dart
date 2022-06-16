import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScaffold extends StatefulWidget {
  Position maPosition;
  MapScaffold({required this.maPosition});



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MapState();
  }

}
class MapState extends State<MapScaffold>{

  //Variable
  late CameraPosition initCamera;
  Completer<GoogleMapController> controllerMap = Completer();
  List<bool>selected = [false,true,false];
  MapType typeCarte = MapType.normal;
  Set<Marker> myMarkers = new Set();
  LatLng tourEiffel = const LatLng(48.858278, 2.29425);
  LatLng montParnasse = const LatLng(48.842036, 2.322128);
  LatLng leLouvre = const LatLng(48.861013, 2.33585);
  BitmapDescriptor newIcon = BitmapDescriptor.defaultMarker;


  // Déclaration
  Future <BitmapDescriptor>changementIcon() async {

    return await BitmapDescriptor.fromAssetImage(ImageConfiguration(),"assets/flame_icon.png");
  }


  @override
  void initState() {
    // TODO: implement initState

    changementIcon();

    super.initState();
  }

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      changementIcon().then((value){
        setState(() {
          newIcon = value;
        });

      });


    initCamera = CameraPosition(target: LatLng(widget.maPosition.latitude,widget.maPosition.longitude),zoom: 10);
    myMarkers.add(
        Marker(
          markerId: const MarkerId("0"),
          position: tourEiffel,
          infoWindow: const InfoWindow(
              title: 'Tour eiffel',
              snippet: 'La dame de fer de Paris'
          ),
          icon: newIcon,

        )
    );

    myMarkers.add(
        Marker(

          markerId: const MarkerId("1"),
          position: montParnasse,
          infoWindow: const InfoWindow(
              title: 'La tour montParnasse',
              snippet: "Elle a tout d'une grande"
          ),
          icon: newIcon,

        )
    );


    myMarkers.add(
        Marker(
          markerId: const MarkerId("2"),
          position: leLouvre,
          infoWindow: const InfoWindow(
              title: 'Le louvre',
              snippet: 'Toujours sublime'
          ),
          icon: newIcon,

        )
    );

    return Scaffold(
      appBar: AppBar(),
      body: bodyPage()

    );
  }

  Widget bodyPage(){
    return Stack(
      children: [
        MyMaps(),
        MyContainer(),
      ],
    );
  }

  Widget MyContainer(){
    return Container(
      padding: const EdgeInsets.only(top: 20,right: 10,left: 10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // Choisirle type de carte satellite , normal , ou hybride
          ToggleButtons(
            borderRadius: BorderRadius.circular(20),
              selectedColor: Colors.grey,
              disabledColor: Colors.white,
              fillColor: Colors.white,





              children: const [
                Text("Satellite"),
                Text("normal"),
                Text("hybride"),

              ],
              isSelected: selected,
            onPressed: (newvalue){
                if(newvalue == 0){
                  setState(() {
                    selected[0] = true;
                    selected[1] = false;
                    selected[2] = false;
                    typeCarte = MapType.satellite;
                  });
                }
                if(newvalue == 1){
                  setState(() {
                    selected[0] = false;
                    selected[1] = true;
                    selected[2] = false;
                    typeCarte = MapType.normal;
                  });
                }
                if(newvalue == 2){
                  setState(() {
                    selected[0] = false;
                    selected[1] = false;
                    selected[2] = true;
                    typeCarte = MapType.hybrid;
                  });
                }

            },
          ),
          const SizedBox(height: 10,),



          //Afficher les coordonnées GPS
          Container(
            padding: EdgeInsets.all(20),
            width: 400,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.pin_drop),
                Text("lat:${widget.maPosition.latitude} - long :${widget.maPosition.longitude}- alt : ${widget.maPosition.altitude}")
              ],
            ),
          ),


        ],
      ),
    );
  }



  Widget MyMaps(){
    return GoogleMap(
        initialCameraPosition: initCamera,
        onMapCreated: (GoogleMapController control) async {
          String styleMap = await DefaultAssetBundle.of(context).loadString("lib/services/style.json");
          control.setMapStyle(styleMap);
          controllerMap.complete(control);
        },
      myLocationEnabled: true,
      mapType: typeCarte,
      myLocationButtonEnabled: false,
      markers: myMarkers,

    );
  }






}