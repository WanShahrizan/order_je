

class StallHomeScreenEntity{
  final String image;
  final String name;
  final String type;
  final String label;

  StallHomeScreenEntity({this.image,this.type,this.name,this.label});

  static List<StallHomeScreenEntity>stallHomeScreenData=[
    StallHomeScreenEntity(image: 'assets/burger.png',type: 'opt1:  egg, cheese',name: 'Krispy Burger Single',label: 'Make Manu Available'),
    StallHomeScreenEntity(image: 'assets/burger5.png',type: 'Var1:  egg, cheese',name: 'Beef Burger Single',label: 'Make Manu UnAvailable'),
    StallHomeScreenEntity(image: 'assets/burger6.png',type: 'Var1:  egg, cheese',name: 'Chicken Burger Single',label: 'Make Manu UnAvailable'),
    StallHomeScreenEntity(image: 'assets/burger5.png',type: 'opt1:  egg, cheese',name: 'Krispy Burger Single',label: 'Make Manu Available'),
  ];
}