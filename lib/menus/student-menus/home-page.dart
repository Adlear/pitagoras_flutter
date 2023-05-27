import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          width: 500,
          child: Padding(
            padding: EdgeInsets.only(top: 100, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Center( child:Text(
                  'Retos Disponibles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      buildCard('Principiante'),
                      buildCard('Intermedio'),
                      buildCard('Avanzado'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(String level) {
    return Card(
      child: Container(
        height: 200,
        child: Center(
          child: Text(
            level,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
