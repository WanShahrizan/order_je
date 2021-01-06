


class OrderNotificationEntity{
  final String order_num;
  final String order_time;
  final String order_date;
  final String pay_method;
  final String staus;
  final String stall;
  final String image;

  OrderNotificationEntity({this.order_date,this.image,this.order_num,this.order_time,this.pay_method,this.stall,this.staus});

  static List<OrderNotificationEntity>orderData=[
    OrderNotificationEntity(order_date: '1/4/2020',image: 'assets/allert.png',order_num: 'Order #1010',order_time: '9.00 PM',pay_method: 'Cash',stall: 'MOK Burger \n@kk7',staus: 'Underway'),
    OrderNotificationEntity(order_date: '24/2/2020',image: 'assets/done.png',order_num: 'Order #0650',order_time: '8.23 PM',pay_method: 'Debit',stall: 'Nasi Kukus \n@kk7',staus: 'Completed'),
    OrderNotificationEntity(order_date: '1/4/2020',image: 'assets/allert.png',order_num: 'Order #1010',order_time: '9.00 PM',pay_method: 'Cash',stall: 'MOK Burger \n@kk7',staus: 'Underway'),
    OrderNotificationEntity(order_date: '24/2/2020',image: 'assets/done.png',order_num: 'Order #0650',order_time: '8.23 PM',pay_method: 'Debit',stall: 'Nasi Kukus \n@kk7',staus: 'Completed'),
  ];
}