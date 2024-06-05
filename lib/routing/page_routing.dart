
import 'package:currency_converter/routing/routes.dart';
import 'package:currency_converter/screens/home/homepage.dart';
import 'package:get/get.dart';

import '../screens/home/about/about_screen.dart';
import '../screens/home/exchange_rate/newexchangelist_screen.dart';
import '../screens/home/setting/favorite_screen.dart';
import '../screens/home/setting/setting_screen.dart';
import '../screens/intro/intro1.dart';
import '../screens/intro/intro2.dart';
import '../screens/intro/intro3.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/tab_bar/tab_bar.dart';



class PageRouting{
  List<GetPage> pageRouting = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),
    GetPage(name: Routes.homePage, page: () => const HomePage()),
    GetPage(name: Routes.settingScreen, page: () => const SettingScreen()),
    GetPage(name: Routes.favoritesScreen, page: () => const FavoritesScreen()),
    GetPage(name: Routes.aboutScreen, page: () => const AboutScreen()),
    GetPage(name: Routes.tabBarScreen, page: () => const TabBarScreen()),
    GetPage(name: Routes.newExchangeListScreen, page: () => const NewExchangeListScreen()),









    //intro
    GetPage(name: Routes.intro1Screen, page: () => const Intro1Screen()),
    GetPage(name: Routes.intro2Screen, page: () => const Intro2Screen()),
    GetPage(name: Routes.intro3Screen, page: () => const Intro3Screen()),






  ];
}