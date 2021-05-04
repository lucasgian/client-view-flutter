import 'package:client_view_flutter/design_order/models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Order> parse(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Order>((json) => Order.fromJson(json)).toList(); 
} 

Future<List> getOrders() async {
  final response = await http.get(Uri.http('localhost:3000', '/orders'));
  if (response != null) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parse(response.body); 
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load orders');
  }
}