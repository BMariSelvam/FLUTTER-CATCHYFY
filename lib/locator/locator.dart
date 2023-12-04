import 'cart_service.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<CartService>(CartService());
}
