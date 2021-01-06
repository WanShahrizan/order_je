

class AlertOrderPageEntity{
  final String  order_number;
  final String  order_time;
  final String  type;
  final String  quantity;
  final String  iamge;

  AlertOrderPageEntity({this.type,this.order_time,this.quantity,this.iamge,this.order_number});

  static List<AlertOrderPageEntity>alertOrderData=[
    AlertOrderPageEntity(type: 'Crispy Burger Double',order_time: 'Time Order : 9.00 PM',quantity: '2 \n1',iamge:'assets/allert.png',order_number: 'Order #1010'),
    AlertOrderPageEntity(type: 'Beef Burger Single',order_time: 'Time Order : 9.43 PM',quantity: '2 \n1',iamge:'assets/allert.png',order_number: 'Order #1052'),
    AlertOrderPageEntity(type: 'chicken burger Double',order_time: 'Time Order : 9.00 PM',quantity: '2 \n1',iamge:'assets/allert.png',order_number: 'Order #1010'),
    AlertOrderPageEntity(type: 'Crispy Burger single',order_time: 'Time Order : 9.55 PM',quantity: '2 \n1',iamge:'assets/allert.png',order_number: 'Order #1052'),
  ];
}