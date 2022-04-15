import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/config/theme.dart';
import '/config/app_router.dart';
import '/blocs/blocs.dart';
import '/repositories/repositories.dart';
import '/screens/screens.dart';
import '/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Firebase.apps.isNotEmpty) {
  //   await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //       apiKey: "AIzaSyBNt06hgN15qAqjJIN2ffYf0VdDYBPB3qM",
  //       appId: "1:1053411560940:ios:29ff3549213e00ffc604c9",
  //       messagingSenderId: "1053411560940",
  //       projectId: "flutter-ecommerce-app-e1da3",
  //     ),
  //   );
  // } else {
  //   Firebase.initializeApp();
  // }
  await Firebase.initializeApp();
  runApp(MyApp());
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freshy',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CartBloc()..add(LoadCart()),
          ),
          BlocProvider(
            create: (_) => PaymentBloc()
              ..add(
                LoadPaymentMethod(),
              ),
          ),
          BlocProvider(
            create: (context) => CheckoutBloc(
              cartBloc: context.read<CartBloc>(),
              paymentBloc: context.read<PaymentBloc>(),
              checkoutRepository: CheckoutRepository(),
            ),
          ),
          BlocProvider(
            create: (_) => WishlistBloc(
              localStorageRepository: LocalStorageRepository(),
            )..add(
                StartWishlist(),
              ),
          ),
          BlocProvider(
            create: (_) => CategoryBloc(
              categoryRepository: CategoryRepository(),
            )..add(LoadCategories()),
          ),
          BlocProvider(
            create: (_) => ProductBloc(
              productRepository: ProductRepository(),
            )..add(LoadProducts()),
          ),
        ],
        child: MaterialApp(
          title: 'Freshy',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
