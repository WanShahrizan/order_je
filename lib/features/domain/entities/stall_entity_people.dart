

class StallEntityPeople{
  final String image;
  final String title;
  final String brand;
  final String price;
  StallEntityPeople({this.image,this.title,this.brand,this.price});

  static List<StallEntityPeople> stallPeopleData=[
    StallEntityPeople(image:'assets/burger.png',title: 'Krispy Double Burger',brand:'By \nMOK Burger @ KK7',price:'RM 6.00'),
    StallEntityPeople(image:'assets/burger.png',title: 'Nasi Kukus',brand:'By \nNasi Kukus @ KK7',price:'RM 5.00'),
    StallEntityPeople(image:'assets/burger.png',title: 'Krispy double burger',brand:'By MOK Burger @ KK7',price:'RM 6.00'),
    StallEntityPeople(image:'assets/burger.png',title: 'Nasi Kukus',brand:'By Nasi Kukus @ KK7',price:'RM 5.00'),
  ];
}
