import 'package:api_without_model/screen/home_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'belajar',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.amber),
    home: const HomeScreen(),    
  ));
}

