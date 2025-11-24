import 'package:get/get.dart';
import '../services/local_db_service.dart';
import '../services/seed_loader.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SeedLoader>(SeedLoader(), permanent: true);
    Get.put<LocalDbService>(LocalDbService.instance, permanent: true);
  }
}

