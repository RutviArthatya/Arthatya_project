import 'package:currency_converter/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color_const.dart';
import '../../custom/subtitle_text.dart';
import '../../routing/routes.dart';
import '../home/exchange_rate/newexchangelist_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 2,
        shadowColor: Colors.grey.shade50,
        title: SubTitleText(
          text: "Currency Converter",
          color: ColorConst.white,
          size: 16,
          weight: true,
        ),
        backgroundColor: ColorConst.buttonColor,
        iconTheme: const IconThemeData(color: ColorConst.white),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.settingScreen),
              icon: Icon(Icons.settings))
        ],

        bottom: TabBar(
          controller: tabController,
          indicatorColor: ColorConst.white, // Set the indicator color to white
          labelColor: ColorConst.white, // Set the label color to white when selected
          unselectedLabelColor: Colors.grey, // Set the label color to grey when not selected

          tabs: const [

            Tab(
              text: "Exchange Rate",
            ),
            Tab(
              text: "Rate List",
            ),

          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: const [
        HomePage(),
        NewExchangeListScreen(),
      ]),
    );
  }
}
