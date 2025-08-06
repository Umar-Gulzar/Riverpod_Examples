import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final futureProvider=FutureProvider<List<int>>((ref)async
{
  //In case Api here we will http.get(uri.parse(url)) then decode api and then return data;
  //Future function wala sara kaam yaha karns.

  await Future.delayed(Duration(seconds: 1));
   return [1,2,3,4,5];
 // return await 2;
}
);

class Fut extends ConsumerWidget
{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final api=ref.watch(futureProvider);
    return Scaffold(
      body: Center(
        child: Container(
            height: 400,
          width: 400,
          child: api.when(
           // skipLoadingOnReload: true,
            skipLoadingOnRefresh: false,//ab refresh karny sy loading nazar ay gi.
              data:(number){ //Jo bhi hum future provider sy return karway gy wo ref.watch sy api var. then wo data ma aa jy ga.
                return ListView.builder(
                  itemCount: number.length,
                  itemBuilder:(context,index)
                  {
                    return ListTile(
                    title:Text(number[index].toString()),
                  );}
                );
              } ,
              error: (error,stack){
              return TextButton(
                onPressed: (){ref.invalidate(futureProvider);}, //to refresh
                  child: Text("Error: ${error}"));
              },
              loading: (){return Center(child: CircularProgressIndicator());}
          )
        ),
      ),
    );
  }
}