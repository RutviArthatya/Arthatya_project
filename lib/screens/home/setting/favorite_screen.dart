
import 'package:currency_converter/ads/google_native_medium_ad.dart';
import 'package:currency_converter/constant/color_const.dart';
import 'package:currency_converter/custom/custom_size.dart';
import 'package:currency_converter/custom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ads/constant/constant.dart';
import '../../../custom/custom_appbar.dart';
import '../currency_controller/converttoany_controller.dart';
import '../theme_controller/theme_controller.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final AnyCurrencyConversionController controller = Get.put(AnyCurrencyConversionController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    getPreLoadAds();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isBackAdd) {
          backAds();
        }
        return true;
      },
      child: Scaffold(
        appBar: buildAppbar(title: "Favorite Conversions", actions: [
          IconButton(
              onPressed: () async {
                await controller.clearFavorites();
                (context as Element).reassemble();
              },
              icon: const Icon(Icons.delete_forever))
        ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildSize(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GoogleNativeMediumAd(),
              ),
              FutureBuilder<List<String>>(
                future: controller.getFavorites(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No favorites added.'));
                  } else {
                    List<String> favorites = snapshot.data!;
                    return ListView.builder(
                      itemCount: favorites.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // Splitting the favorite item to extract the date and time
                        String favoriteItem = favorites[index];
                        int dateIndex = favoriteItem.indexOf('(Saved on ');
                        String title = favoriteItem;
                        String subtitle = '';
                        if (dateIndex != -1) {
                          title = favoriteItem.substring(0, dateIndex).trim();
                          subtitle = favoriteItem.substring(
                              dateIndex + 10, favoriteItem.length - 1);
                        }

                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: themeController.themeMode.value ==
                                    ThemeMode.light
                                    ? ColorConst.lightGreyBorder
                                    : ColorConst.buttonColor,
                                border:
                                Border.all(color: ColorConst.transparent),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(text: title, weight: true),
                                        buildSize(height: 3),
                                        CustomText(
                                            text: subtitle,
                                            color: ColorConst.subColor,
                                            size: 10),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    // Add padding to make the yellow background visible
                                    decoration: const BoxDecoration(
                                        color: ColorConst.buttonColor,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10))
                                      // shape: BoxShape.circle, // You can change this to BoxShape.rectangle if you prefer
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        await controller.removeFromFavorites(
                                            favorites[index]);
                                        // controller.reset();
                                        // Trigger a rebuild to reflect the changes
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.favorite,
                                          color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
