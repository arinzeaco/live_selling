class InventoryItem {
  final String itemID;
  String itemName;
  int quantity_sold;

  InventoryItem({
    required this.itemID,
    required this.itemName,
    required this.quantity_sold,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      itemID: json['itemID'],
      itemName: json['itemName'],
      quantity_sold: json['quantity_sold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemID': itemID,
      'itemName': itemName,
      'quantity_sold': quantity_sold,
    };
  }
}