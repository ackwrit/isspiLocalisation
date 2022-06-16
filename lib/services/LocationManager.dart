import 'package:geolocator/geolocator.dart';

class LocationManager {
  //Classe pour les demandes
  
  
  
  //Méthodes
  Future<Position> start() async {
    //Vérifier si l'utilisateur à activer son gps
    final bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    return (locationEnabled) ? await handlePermission(): await errorString("la localisation est désactivée");
  }
  
  Future <Position> handlePermission() async {


    //Vérifier la permission
    LocationPermission locationPermission = await Geolocator.checkPermission();

    return await resultatPermssion(locationPermission);
    
    
  }
  
  Future<Position> resultatPermssion(LocationPermission locationPermission) async {
    switch(locationPermission){
      case LocationPermission.deniedForever : return errorString("l'accès réfusé");
      case LocationPermission.denied : return await request().then((newPermission) =>  resultatPermssion(newPermission));
      case LocationPermission.unableToDetermine : return await request().then((newPermission) => resultatPermssion(newPermission));
      case LocationPermission.always : return await Geolocator.getCurrentPosition();
      case LocationPermission.whileInUse : return await Geolocator.getCurrentPosition();
    }
    
    
  }

  Future<LocationPermission> request() async{
    return await Geolocator.requestPermission();

  }
  
  
  
  
  
  Future<Position> errorString(String err) async => await Future.error(err);
  
  
  

}