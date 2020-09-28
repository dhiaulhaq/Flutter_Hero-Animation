import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(home: FirstPage());
  }
}

class FirstPage extends StatelessWidget{
  final List<Map<String, dynamic>> _kategori = [
    {'cat': 'Flutter', 'color': Colors.pink},
    {'cat': 'Laravel', 'color': Colors.blue},
    {'cat': 'Vue.js', 'color': Colors.amber},
    {'cat': 'Javascript', 'color': Colors.yellow},
    {'cat': 'PHP', 'color': Colors.red},
    {'cat': 'Java', 'color': Colors.black},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grid View'),
        ),
        body: Container(
          margin: const EdgeInsets.all(10.0),
          child: GridView.builder(
              itemCount: _kategori.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1
              ),
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SecondPage(
                          _kategori[index]['color'],
                          _kategori[index]['cat'],
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: _kategori[index]['cat'],
                    child: ClipPath(
                      clipper: ClipperContainer(),
                      child: Container(
                        color: _kategori[index]['color'],
                        height: 200,
                        child: Center(
                          child: Text(
                            _kategori[index]['cat'],
                            style: TextStyle(
                              color: _kategori[index]['cat'] != 'Javascript'
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}

class ClipperContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.width / 2, size.height, size.width);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class SecondPage extends StatelessWidget{
  final Color _color;
  final String _title;

  SecondPage(this._color, this._title);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Animation'),
      ),
      body: Container(
        child: Hero(
          tag: _title,
          child: ClipPath(
            clipper: ClipperContainer(),
            child: Container(
              color: _color,
              height: 450,
              child: Center(
                child: Text(
                  _title,
                  style: TextStyle(
                    color:
                      _title != 'Javascript' ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}