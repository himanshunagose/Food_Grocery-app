import 'package:get/get.dart';
import '../modules/admin/admin_screens.dart';
import '../modules/auth/auth_screens.dart';
import '../modules/cart/cart_screen.dart';
import '../modules/checkout/checkout_screens.dart';
import '../modules/grocery/grocery_screens.dart';
import '../modules/home/home_screen.dart';
import '../modules/onboarding/language_screen.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/orders/orders_screens.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/restaurant/restaurant_detail_screen.dart';
import '../modules/search/search_screen.dart';
import '../modules/settings/settings_screen.dart';
import '../modules/splash/splash_screen.dart';
import '../modules/product/product_detail_screen.dart';
import '../modules/payment/payment_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final pages = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.language, page: () => const LanguageSelectionScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: AppRoutes.otp, page: () => const OtpVerifyScreen()),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.restaurantDetail, page: () => const RestaurantDetailScreen()),
    GetPage(name: AppRoutes.grocery, page: () => const GroceryListingScreen()),
    GetPage(name: AppRoutes.productDetail, page: () => const ProductDetailScreen()),
    GetPage(name: AppRoutes.cart, page: () => const CartScreen()),
    GetPage(name: AppRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: AppRoutes.payment, page: () => const PaymentScreen()),
    GetPage(name: AppRoutes.orderConfirmation, page: () => const OrderConfirmationScreen()),
    GetPage(name: AppRoutes.orders, page: () => const OrdersListScreen()),
    GetPage(name: AppRoutes.orderDetail, page: () => const OrderDetailScreen()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: AppRoutes.search, page: () => const SearchScreen()),
    GetPage(name: AppRoutes.adminList, page: () => const AdminProductListScreen()),
    GetPage(name: AppRoutes.adminForm, page: () => const AdminProductFormScreen()),
  ];
}

