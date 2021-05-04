import 'package:flutter/material.dart';

class Item {
  Item({@required name, @required price});
  String name;
  String price;
}

class OrderDetail {
  OrderDetail({@required this.id, @required this.img, @required this.orderId, @required this.itens, @required this.price, @required this.status});

  String orderId;
  List<Item> itens;
  String price;
  String status;
  int id;
  String img;

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      img: json['img'],
      orderId: json['order_id'],
      itens: json['itens'],
      price: json['price'],
      status: json['status'],
    );
  }
  static List<OrderDetail> popularList = <OrderDetail>[
    OrderDetail(
      img: 'assets/design_course/interFace3.png',
      orderId: '1',
      status: 'Enviado',
      price: '299.00',
      itens: <Item>[
        Item( name: 'Impressora', price: '200.00' ),
        Item( name: 'Gaveta', price: '99.00' )

      ]
    ),
  ];
}
