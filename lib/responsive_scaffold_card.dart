library responsive_scaffold_card;

import 'package:flutter/material.dart';

class ResponsiveScaffoldCard extends StatefulWidget {
  final List<Widget> actions;
  final Widget body;
  final Widget drawer;
  final Widget endDrawer;
  final String title;
  final PreferredSizeWidget bottom;

  const ResponsiveScaffoldCard({
    Key key,
    this.actions,
    @required this.body,
    this.bottom,
    this.drawer,
    this.endDrawer,
    @required this.title,
  }) : super(key: key);

  @override
  _ResponsiveScaffoldCardState createState() => _ResponsiveScaffoldCardState();
}

class _ResponsiveScaffoldCardState extends State<ResponsiveScaffoldCard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isSmallScreen {
    return MediaQuery.of(context).size.width <= 640;
  }

  bool get isMediumScreen {
    return MediaQuery.of(context).size.width <= 1024;
  }

  bool get isLargeScreen {
    return MediaQuery.of(context).size.width > 1024;
  }

  @override
  Widget build(BuildContext context) {
    if (isSmallScreen) {
      return _smallScreen;
    } else if (isMediumScreen) {
      return _mediumScreen;
    } else {
      return _largeScreen;
    }
  }

  Widget get _smallScreen {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar,
      body: widget.body,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
    );
  }

  Widget get _mediumScreen {
    return Material(
      child: Row(
        children: [
          widget.drawer == null
              ? Container()
              : Card(child: Container(width: 256, child: widget.drawer)),
          Expanded(
            child: widget.drawer != null
                ? Card(
                    child: Scaffold(
                      key: _scaffoldKey,
                      appBar: _appBar,
                      body: widget.body,
                      endDrawer: widget.endDrawer,
                    ),
                  )
                : Scaffold(
                    key: _scaffoldKey,
                    appBar: _appBar,
                    body: widget.body,
                    endDrawer: widget.endDrawer,
                  ),
          ),
        ],
      ),
    );
  }

  Widget get _largeScreen {
    return Material(
      child: Row(
        children: [
          widget.drawer == null
              ? Container()
              : Card(child: Container(width: 256, child: widget.drawer)),
          Expanded(
            child: widget.drawer != null || widget.endDrawer != null
                ? Card(
                    child: Scaffold(
                      appBar: _appBar,
                      body: widget.body,
                    ),
                  )
                : Scaffold(
                    appBar: _appBar,
                    body: widget.body,
                  ),
          ),
          widget.endDrawer == null
              ? Container()
              : Card(child: Container(width: 256, child: widget.endDrawer)),
        ],
      ),
    );
  }

  AppBar get _appBar {
    List<Widget> _actions = List<Widget>();

    if (widget.actions != null) {
      for (var action in widget.actions) {
        _actions.add(action);
      }
    }

    if (widget.endDrawer != null && !isLargeScreen) {
      _actions.add(
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      );
    }

    return AppBar(
      centerTitle: false,
      actions: _actions,
      bottom: widget.bottom,
      title: Text(widget.title),
    );
  }
}
