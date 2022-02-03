import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/photo_view_page.dart';
import 'package:jd_get_proj/home_all/home_all_binding.dart';
import 'package:jd_get_proj/home_all/home_all_page.dart';
import 'package:jd_get_proj/init/init_binding.dart';
import 'package:jd_get_proj/init/init_page.dart';
import 'package:jd_get_proj/login_register/login_register_binding.dart';
import 'package:jd_get_proj/login_register/login_register_page.dart';
import 'package:jd_get_proj/order/order_binding.dart';
import 'package:jd_get_proj/order/order_page.dart';
import 'package:jd_get_proj/product_detail/product_detail_binding.dart';
import 'package:jd_get_proj/product_detail/product_detail_page.dart';
import 'package:jd_get_proj/product_list/product_list_binding.dart';
import 'package:jd_get_proj/product_list/product_list_page.dart';
import 'package:jd_get_proj/register/register_step1_page.dart';
import 'package:jd_get_proj/register/register_step2_binding.dart';
import 'package:jd_get_proj/register/register_step2_page.dart';
import 'package:jd_get_proj/register/register_step3_binding.dart';
import 'package:jd_get_proj/register/register_step3_page.dart';
import 'package:jd_get_proj/search/search_binding.dart';
import 'package:jd_get_proj/search/search_page.dart';
import 'package:jd_get_proj/transport_address/add_transport_address_page.dart';
import 'package:jd_get_proj/transport_address/recipient_address_binding.dart';
import 'package:jd_get_proj/transport_address/recipient_address_page.dart';
import 'package:jd_get_proj/transport_address/transport_address_binding.dart';
import 'package:jd_get_proj/unknown/unknown_page.dart';

// ignore: constant_identifier_names
const String INIT_PATH = "/";
// ignore: constant_identifier_names
const String HOME_ALL_PATH = "/homeall";
// ignore: constant_identifier_names
const String PRODUCTS_PATH = "/products";
// ignore: constant_identifier_names
const String SEARCH_PATH = "/search";
// ignore: constant_identifier_names
const String PRODUCT_DETAIL_PATH = "/productDetail";
// ignore: constant_identifier_names
const String PHOTO_VIEW_PATH = "/photoViewPage";
// ignore: constant_identifier_names
const String ORDER_PATH = "/order";
// ignore: constant_identifier_names
const String ADD_ADDRESS_PATH = "/addAddress";
// ignore: constant_identifier_names
const String RECIPIENT_ADDRESS_PATH = "/recipientAddress";
// ignore: constant_identifier_names
const String LOGIN_REGISTER_PATH = "/loginRegister";
// ignore: constant_identifier_names
const String REGISTER_STEP1_PATH = "/registerStep1";
// ignore: constant_identifier_names
const String REGISTER_STEP2_PATH = "/registerStep2";
// ignore: constant_identifier_names
const String REGISTER_STEP3_PATH = "/registerStep3";

// ignore: constant_identifier_names
const String UNKNOWN_PATH = "/unknown";

// ignore: non_constant_identifier_names
final List<GetPage<dynamic>> PAGES = [
  GetPage(
      name: INIT_PATH, page: () => const InitPage(), binding: InitBinding()),
  GetPage(
      name: HOME_ALL_PATH,
      page: () => const HomeAllPage(),
      binding: HomeAllBinding()),
  GetPage(
      name: PRODUCTS_PATH,
      page: () => const ProductListPage(),
      binding: ProductListBinding()),
  GetPage(
      name: SEARCH_PATH,
      page: () => const SearchPage(),
      binding: SearchBinding()),
  GetPage(
      name: PRODUCT_DETAIL_PATH,
      page: () => const ProductDetailPage(),
      binding: ProductDetailBinding()),
  GetPage(name: PHOTO_VIEW_PATH, page: () => const PhotoViewPage()),
  GetPage(
      name: ORDER_PATH, page: () => const OrderPage(), binding: OrderBinding()),
  GetPage(
      name: ADD_ADDRESS_PATH,
      page: () => const AddTransportAddressPage(),
      binding: TransportAddressBinding()),
  GetPage(
      name: RECIPIENT_ADDRESS_PATH,
      page: () => const RecipientAddressPage(),
      binding: RecipientAddressBinding()),
  GetPage(
      name: LOGIN_REGISTER_PATH,
      page: () => const LoginRegisterPage(),
      binding: LoginRegisterBinding()),
  GetPage(name: REGISTER_STEP1_PATH, page: () => RegisterStep1Page()),
  GetPage(
      name: REGISTER_STEP2_PATH,
      page: () => const RegisterStep2Page(),
      binding: RegisterStep2Binding()),
  GetPage(
      name: REGISTER_STEP3_PATH,
      page: () => const RegisterStep3Page(),
      binding: RegisterStep3Binding()),
];

// ignore: non_constant_identifier_names
final GetPage<dynamic> UNKNOWN_PAGE =
    GetPage(name: UNKNOWN_PATH, page: () => const UnknownPage());
