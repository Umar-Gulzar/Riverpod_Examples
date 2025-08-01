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
    it.add(i);
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
    List<Item> filtered=[];
    for(int i=0;i<state.allItems.length;i++)
    {
      if(state.allItems[i].item.toLowerCase().contains(name.toLowerCase())==true)
        filtered.add(state.allItems[i]);
    }
    state=state.copyWith(fillteredItem: filtered);
  }
}