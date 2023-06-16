class InventoryItemPost {
  final String itemID;
  String itemName;
  int quantity;

  InventoryItemPost(
      {required this.itemID, required this.itemName, required this.quantity});

  factory InventoryItemPost.fromJson(Map<String, dynamic> json) {
    return InventoryItemPost(
      itemID: json['itemID'],
      itemName: json['itemName'],
      quantity: json['quantity'],
    );
  }
}
