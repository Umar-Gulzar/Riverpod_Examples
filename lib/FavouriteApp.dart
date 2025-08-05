import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final favouriteProvider=StateNotifierProvider<FavouriteNotifier,FavouriteState>((ref)
{
  return FavouriteNotifier();
}
);


class Item
{
  final String item;
  final int id;
  final bool isFavourite;
  Item({required this.item,required this.id,required this.isFavourite});
  Item copyWith({String? it, int? i,bool? fav})
  {
    return Item(
      id: i??this.id,
      item: it??this.item,
      isFavourite: fav??this.isFavourite
    );
  }
}

class FavouriteState
{
  final List<Item> allItems;
  final List<Item> fillteredItems;
  final List<Item> favouriteItems;
  FavouriteState({required this.allItems,required this.fillteredItems,required this.favouriteItems});
  FavouriteState copyWith({List<Item>? allItem, List<Item>? fillteredItem,List<Item>? favItem})
  {
    return FavouriteState(
        allItems: allItem??this.allItems,
        fillteredItems: fillteredItem??this.fillteredItems,
      favouriteItems: favItem??this.favouriteItems
    );
  }
}

class FavouriteNotifier extends StateNotifier<FavouriteState>
{
  FavouriteNotifier():super(FavouriteState(allItems: [], fillteredItems: [],favouriteItems: []));

  void addItem(Item i)
  {
    List<Item> it=[...state.allItems];
    it=[
      Item(item:"Apple",id:1,isFavourite:true),
      Item(item:"Banana",id:2,isFavourite:false),
      Item(item:"Orange",id:3,isFavourite:false),
      Item(item:"Grapes",id:4,isFavourite:true),
      Item(item:"Mango",id:5,isFavourite:false),
      Item(item:"Tomato",id:6,isFavourite:true),
    ];
   // it.add(i);
    state=state.copyWith(allItem:it);
  }
  void deleteItem(int id)
  {
    List<Item> it=[...state.allItems];
    it.removeWhere((Item)=>Item.id==id);
    state=state.copyWith(allItem:it);
  }
  void favList()
  {
    List<Item> favIt=[];
    for(int i=0;i<state.allItems.length;i++)
      {
        if(state.allItems[i].isFavourite==true)
          favIt.add(state.allItems[i]);
      }
    state=state.copyWith(favItem: favIt);
  }
  void setFavourite(int id,bool v)
  {
    int index=state.allItems.indexWhere((Item)=>Item.id==id);
    state.allItems[index].copyWith(fav: v);
  }
  void filter(String name)
  {
    if(name.isEmpty)
      state=state.copyWith(fillteredItem: state.allItems);
    else
    {
      List<Item> filtered = [];
      for (int i = 0; i < state.allItems.length; i++) {
        if (state.allItems[i].item.toLowerCase().contains(name.toLowerCase()) ==
            true)
          filtered.add(state.allItems[i]);
      }
      state = state.copyWith(fillteredItem: filtered);
    }
  }
}


class Fav extends ConsumerWidget
{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data=ref.watch(favouriteProvider.select((state)=>state.fillteredItems));
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount:data.length ,
            itemBuilder: (context,index)
            {
              return ListTile(
                title: Text(data[index].item),
                trailing: Icon(
                  data[index].isFavourite?Icons.favorite:Icons.favorite_border,
                ),
                leading: TextButton(onPressed: () {
                  ref.read(favouriteProvider.notifier).deleteItem(data[index].id);
                },
                 child:Icon(Icons.delete)),
              );
            }
      ),
    );
  }
}
