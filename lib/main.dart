import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ProviderExample.dart';
import 'StateNotifierProviderExample.dart';
import 'StateProviderExample.dart';

void main()
{
  runApp( ProviderScope(
    child: MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,          // Primary color
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,          // Defines all shades
        ),),
      title: "Form",
      debugShowCheckedModeBanner: false,
      home: Example3(),
    ),
  ));
}


