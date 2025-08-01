# riverpod_examples

First, Add two dependencies.

1_  riverpod: ^2.6.1                      ----->help to manage the code of providers
import 'package:riverpod/riverpod.dart';

2_  flutter_riverpod: ^2.6.1              ----->to manage providers with widgets like widgets rebuilt
import 'package:flutter_riverpod/flutter_riverpod.dart';


First, wrap the app with ProviderScope() widget.---->It manages the state and scope of all providers 
and their dependencies injections.
Providers are made globally and can be used in any file by import that file.
Syntax:
      final var.name= ProviderType<stateType> ((ref){
               return Initial Value;
      });

In case of "StatelessWidget" the class will extends ConsumerWidget instead of StatelessWidget.
And pass WidgetRef ref in its build method.
In case of "StatefulWidget"  the class will extends ConsumerStatefulWidget and use ConsumerState instead of State
And in this we will not pass WidgetRef ref in its build method.
Use StatefulWidget if init() and dispose() are required otherwise use StateLess Widget.

Wrap the widget with Consumer() Widget in which we use ref.watch bcz ref.watch rebuild the widgets when changes
while ref.read not rebuild. By doing this it rebuild only that widget not the whole tree.

Important:
         Jin Providers ky State ki type 
List      Map       Object
ho gi tu wo phaly new same copy of origionl list,map,object bannay gy phir uss ma changing kary gy phir
wo new copy ref.watch ko assign kary gy bcz provider indepthly check nhi karta balky wo check karta ha
ky ya origioal list,map,object ka address ha ya new ka address aagr origionl ma change kar ky origional 
ko hi ref.read ko assign kary gy tu provider dekhy ga ka ya tu phaly wala hi address tu koi change nhi ay ga.
Aagr origionl ma change kar ky ref.read ko assign karna chaty ho tu [...ref.watch(//).state] ki tarah assign
karna object ky case ma copyWith() use karna ha.