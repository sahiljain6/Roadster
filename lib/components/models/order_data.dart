import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrderData {
  const OrderData({
    required this.address,
    required this.name,
    required this.orderId,
    required this.amount,
    required this.city,
    required this.emailId,
    required this.mobileNo,
    required this.pinCode,
    required this.state,
    required this.date,
    required this.items,
  });

  final String address;
  final String name;
  final String orderId;
  final String amount;
  final String city;
  final String emailId;
  final String mobileNo;
  final String pinCode;
  final String state;
  final String date;
  final List<dynamic> items;
}
