class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);

  //IP for iPhone
  static const String baseUrl = "http://192.168.1.72:6000/api";

  static const String imageUrl = "http://192.168.1.72:6000/uploads";

  //Auth Endpoints

  static const String login = '/user/login';
  static const String register = '/user/register';

  static const String uploadImage = "/uploadImage";

  static const String category = '/category?search=&page=1&size=50';

  static const String product = '/products';
  static const String reviews = '/review/product/';

  static const String cart = '/cart/my-cart';

  static const String addCart = '/cart/add';
  static const String updateItem = '/cart/update';

  static const String profile = '/user/';
  static const String uploadPP = '/users/upload-pp';
  static const String updateProfile = '/user/update-profile';
}
