import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live_selling/ui/common/app_strings.dart';
import 'package:live_selling/ui/util/Appbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../models/InventoryItem.dart';
import 'inventory_viewmodel.dart';

class InventoryView extends StatelessWidget {
  InventoryView({super.key});

  Widget build(BuildContext context) {
    return ViewModelBuilder<InventoryViewModel>.reactive(
      viewModelBuilder: () => InventoryViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: ChatAppbar(
          rowWidget: Padding(
            padding: const EdgeInsets.only(left: 24.0, bottom: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: model.navigateBack,
                  child: SvgPicture.asset(
                    "assets/back.svg",
                    color: Colors.black,
                    width: 18,
                    height: 18,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    add_inventry,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: model.addInventoryToserver,
                  child: Text(
                    save,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // horizontal, vertical offset
                ),
              ],
            ),
            child: Column(
              children: [
                if(model.inventoryList.isEmpty)
                  Text(
                    list_empty,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.inventoryList.length,
                    itemBuilder: (context, index) {
                      InventoryItem item = model.inventoryList[index];
                      return ListTile(
                        title: Text(item.itemName),
                        subtitle: Text('Item ID: ${item.itemID}'),
                        trailing: Text('Quantity: ${item.quantity_sold}'),
                      );
                    },
                  ),
                ),
                TextFormField(
                  controller: model.itemIDController,
                  decoration: InputDecoration(labelText: item_id),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: model.itemNameController,
                  decoration: InputDecoration(labelText: item_name),
                ),
                TextFormField(
                  controller: model.quantityController,
                  decoration: InputDecoration(labelText: quantity),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: model.addInventoryItem,
                  child: Text(add_update_item),
                ),
                if (model.isBusy)
                  Container(
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
          ),
        ),
      ),
    );
  }
}
