import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather/weather.dart'; 
import 'package:intl/intl.dart';

class MapsScreen extends StatefulWidget{
  @override
  _MapsScreenState createState() => _MapsScreenState(); 
}

class _MapsScreenState extends State<MapsScreen> {
  double latitude = 33.028546;
  double longitude = -7.615288;
  var ltn = LatLng(33.028546,  -7.615288);









  String city='Settat';
  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
    
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      ltn = LatLng(latitude, longitude);
      
    });

    print("Latitude: $latitude, Longitude: $longitude");
  }



/*
  @override
  void initState() {
    super.initState();
    _getCountyFromCoordinates(40.7128, -74.0060); // Latitude et longitude de New York
  }

  Future<void> _getCountyFromCoordinates(double latitude, double longitude) async {
    final coordinates = Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      _county = first.subAdminArea; // SubAdminArea est le nom du comté
    });
  }
  */

//text field value 
  String _textfielvalue='';
  var textcontroler= TextEditingController();
  List <String> citys=['Casablanca ', 'Settat' , 'Rabat' ,'Agadir', 'Tangier'];
// weather

late final WeatherFactory _wf;
  Weather? _weather;
  String ville='Settat';
  List<Weather> ?listJours ;

  Future<void> _fetchWeather() async {
    final weather = await _wf.currentWeatherByCityName(city);
    listJours =await _wf.fiveDayForecastByCityName(city);
    
    setState(() {
      _weather = weather;
      latitude=_weather!.latitude!;
      longitude=weather.longitude!;
      ltn = LatLng(latitude, longitude);
      
      
    });
  }
 @override
  void initState() {
    super.initState();
    _wf = WeatherFactory('02fe5db1751abc124603fba64b69ffa9');
    _fetchWeather();
    ltn = LatLng(latitude, longitude);
  }

  //list view jours


  Widget _weatherVilleJours(){

    return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Center(child: Text('${"hello"}')), 
      );
      
      
      
    }
  );

  }

DateTime date = DateTime.now();
 
String dateFormat = DateFormat('EEEE').format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 223, 250),
        actions: [
          IconButton(onPressed :(){}, icon: Icon(Icons.last_page)),
          
        ],
        title:  Text(city),
      ),
      body: Container(

          

        child: 
        
        
        Column(
        
        
        children: [
          /*Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 250, 12),
            ),
            child: FlutterMap(
              options: MapOptions(
                center: ltn, 
                zoom: 10, 
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains:const ['a', 'b', 'c'], 
                  userAgentPackageName: "com.example.fluttergeoloc",
                ),
              ],
            ),
          ),*/

         

          
         ListTile(
          title:  Container(
            
            margin: EdgeInsets.only(left: 10,right: 10),
            child: TextField(
              autofocus: true,
              cursorColor: Colors.orange,
              controller: textcontroler,
              onChanged: (value) {
                setState(() {
                  _textfielvalue = value;
                });
              },
            ),
          ),
          

          trailing: IconButton(onPressed: (){
              if(!citys.contains(_textfielvalue)){
              citys.add(_textfielvalue);
              textcontroler.clear();

             }

          } ,
          
          icon: Icon(Icons.send_outlined)),
          
         ),




          const SizedBox(height: 10,),

           Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration( color: Color.fromARGB(255, 2, 159, 202) ,
            borderRadius: BorderRadius.all(Radius.elliptical(10, 10))
            ),
            width: MediaQuery.of(context).size.height * 0.8,
            height: MediaQuery.of(context).size.height * 0.2,

            child: Column(
                
              	mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                  Image.asset("wt2.png", width: 50,height: 50, ),
                    Text("${_weather!.temperature.toString().split(' ')[0]} °C" 
                      ,style: TextStyle(fontSize: 20),
                    ),
                    
                    ],
                ),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${_weather!.weatherDescription}"),
                Text("min ${_weather!.tempMin.toString().split(' ')[0]}°C    max :${_weather!.tempMax.toString().split(' ')[0]}°C"),
                  ],
                )
                
              ],
            ) ,
          ),
          const SizedBox(height: 10),
          

          
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              Divider(height: 5,);
            return Container(
              margin: EdgeInsets.all(5),
              child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              selectedTileColor: Color.fromARGB(255, 107, 233, 242),
              selected: true,
              
            
            leading: Text( DateFormat('EEEE').format(listJours![index*8].date!)),
            title: Column(
                children: 
                [
                  Text("${listJours![index*8].weatherDescription}"),
                Text("min :${listJours![index*8].tempMin.toString().split(' ')[0]} °C    max :${listJours![index*8].tempMax.toString().split(' ')[0]} °C")
                
                ],
            ),
          ),
            );
            }
)
          
          
          ,
          
          




          /*MaterialButton(
            onPressed: () {
              
              
             
             if(!citys.contains(_textfielvalue)){
              citys.add(_textfielvalue);
             }
             textcontroler.clear();
             

              print("appel au state");
            },
            color: Color.fromARGB(255, 6, 241, 14),
            child: Text("Click"),
            
          ),
          Text("city: $city \nlatitude:$latitude \nLongitude:$longitude \n${_weather!.country}"),
          
          Text("data")*/
          
         
        ],
      ),
      ),

      //drawer 
     drawer: Drawer(
            
      
        child: ListView.builder(


          itemCount: citys.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: IconButton(onPressed: (){

                setState(() {
                  citys.removeAt(index);
                });
                
              }, icon: const Icon(Icons.delete)) ,

              trailing: IconButton(onPressed: (){

                setState(() {
                  city=citys[index];
                  _fetchWeather();
                });
                Navigator.pop(context);
              }, icon: const Icon(Icons.visibility)),
              
              title: Text(citys[index]),
              onTap: () {
                // Ajoutez ici le code pour gérer le tap sur une ville
                // Par exemple, naviguer vers une nouvelle page avec les détails de la ville
                Navigator.pop(context); // Fermer le drawer après avoir sélectionné une ville
              },
            );
          },
        ),
      ),
    );
    
  }
}
