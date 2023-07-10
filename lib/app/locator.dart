import 'package:coba_stacked/services/todos_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

/// Register services.
setupLocator() {
  locator.registerLazySingleton(() => TodosService());
}