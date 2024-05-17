import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfeconges/data/core/extensions/context_extension.dart';
import 'package:pfeconges/style/app_bar.dart';
import 'package:pfeconges/style/app_text_style.dart';

class AppPage extends StatelessWidget {
  final Widget? appBar;
  final String? title;
  final Widget? titleWidget;
  final Color backGroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget? body;
  final bool automaticallyImplyLeading;
  final Widget? bottomNavigationBar;

  const AppPage({
    super.key,
    this.appBar,
    this.title,
    this.titleWidget,
    required this.backGroundColor,
    this.actions,
    this.leading,
    this.body,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerFloat,
    this.automaticallyImplyLeading = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      backgroundColor: backGroundColor,
      appBar: (title == null && titleWidget == null) &&
              actions == null &&
              leading == null
          ? null
          : PreferredSize(
              
            preferredSize: Size.fromHeight(51.0),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)), // Change this value to adjust the roundness of corners
              child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
                elevation: 0.0,
                backgroundColor: AppBarStyles.appBarBackgroundColor,
                title: titleWidget ?? _title(context),
                actions: actions,
                leading: leading ?? null,
              automaticallyImplyLeading: automaticallyImplyLeading,
                
              ),
            ),
          ),
      body: body,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _title(BuildContext context) => Text(
        title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: AppTextStyle.poppinsFontFamily,
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w600),
      );
}
