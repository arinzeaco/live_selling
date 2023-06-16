import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:live_selling/app/app.locator.dart';
import 'package:live_selling/models/InventoryItem.dart';
import 'package:live_selling/services/selling_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InventoryViewModel extends BaseViewModel {
  final _sellingService = locator<SellingService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  navigateBack() => _navigationService.back();

  TextEditingController itemIDController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  bool _isFormValid = false;

  bool get isFormValid => _isFormValid;
  List<InventoryItem> inventoryList = [];

  void addInventoryItem() {
    validate();
    String itemID = itemIDController.text;
    String itemName = itemNameController.text ?? '';
    int quantity = int.parse(quantityController.text);

    InventoryItem newItem = InventoryItem(itemID: itemID, itemName: itemName, quantity_sold: quantity);
    inventoryList.add(newItem);
    notifyListeners();
  }

  validate(){
   if(itemIDController.text.isEmpty){
     _dialogService.showDialog(
       description: "Enter itemID",

     );
     return;
   }
   if(itemNameController.text.isEmpty){
     _dialogService.showDialog(
       description: "Enter ItemName",
     );
     return;
   }
   if(quantityController.text.isEmpty){
     _dialogService.showDialog(
       description: "Enter Quantity",
     );
     return;
   }
  }
  Future<void> addInventoryToserver() async {
    setBusy(true);
    try {
      await _sellingService.addInventoryItem(inventoryList);
      notifyListeners();
      _navigationService.back();
    } on HttpException catch (error) {
      throw HttpException(error.message);
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    itemIDController.dispose();
    itemNameController.dispose();
    quantityController.dispose();
    super.dispose();
  }
  @override
  List<ListenableServiceMixin> get listenableServices => [_sellingService];
}
