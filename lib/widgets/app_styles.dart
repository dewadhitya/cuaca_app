import 'package:flutter/material.dart';
import 'package:my_flutter_template/blocs/navigation_bloc.dart';
import 'package:my_flutter_template/models/app_state.dart';
import 'package:my_flutter_template/widgets/text_scale_factor_limiter.dart';
import 'package:rebloc/rebloc.dart';

///scaffold with back button. and default theme.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final BuildContext context;
  final Color? appBarColor;
  final Color? bodyColor;
  final double? elevation;
  final GlobalKey? scaffoldKey;
  final bool automaticallyImplyLeading;
  final bool? centerTitleAppBar;

  //** if we want to call PopAction on this callback, please return Future.value(false) otherwise return true.
  final WillPopCallback? onWillPop;

  const AppScaffold(
      {Key? key,
      required this.body,
      this.title,
      this.actions,
      required this.context,
      this.appBarColor,
      this.bodyColor,
      this.elevation = 4.0,
      this.scaffoldKey,
      this.automaticallyImplyLeading = true,
      this.centerTitleAppBar = true,
      this.onWillPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = ViewModelSubscriber<AppState, AppState>(
        converter: (state) => state,
        builder: (context, dispatcher, appState) {
          return WillPopScope(
            onWillPop: () async {
              if (onWillPop == null) {
                dispatcher(PopAction());
                return Future.value(false);
              }
              bool needBack = await onWillPop!.call();
              if (needBack) {
                dispatcher(PopAction());
              }
              return Future.value(false);
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: bodyColor ?? Theme.of(context).backgroundColor,
              // bottomNavigationBar: CustomApiLabel(),
              appBar: AppBar(
                automaticallyImplyLeading: automaticallyImplyLeading,
                elevation: elevation,
                leading: automaticallyImplyLeading
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.of(context).maybePop(),
                      )
                    : Container(),
                title: Text(
                  title!,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                centerTitle: centerTitleAppBar,
                backgroundColor:
                    appBarColor ?? Theme.of(context).appBarTheme.backgroundColor,
                actions: actions ?? [Container()],
              ),
              body: body,
            ),
          );
        });

    return TextScaleFactorLimiter(
      child: content,
    );
  }
}