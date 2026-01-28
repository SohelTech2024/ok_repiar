class Environment {
  static const String apiBaseUrl = 'https://api.managemyshoppe.com/v1';
  static const String appName = 'Manage My Shoppe';
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
}