import 'package:flutter/material.dart';

import 'graphs.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Color.fromARGB(255, 18, 32, 47),
            backgroundColor: Colors.blue[800],
            bottom: TabBar(
              tabs: [
                // Tab(icon: Icon(Icons.directions_car)),
                Tab(text: 'Summary'),

                Tab(text: 'Graph'),
              ],
            ),
            title: Text('ECE 252'),
          ),
          body: TabBarView(
            children: [
              GraphPage(),
              GraphPage(),
            ],
          ),
        ),
      ),
    );
  }
}
