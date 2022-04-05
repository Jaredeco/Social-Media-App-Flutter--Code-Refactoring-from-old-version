import 'package:flutter/material.dart';
import 'package:get/get.dart';

startLoading(){
  Get.defaultDialog(
    title: "Loading...",
    content: CircularProgressIndicator(),
    barrierDismissible: false,
  );
}

dismissLoading(){
  Get.back();
}