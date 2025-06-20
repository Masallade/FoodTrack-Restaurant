import 'package:stackfood_multivendor_restaurant/common/widgets/product_shimmer_widget.dart';
import 'package:stackfood_multivendor_restaurant/common/widgets/product_widget.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinning_productWidget.dart';
import 'package:stackfood_multivendor_restaurant/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor_restaurant/features/restaurant/widgets/veg_filter_widget.dart';
import 'package:stackfood_multivendor_restaurant/helper/custom_print_helper.dart';
import 'package:stackfood_multivendor_restaurant/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DinningProductViewWidget extends StatelessWidget {
  final ScrollController scrollController;
  final String? type;
  final Function(String type)? onVegFilterTap;
  const DinningProductViewWidget({super.key, required this.scrollController, this.type, this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {

    Get.find<RestaurantController>().setOffset(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent
          && Get.find<RestaurantController>().productList != null
          && !Get.find<RestaurantController>().isLoading) {
        int pageSize = (Get.find<RestaurantController>().pageSize! / 10).ceil();
        if (Get.find<RestaurantController>().offset < pageSize) {
          Get.find<RestaurantController>().setOffset(Get.find<RestaurantController>().offset+1);
          customPrint('end of the page');
          Get.find<RestaurantController>().showBottomLoader();
          Get.find<RestaurantController>().getProductList(
            Get.find<RestaurantController>().offset.toString(), Get.find<RestaurantController>().type,
          );
        }
      }
    });

    return GetBuilder<RestaurantController>(builder: (restController) {
      return Column(children: [

        type != null ? VegFilterWidget(type: type, onSelected: onVegFilterTap) : const SizedBox(),

        restController.productList != null ? restController.productList!.isNotEmpty ? GridView.builder(
          key: UniqueKey(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.paddingSizeLarge,
            mainAxisSpacing: 0.01,
            childAspectRatio: 4,
            crossAxisCount: 1,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: restController.productList!.length,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          itemBuilder: (context, index) {
            return DinningProductWidget(
              product: restController.productList![index],
              index: index, length: restController.productList!.length, isCampaign: false,
              inRestaurant: true,
            );
          },
        ) : Center(child: Text('no_food_available'.tr)) : GridView.builder(
          key: UniqueKey(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.paddingSizeLarge,
            mainAxisSpacing: 0.01,
            childAspectRatio: 4,
            crossAxisCount: 1,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          itemBuilder: (context, index) {
            return ProductShimmerWidget(
              isEnabled: restController.productList == null, hasDivider: index != 19,
            );
          },
        ),

        restController.isLoading ? Center(child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        )) : const SizedBox(),

      ]);
    });
  }
}