import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/compomnt/custom_row_for_checkout_payment.dart';

class CheckoutPayment extends StatelessWidget {
  const CheckoutPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          '              purshase',
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 30, top: 50, right: 30, bottom: 50),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Paint name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '\$120.99',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
            ),
            const CustomRow(
              checkoutTpye: 'Order Subtotal',
              price: 112,
              fontSize: 20,
            ),
            const CustomRow(
              checkoutTpye: 'Discount',
              price: 3,
              fontSize: 20,
            ),
            const CustomRow(
              checkoutTpye: 'fees',
              price: 3,
              fontSize: 20,
            ),
            const Divider(
              height: 4,
              color: Colors.grey,
            ),
            const CustomRow(
              checkoutTpye: 'Total',
              price: 112,
              fontSize: 28,
            ),
            GestureDetector(
              onTap: () => Get.toNamed('/PaymentDetails'),
              child: Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.all(18),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange[300],
                ),
                child: const Center(
                  child: Text(
                    'Complete Payment',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
