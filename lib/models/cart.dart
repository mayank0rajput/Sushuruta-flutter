import 'package:flutter_application_1/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/utils/store.dart';

class Cart{
  late CatalogueModel _catalog;

  // Collection of IDs - store Ids of each item
  final Map<int,int> _itemIds = {};
  // Get Catalog
  CatalogueModel get catalog => _catalog;

  int getQuantity (Product item) => _itemIds[item.id] ?? 0;

  set catalog(CatalogueModel newCatalog){
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  List<Product> get items => _itemIds.keys.map((id) => _catalog.getById(id)).toList();

  // Get the total price
  num get totalPrice => items.fold(0, (total, current) {
    final quantity = _itemIds[current.id] ?? 0;
    return total + (int.parse(current.price.substring(1)) * quantity);
  });
}
class AddMutation extends VxMutation<MyStore> {
  final Product item;
  int q;

  AddMutation(this.item,{this.q = 1});

  @override
  perform() {
    final currentQuantity = store?.cart._itemIds[item.id] ?? 0;
    store?.cart._itemIds[item.id] = currentQuantity + q;
  }
}
class RemoveMutation extends VxMutation<MyStore>{
  final Product item;
  RemoveMutation(this.item);

  @override
  perform() {
    final currentQuantity = store?.cart._itemIds[item.id] ?? 0;
    if (currentQuantity > 1) {
      store?.cart._itemIds[item.id] = currentQuantity - 1;
    } else {
      store?.cart._itemIds.remove(item.id); // Remove the item if quantity is 0
    }
  }
}