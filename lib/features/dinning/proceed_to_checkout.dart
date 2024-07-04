import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/checkout.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/confromorder.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinningcontroller.dart';

class ProceedTOCheckout extends StatefulWidget {
  const ProceedTOCheckout({super.key});

  @override
  State<ProceedTOCheckout> createState() => _ProceedTOCheckoutState();
}

class _ProceedTOCheckoutState extends State<ProceedTOCheckout> {



  DinningController _dinningController=Get.find<DinningController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Get.height*0.1,
      width: Get.width,
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('subtotal',style: TextStyle(color: Color(0xFFEF7822), fontSize: 15),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(()=>Text('£ ${_dinningController.totalPrice.toString()}',style: TextStyle(color: Color(0xFFEF7822), fontSize: 15)),)
              )
            ],
          ),
          InkWell(
            onTap: (){
              Get.to(ConfromOrder());
            },

            child: Container(
              height: Get.height*0.05,
              width: Get.width*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFEF7822),
              ),
              child: Center(child: Text('Proceed to Checkout',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),)),
            ),
          )
        ],
      ),
    );
  }
}
