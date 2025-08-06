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
   // List<Item> it=[...state.allItems];
    List<Item> it=[
      Item(item:"Apple",id:1,isFavourite:true),
      Item(item:"Banana",id:2,isFavourite:false),
      Item(item:"Orange",id:3,isFavourite:false),
      Item(item:"Grapes",id:4,isFavourite:true),
      Item(item:"Mango",id:5,isFavourite:false),
      Item(item:"Tomato",id:6,isFavourite:true),
    ];
   // it.add(i);
    state=state.copyWith(allItem:it,fillteredItem: it);
  }
  void deleteItem(int id)
  {
    List<Item> it=[...state.fillteredItems];
    it.removeWhere((Item)=>Item.id==id);
    state=state.copyWith(fillteredItem:it,allItem: it);
  }
  void favList()
  {
    List<Item> favIt=state.allItems.where((Item)=>Item.isFavourite==true).toList();
    state=state.copyWith(favItem: favIt);
  }
  void setFavourite(int i,bool v)
  {
    int index1=state.fillteredItems.indexWhere((Item)=>Item.id==i);
    List<Item> it1=[...state.fillteredItems];
    it1[index1]= state.fillteredItems[index1].copyWith(fav: v);

    int index2=state.allItems.indexWhere((Item)=>Item.id==i);
    List<Item> it2=[...state.allItems];
    it2[index2]= state.allItems[index2].copyWith(fav: v);

    state=state.copyWith(fillteredItem: it1,allItem: it2);
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


class Fav extends ConsumerStatefulWidget
{
  ConsumerState<Fav> createState()=>FavState();
}
class FavState extends ConsumerState<Fav>
{

  @override
  void initState() {


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final data=ref.watch(favouriteProvider.select((state)=>state.fillteredItems));
    final fa=ref.watch(favouriteProvider.select((state)=>state.favouriteItems));
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          TextFormField(
            onChanged: (v){ref.read(favouriteProvider.notifier).filter(v);},
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search",
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
            child: ListView.builder(
              itemCount:data.length,
                itemBuilder: (context,index)
                {
                  return ListTile(
                    title: Text(data[index].item),
                    trailing: IconButton(
                      onPressed: (){
                        final v;
                        if(data[index].isFavourite==true)
                          v=false;
                        else
                          v=true;
                        ref.read(favouriteProvider.notifier).setFavourite(data[index].id, v);
                      },
                      icon: Icon(
                        data[index].isFavourite?Icons.favorite:Icons.favorite_border,
                      ),
                    ),
                    leading: TextButton(onPressed: () {
                      ref.read(favouriteProvider.notifier).deleteItem(data[index].id);
                    },
                     child:Icon(Icons.delete)),
                  );
                }
                  ),
          ),
          FloatingActionButton(onPressed: (){
            ref.read(favouriteProvider.notifier).addItem(Item(item: "A", id: 0, isFavourite: false));
          },
          child: Icon(Icons.add),
          ),

          Expanded(
            child: ListView.builder(
                itemCount:fa.length,
                itemBuilder: (context,index)
                {
                  return ListTile(
                    title: Text(fa[index].item),
                    trailing: IconButton(
                      onPressed: (){
                        final v;
                        if(fa[index].isFavourite==true)
                          v=false;
                        else
                          v=true;
                        ref.read(favouriteProvider.notifier).setFavourite(fa[index].id, v);
                      },
                      icon: Icon(
                        fa[index].isFavourite?Icons.favorite:Icons.favorite_border,
                      ),
                    ),
                  );
                }
            ),
          ),

          FloatingActionButton(onPressed: (){
            ref.read(favouriteProvider.notifier).favList();
          },
            child: Icon(Icons.favorite),
          ),
        ],
      )
    );
  }
}
