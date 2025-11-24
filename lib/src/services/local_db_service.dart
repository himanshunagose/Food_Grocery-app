import 'package:hive_flutter/hive_flutter.dart';

class LocalDbService {
  LocalDbService._();

  static final LocalDbService instance = LocalDbService._();

  late Box<dynamic> cartBox;
  late Box<dynamic> ordersBox;
  late Box<dynamic> userBox;

  Future<void> init() async {
    cartBox = await Hive.openBox('cart');
    ordersBox = await Hive.openBox('orders');
    userBox = await Hive.openBox('user');
  }

  Future<void> clearAll() async {
    await cartBox.clear();
    await ordersBox.clear();
    await userBox.clear();
  }
}

