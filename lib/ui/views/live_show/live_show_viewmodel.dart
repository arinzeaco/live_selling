import 'dart:io';

import 'package:live_selling/app/app.locator.dart';
import 'package:live_selling/app/app.router.dart';
import 'package:live_selling/models/InventoryItem.dart';
import 'package:live_selling/services/selling_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LiveShowViewModel extends ReactiveViewModel {
  final _sellingService = locator<SellingService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<InventoryItem> get inventoryItem => _sellingService.inventoryItemData;

  navigateToInventoryView() {
    _navigationService.navigateToInventoryView();
  }

  Future<void> liveShowResult() async {
    setBusy(true);
    try {
      await _sellingService.getInventoryItem();
      print(inventoryItem);
    } on HttpException catch (error) {
      throw HttpException(error.message);
    } finally {
      setBusy(false);
    }
  }

  Future<void> buyItem(String id) async {
    try {
      await _sellingService.buyItem(id.toString());
    } on HttpException catch (error) {
      _dialogService.showDialog(
        title: "An error occurred",
        description: error.toString(),
      );
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_sellingService];
}
