import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';



//Provider ki kisi bhi type ky sath .family lagany sy wo family provider ban jy ga.
//jub hum ny kisi provider ma koi data(int,object,list,map,...) bhejna ho from outside.

//final provider=Provider<String>((ref)=>"Provider");    ya simple ha iss ka family below
final provider=Provider.family<String,int>((ref,no){
  return "Provider "+ no.toString();
});

//oppar int type uss data ki ha jo hum outside sy provider ma bhejy gy.
//urr us data ko provider ma access kary ky liya ref ky sath aik hoor var. ly gy jessy ya no ha.
//ref.watch(provider(data));    ma wo data send karna zarori ho ga.issi tarah ref.read() ma bhi.