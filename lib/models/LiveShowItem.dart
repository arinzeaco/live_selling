class LiveShowItem {
  final int itemID;
  final String itemName;

  LiveShowItem({required this.itemID, required this.itemName});

  factory LiveShowItem.fromJson(Map<String, dynamic> json) {
    return LiveShowItem(
      itemID: json['itemID'],
      itemName: json['itemName'],
    );
  }
}
