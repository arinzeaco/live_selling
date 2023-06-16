import 'package:live_selling/client/dio_client.dart';
import 'package:live_selling/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:live_selling/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:live_selling/ui/views/inventory/inventory_view.dart';
import 'package:live_selling/services/selling_service.dart';
import 'package:live_selling/ui/views/live_show/live_show_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: InventoryView, initial: true),
    MaterialRoute(page: LiveShowView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SellingService),
    LazySingleton(classType: DioClient),

// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
