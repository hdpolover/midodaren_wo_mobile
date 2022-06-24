import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/admin_home.dart';
import 'package:midodaren_wo_mobile/presentation/home.dart';
import 'package:midodaren_wo_mobile/presentation/profile.dart';
import 'package:midodaren_wo_mobile/presentation/search.dart';
import 'package:midodaren_wo_mobile/presentation/orders.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Dashboard extends StatefulWidget {
  final BuildContext menuScreenContext;
  AppUser currentUser;

  Dashboard(
      {Key? key, required this.menuScreenContext, required this.currentUser})
      : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    List<Widget> screens = [];
    switch (widget.currentUser.role) {
      case "admin":
        screens = [
          Home(
            menuScreenContext: widget.menuScreenContext,
            user: widget.currentUser,
            hideStatus: _hideNavBar,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Orders(
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            user: widget.currentUser,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Profile(
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            currentUser: widget.currentUser,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ];
        break;
      case "user":
        screens = [
          Home(
            menuScreenContext: widget.menuScreenContext,
            user: widget.currentUser,
            hideStatus: _hideNavBar,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Search(
            user: widget.currentUser,
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Orders(
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            user: widget.currentUser,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Profile(
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            currentUser: widget.currentUser,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ];
        break;
      default:
        screens = [
          Home(
            menuScreenContext: widget.menuScreenContext,
            user: widget.currentUser,
            hideStatus: _hideNavBar,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Search(
            user: widget.currentUser,
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Orders(
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            user: widget.currentUser,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
          Profile(
            menuScreenContext: widget.menuScreenContext,
            hideStatus: _hideNavBar,
            currentUser: widget.currentUser,
            onScreenHideButtonPressed: () {
              setState(() {
                _hideNavBar = !_hideNavBar;
              });
            },
          ),
        ];
        break;
    }

    return screens;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    List<PersistentBottomNavBarItem> navBars = [];
    switch (widget.currentUser.role) {
      case "admin":
        navBars = [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Beranda",
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.list_alt),
            title: ("Pesanan"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: ("Profil"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
        ];
        break;
      case "user":
        navBars = [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Beranda",
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.search),
            title: ("Cari"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.list_alt),
            title: ("Pesanan"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: ("Profil"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
        ];
        break;
      default:
        navBars = [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Beranda",
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.search),
            title: ("Cari"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.list_alt),
            title: ("Pesanan"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: ("Profil"),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white54,
          ),
        ];
        break;
    }
    return navBars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: ColorManager.primary,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        hideNavigationBar: _hideNavBar,
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property
      ),
    );
  }
}
