import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:math';

final show=Provider<String>((ref)     //This Provider is for only Read Data in whole app.
{
  return "Flutter";
}
);
final showNo=Provider<int>((ref)     //This Provider is for only Read Data in whole app.
{
  return 5;
}
);

class Example1 extends ConsumerWidget
{
  const Example1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name=ref.watch(show);
    final no=ref.watch(showNo);

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          height: 400,
          width: 400,
          child: Text(name+' '+'$no',style: TextStyle(color: Colors.black,fontSize: 50),),

        ),
      ),
    );
  }
}