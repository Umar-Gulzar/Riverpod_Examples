import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'FutureProviderExample.dart';
import 'ProviderExample.dart';
import 'StateNotifierProviderExample.dart';
import 'StateProviderExample.dart';
import 'FavouriteApp.dart';
import 'StreamProviderExample.dart';

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
      home: Str(),
    ),
  ));
}


