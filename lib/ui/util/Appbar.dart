
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget{

  final Widget? rowWidget;
  final Color? color;

  const ChatAppbar({
    super.key,
    this.rowWidget,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
        color: color,
        borderRadius: BorderRadius.circular(0),
      ),
        child:rowWidget
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

}