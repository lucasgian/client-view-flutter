import 'package:client_view_flutter/design_order/models/order_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List parse(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<OrderDetail>((json) => OrderDetail.fromJson(json)).toList(); 
} 

List<OrderDetail> getOrdersDetails(order_id) {
      print('devevev.body ${order_id}');

  final response = http.get(Uri.http('localhost:3000', '/order-details/1'));
    //  print('codigo: ${(response.body)}');

  if (response != null) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return OrderDetail.popularList; 
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load order details');
  }
}