import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:math';

                       //Important
//Aagr StateProvider sy multiple States ko handle karna ho tu
//class with copyWith method banao aur uss class ka object StateProvider ki state ki type rakh do.
//ref.watch sy object mil jy ga. ref.read().state.objectproperty=//;
// Lakin hum StateNotifierProvider sy hi assa kary gy.


final counter=StateProvider<int>((ref)
{
  return 0;
}
);
final switcher=StateProvider<bool>((ref)
{
  return false;
}
);
final cheBox=StateProvider<List<bool>>((ref)=>List.filled(4,false));

//final List<StateProvider<bool>> box=List.filled(4, StateProvider<bool>((ref)=>false));



class Example2 extends ConsumerStatefulWidget
{
  ConsumerState<Example2> createState()=>Example2State();
}
class Example2State extends ConsumerState<Example2>
{
  @override
  Widget build(BuildContext context) {
    print("Build 1");

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        ref.read(counter.notifier).state++;
      }),
      body: Center(
        child: Column(
          children:[ Container(
            color: Colors.grey,
            height: 400,
            width: 400,
            child: Center(
                child: Consumer(
                  builder: (context,ref,child){
                    final count=ref.watch(counter);
                    print("Build 2");
                    return Text('$count',style: TextStyle(color: Colors.black,fontSize: 50),);
                  }
            ),
          ),
                ),

            Consumer(
                builder: (context,ref,child){
                  return Switch(value: ref.watch(switcher), onChanged: (b){
                    ref.read(switcher.notifier).state=b;
                  });
                }),

            SizedBox(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemCount: 4,
                  itemBuilder: (context,index) {
                   return  Consumer(
                     builder: (context,ref,child){
                       final v=ref.watch(cheBox);
                       return CheckboxListTile.adaptive(value: v[index], onChanged: (b) {
                         ref.read(cheBox.notifier).state[index]=b!;
                         ref.read(cheBox.notifier).state=[...ref.read(cheBox.notifier).state];
                       });
                     }
                     );
                  }
              ),
            ),



       ] ),
      ));
  }
}