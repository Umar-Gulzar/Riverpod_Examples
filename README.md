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

Wrap the widget with Consumer() Widget in which we use ref.watch bcz ref.watch rebuild the widgets while
ref.read not rebuild. By doing this it rebuild only that widget not the whole tree.