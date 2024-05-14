import 'package:flutter_application_1/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/utils/store.dart';

class Cart{
  late CatalogueModel _catalog;

  // Collection of IDs - store Ids of each item
  final _itemIds = [];

  // Get Catalog
  CatalogueModel get catalog => _catalog;

  set catalog(CatalogueModel newCatalog){
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  // Get the total price
  num get totalPrice => items.fold(0, (total, current) => total + current.price);

  // Add Items
  void add(Item item){
    items.add(item);
  }
  void remove(Item item){
    items.remove(item);
  }
}
class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);

  @override
  perform() {
    store?.cart._itemIds.add(item.id);
  }
}
class RemoveMutation extends VxMutation<MyStore>{
  final Item item;
  RemoveMutation(this.item);

  @override
  perform() {
   store?.cart._itemIds.remove(item.id);
  }
}