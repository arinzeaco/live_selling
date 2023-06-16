import 'package:flutter/material.dart';
import 'package:live_selling/ui/common/app_strings.dart';
import 'package:live_selling/ui/util/Appbar.dart';
import 'package:skeletons/skeletons.dart';
import 'package:stacked/stacked.dart';

import 'live_show_viewmodel.dart';

class LiveShowView extends StatelessWidget {
  const LiveShowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveShowViewModel>.reactive(
        viewModelBuilder: () => LiveShowViewModel(),
        onViewModelReady: (model) async {
          await model.liveShowResult();
        },
        builder: (context, model, child) => Scaffold(
              appBar: ChatAppbar(
                rowWidget: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, bottom: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(),
                      Text(live_show,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )),
                      GestureDetector(
                        onTap: model.navigateToInventoryView,
                        child: Text(
                          post,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Container(
                padding: const EdgeInsets.all(16.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.isBusy
                        ? Expanded(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 7,
                              itemBuilder: (context, index) =>
                                  const SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    width: double.infinity, height: 100),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: model.inventoryItem.length,
                              itemBuilder: (context, index) {
                                final bookingData = model.inventoryItem;

                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Item details
                                      Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "ID: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                Text(
                                                  bookingData[index].itemID,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                Text(
                                                  "Item: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                Text(
                                                  bookingData[index].itemName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                Text(
                                                  "Quantity: ",
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                Text(
                                                  bookingData[index]
                                                      .quantity_sold
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                model.buyItem(bookingData[index].itemID);
                                              },
                                              child: Text('Buy'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ));
  }
}
