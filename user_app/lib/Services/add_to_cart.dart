import 'package:flutter/material.dart';
import 'package:user_app/Screens/home_screen.dart';
import 'package:user_app/Utils/constants.dart';

void addToCart(var name, var price, context, var _defaultValue) {
  quantity.add(int.parse(_defaultValue.toString()));
  items.add(name);
  prices.add(double.parse(price.toString()));
  total = calculateTotal();
  reload(context);
}

void reload(context) {
  print("reload");
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}
