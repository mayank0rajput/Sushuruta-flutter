class CatalogueModel{
  static var items = [

  ];
}

class Item{
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item({required this.id,required this.name,required this.desc,required this.price,required this.color,required this.image});

  factory Item.fromMap(Map<String,dynamic> mpp){
    return Item(
        id: mpp["id"],
        name: mpp["name"],
        desc: mpp["desc"],
        price: mpp["price"],
        color: mpp["color"],
        image: mpp["image"]
    );
  }
    toMap() => {
      "id" : id,
      "name" : name,
      "desc" : desc,
      "price" : price,
      "color" : color,
      "image" : image,
    };
}