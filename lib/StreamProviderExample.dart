import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';


final streamProvider=StreamProvider<double>((ref)async*
{
  double cp;
  while(true)
  {
    await Future.delayed(Duration(seconds: 1));
    cp=(Random().nextDouble()*4-2);
    yield  double.parse(cp.toStringAsFixed(2));
    //throw "Error";
  }
}
);



class Str extends ConsumerWidget
{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stre=ref.watch(streamProvider);
    return Scaffold(
      body: Center(
        child: Container(
            height: 400,
            width: 400,
            child: stre.when(
              // skipLoadingOnReload: true,
                skipLoadingOnRefresh: false,//ab refresh karny sy loading nazar ay gi.
                data:(number){ //Jo bhi hum stream provider sy return karway gy wo ref.watch sy stre var. then wo data ma aa jy ga.
                        return Center(child: Text(number.toString()));
                },
                error: (error,stack){
                  return TextButton(
                    onPressed: (){ref.invalidate(streamProvider);}, //to refresh
                    child: Text("Error: ${error}"));
                },
                loading: (){return Center(child: CircularProgressIndicator());}
            )
        ),
      ),
    );
  }
}