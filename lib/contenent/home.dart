import "package:flutter/material.dart";
import "package:testapp/maps/maps_screen.dart";




class Home extends StatefulWidget{
  @override
  _Home createState() => _Home();
  
  
}

class _Home extends State<Home>{

  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: AppBar(title: Text("home page"),),
        automaticallyImplyLeading: false,
      ),
      body:Column(
        children: [
           HorizontalButtonList(),
           Text("data")
        ],
      )
    );
  }
  
}
class HorizontalButtonList extends StatefulWidget{
  @override
  _HorizontalButtonList createState() => _HorizontalButtonList();

  
}


class _HorizontalButtonList extends State<HorizontalButtonList> {
  @override
  Widget build(BuildContext context) {
    bool _loading = false;
    void _toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }
    return Container(
      height: 60.0, // Hauteur du conteneur parent
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                _toggleLoading();

              },
              child: Text('Button 1'),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                print("sign in with github");
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: MapsScreen(),
                          );
                        },
                      ),
                    );
              },
              child: Text('Button 2'),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Button 3'),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Button 4'),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Button 5'),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Button 6'),
            ),
          ),
          
        ],
      ),
    );
  }
}