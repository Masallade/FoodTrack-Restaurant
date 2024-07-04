import 'package:stackfood_multivendor_restaurant/common/widgets/product_widget.dart';
import 'package:stackfood_multivendor_restaurant/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor_restaurant/helper/custom_print_helper.dart';
import 'package:stackfood_multivendor_restaurant/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodList extends StatelessWidget {
  final ScrollController? scrollController;

  const FoodList({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final RestaurantController restaurantController = Get.find<RestaurantController>();
    restaurantController.setOffset(1);

    // Use provided scrollController or create a new one
    final ScrollController controller = scrollController ?? ScrollController();

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent
          && restaurantController.productList != null
          && !restaurantController.isLoading) {
        int pageSize = (restaurantController.pageSize! / 10).ceil();
        if (restaurantController.offset < pageSize) {
          restaurantController.setOffset(restaurantController.offset + 1);
          customPrint('end of the page');
          restaurantController.showBottomLoader();
          restaurantController.getProductList(
            restaurantController.offset.toString(), restaurantController.type,
          );
        }
      }
    });

    return GetBuilder<RestaurantController>(builder: (restController) {
      return Column(children: [
        restController.productList != null && restController.productList!.isNotEmpty
            ? GridView.builder(
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
            return ProductWidget(
              product: restController.productList![index],
              index: index,
              length: restController.productList!.length,
              isCampaign: false,
              inRestaurant: true,
            );
          },
        )
            : Center(child: Text('no_food_available'.tr)),
      ]);
    });
  }
}
