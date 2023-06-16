import 'dart:io';

import 'package:dio/dio.dart';
import 'package:live_selling/app/app.locator.dart';
import 'package:live_selling/client/dio_client.dart';
import 'package:live_selling/models/InventoryItem.dart';
import 'package:live_selling/ui/util/http_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SellingService with ListenableServiceMixin {
  List<InventoryItem> _InventoryItemData = [];
  List<InventoryItem> _purchasedItemData = [];
  final _dialogService = locator<DialogService>();

  List<InventoryItem> get inventoryItemData => _InventoryItemData;

  List<InventoryItem> get purchasedItemData => _purchasedItemData;

  Dio dioClient = locator<DioClient>().dio;

  SellingService() {
    listenToReactiveValues([inventoryItemData, purchasedItemData]);
  }

  Future<void> getInventoryItem() async {
    var response = await dioClient.get("show/222");
    final List collection = response.data;
    _InventoryItemData.addAll(
        collection.map((json) => InventoryItem.fromJson(json)).toList());
  }

  Future<void> addInventoryItem(List<InventoryItem> inventoryList) async {
    List<Map<String, dynamic>> inventoryItems = inventoryList.map((item) => item.toJson()).toList();
    var response = await dioClient.post("inventory", data: inventoryItems);
    if (response.statusCode == 201) {
      addUpdate(inventoryList);
      notifyListeners();
    } else {
      print("Failed to add inventory items");
    }
  }
  Future<void> addUpdate(List<InventoryItem> inventoryList) async {
    for (var newItem in inventoryList) {
      // Find the index of the existing item in _InventoryItemData with the same itemID
      var existingItemIndex = _InventoryItemData.indexWhere((item) => item.itemID == newItem.itemID);

      if (existingItemIndex != -1) {
        // Update the existing item's properties
        _InventoryItemData[existingItemIndex].itemName = newItem.itemName;
        _InventoryItemData[existingItemIndex].quantity_sold = newItem.quantity_sold;
      } else {
        // Add the new item to _InventoryItemData
        _InventoryItemData.add(newItem);
      }
    }

    // Send the updated inventory to the server
    // ... code for sending the updated inventory to the server
  }
  Future buyItem(String id) async {
    try {
      await dioClient.post("show/222/buy_item/" + id);
      _dialogService.showDialog(
        title: "Success",
        description: "Item purchase successful",
      );
      return "Item purchase successful";
    } catch (e) {
      var errorMessage = "An error occurred";
      if (e is DioError) {
        if (e.response != null && e.response!.data != null) {
          errorMessage = e.response?.data['message'];
        }
      }
      _dialogService.showDialog(
        title: "An error occurred",
        description: errorMessage,
      );
      throw e;
    }
  }
}
