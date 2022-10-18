var currentUser = " ";
var items = new List<String>.empty();
var quantity = new List<int>.empty();
var prices = new List<double>.empty();
var uid = '';
double total = calculateTotal();
var orders = 1;

double calculateTotal() {
  total = 0;
  print(items.length);
  print(quantity.length);

  for (var i = 0; i < quantity.length; i++) {
    print(items[i]);
    print(quantity[i]);
    print(prices[i]);
    total += quantity[i] * prices[i];
  }
  print(total);
  return total;
}
