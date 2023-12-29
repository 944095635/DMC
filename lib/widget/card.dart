import 'package:flutter/material.dart';
import 'package:get/get.dart';

buildCard({
  Widget? child,
  EdgeInsetsGeometry padding = const EdgeInsets.all(8),
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).cardColor,
        borderRadius: BorderRadius.circular(8),
        //boxShadow: const [
        //  BoxShadow(
        //    color: Color.fromARGB(255, 245, 245, 250),
        //    blurRadius: 5,
        //  ),
        //],
      ),
      child: child,
    ),
  );
}

buildCard1({Widget? child, EdgeInsetsGeometry? padding}) {
  return Container(
    margin: const EdgeInsets.all(30),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color.fromARGB(95, 255, 255, 255),
      border: Border.all(
        color: Colors.white,
        width: 3,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(10, 69, 69, 69),
          offset: Offset(10, 10),
          blurRadius: 10,
        ),
      ],
    ),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: padding,
      child: child,
    ),
  );
}
