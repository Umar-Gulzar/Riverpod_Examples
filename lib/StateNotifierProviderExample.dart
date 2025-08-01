import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';


//<StateNotifier,state>
final searchProvider=StateNotifierProvider<SearchNotifier,Search>((ref)
{
  return SearchNotifier();
  //return StateNotifier object
}
);

class SearchNotifier extends StateNotifier<Search>// StateNotifier<State type>
{
  SearchNotifier():super(Search(name: "Unknown",rollNo: 0));

  void setName(String na)
  {                        //yaha state object ha tu directly value change nhi kar sakty balky new
                           //object ma copyWith method sy change karwa kar
    state=state.copyWith(n:na);
  }
  String getName()
  {
    return state._name!;
  }
  void setRollNo(int ro)
  {
    state=state.copyWith(r:ro);
  }
  int getRollNo()
  {
    return state._rollNo!;
  }

}
class Search
{
  final String? _name;
  final int? _rollNo;
  Search({String? name,int? rollNo}) : _rollNo = rollNo, _name = name;

  Search copyWith({String? n,int? r})
  {
   return Search(
     name: n??this._name,
     rollNo: r??this._rollNo
   );
  }

}


class Example3 extends ConsumerWidget
{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color:Colors.grey,
        height: 300,
        width: 300,
        child: Column(
          children:[ Center(
            child: Consumer(
              builder: (context,ref,child)
              { return TextField(
                onChanged: (v)
                {
                  ref.read(searchProvider.notifier).setName(v);
                },
              );}
            ),
          ),

            Consumer(
              builder: (context,ref,child)
                  {
                    final n=ref.watch(searchProvider.select((state)=>state._name));
                    final r=ref.watch(searchProvider.select((state)=>state._rollNo));
                   // final nr=ref.watch(searchProvider);
                    return Text(n!+"  ${r}");
                  }
            ),


       ] ),
      ),
    );
  }
}