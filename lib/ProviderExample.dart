import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';


final show=Provider<String>((ref)     //This Provider is for only Read Data in whole app.
{
  return "Flutter";
}
);

class Example1 extends ConsumerWidget
{
  const Example1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name=ref.watch(show);
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          height: 400,
          width: 400,
          child: Text(name,style: TextStyle(color: Colors.black,fontSize: 50),),

        ),
      ),
    );
  }
}