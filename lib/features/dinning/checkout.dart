import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stackfood_multivendor_restaurant/common/models/config_model.dart';
import 'package:stackfood_multivendor_restaurant/features/dinning/dinningcontroller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:stackfood_multivendor_restaurant/features/splash/controllers/splash_controller.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    BaseUrls? baseUrls = Get.find<SplashController>().configModel!.baseUrls;
    DinningController _dinningController = Get.find<DinningController>();
    Future<dynamic> paymentBottomSheet() {
      return Get.bottomSheet(Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select a payment method'),
                    SizedBox(
                      height: 55,
                      child:
                          Lottie.asset('assets/lottie_animation/payment.json'),
                    ),
                  ]),
            ),
            GestureDetector(
              onTap: () {
                _dinningController.paymentSelection.value =
                    !_dinningController.paymentSelection.value;
                Get.back();
              },
              child: badges.Badge(
                showBadge: _dinningController.paymentSelection.value,
                badgeContent: Icon(
                  CupertinoIcons.check_mark_circled,
                  color: Colors.white,
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Color(0xFFEF7822),
                ),
                child: Container(
                  height: Get.height * .1,
                  width: Get.width * 0.7,
                  decoration: BoxDecoration(
                    color: const Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'cash ',
                        style:
                            TextStyle(color: Color(0xFFEF7822), fontSize: 20),
                      ),
                      SizedBox(
                        height: 55,
                        child:
                            Lottie.asset('assets/lottie_animation/cash.json'),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ));
    }

    Widget paymentType = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'cash ',
          style: TextStyle(color: Color(0xFFEF7822), fontSize: 20),
        ),
        SizedBox(
          height: 55,
          child: Lottie.asset('assets/lottie_animation/cash.json'),
        )
      ],
    );
    Widget addtionalInformation() {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: Get.height * 0.3,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                expands: true, // Expands to fill the parent Container
                maxLines: null, // Allows unlimited lines
                minLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Additional details',
                  hintText: 'Enter Additional details here...',

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                        color: Color(0xfff6f6f6),
                        ), // Border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                        color:  Color(0xFFEF7822)), // Border when focused
                  ),
                   // Enables background color
                ),
              ),
            ),
          ));
    }


    Future<dynamic> summaryBottomSheet() {
      return Get.bottomSheet(
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Summary', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 55,
                      child: Lottie.asset('assets/lottie_animation/summary.json'),
                    ),
                  ],
                ),
              ),
              // Table Header
              Table(
                columnWidths: {
                  0: FixedColumnWidth(60), // Fixed width for the image column
                  1: FlexColumnWidth(), // Flex width for name
                  2: FlexColumnWidth(), // Flex width for price
                  3: FlexColumnWidth(), // Flex width for quantity
                  4: FlexColumnWidth(), // Flex width for total
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Image', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Name', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Price', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Quantity', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Total', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
              // Table Rows
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(60), // Fixed width for the image column
                      1: FlexColumnWidth(), // Flex width for name
                      2: FlexColumnWidth(), // Flex width for price
                      3: FlexColumnWidth(), // Flex width for quantity
                      4: FlexColumnWidth(), // Flex width for total
                    },
                    children: _dinningController.cartItems.map<TableRow>((item) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFEF7822), width: 2),
                                image: DecorationImage(
                                  image: NetworkImage('${baseUrls!.productImageUrl}/${item['image']}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top:12,
                              left: 8,
                              right: 8,
                            ),
                            child: Text(item['name'], textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item['price'].toString(), textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item['quantity'].toString(), textAlign: TextAlign.center),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_dinningController.totalPriceOfEachItem(
                            item['price'], item['quantity']), textAlign: TextAlign.center),
                          ),

                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget orderSummary(){
      return GestureDetector(
        onTap: (){
          summaryBottomSheet();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: Get.height*0.07,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('order summary'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15,bottom: 20),
                  child: SizedBox(
                    height: 75,
                    child: Lottie.asset('assets/lottie_animation/summary.json'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }


    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: Get.height * 0.3,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Contact info '),
                          SizedBox(
                            height: 55,
                            child: Lottie.asset(
                                'assets/lottie_animation/contact.json'),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              CupertinoIcons.person,
                              color: Color(0xFFEF7822),
                            ),
                            hintText: 'name',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Color(0xfff6f6f6))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFEF7822)),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              CupertinoIcons.phone,
                              color: Color(0xFFEF7822),
                            ),
                            hintText: 'number',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Color(0xfff6f6f6))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFEF7822)),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: Get.height * 0.2,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Payment Method '),
                          SizedBox(
                            height: 45,
                            child: Lottie.asset(
                                'assets/lottie_animation/payment.json'),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        paymentBottomSheet();
                      },
                      child: Container(
                        height: Get.height * .1,
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                          color: const Color(0xfff6f6f6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => SizedBox(
                                child: _dinningController.paymentSelection.value
                                    ? paymentType
                                    : Text(
                                        'select a payment method',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                              ),
                            ),
                            Text(
                              '£ ${_dinningController.totalPrice}',
                              style: const TextStyle(color: Color(0xFFEF7822)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          addtionalInformation(),
          orderSummary(),
          SizedBox(
            height: Get.height*.1,
          )
        ],
      ),
    );
  }
}
