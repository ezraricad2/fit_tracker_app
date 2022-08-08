import 'dart:io';

import 'package:fit_tracker_app/app/screen/home/account_page.dart';
import 'package:fit_tracker_app/app/screen/home/dashboard_page.dart';
import 'package:fit_tracker_app/app/utilities/textstyles.dart';
import 'package:fit_tracker_app/app/utilities/var_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContainer extends StatefulWidget {
  final int tabBarIndex;

  final String emailParam;

  HomeContainer({this.emailParam, this.tabBarIndex});

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {

  int _currentIndex = 0;
  List<dynamic> _children;


  void onTabTapped(int index) {
    tabIndex.value = index;

    setState(() {
      _currentIndex = index;
    });
  }


  @override
  initState() {
    super.initState();
    _currentIndex = widget.tabBarIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {

    _children = [
      DashboardPage(emailParam: widget.emailParam),
      AccountPage(),
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context) => ListStatusOrderCubit()..getListStatusOrder()),
      //     BlocProvider(create: (context) => ListOrderCubit()..getListOrder()),
      //   ],
      //   child: OrderPage(),
      // ),
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context) => ListProductCubit()..getListProduct()),
      //     BlocProvider(create: (context) => ListCategoryCubit()..getListCategory()),
      //     BlocProvider(create: (context) => ListPromoCubit()..getListPromo())
      //   ],
      //   child: ProductContainer(tabBarIndex: _currentIndex),
      // ),
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context) => LoadStatisticDataCubit()),
      //     BlocProvider(create: (context) => BestProductCubit()),
      //     BlocProvider(create: (context) => BestCustomerCubit()..getBestCustomer()),
      //   ],
      //   child: ReportPage(),
      // ),
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context) => GetMerchantInfoCubit()..getMerchantInfo()),
      //     BlocProvider(create: (context) => LogoutCubit()),
      //   ],
      //   child: AccountPage(),
      // ),
    ];

    return ValueListenableBuilder(
      valueListenable: tabIndex,
      builder: (BuildContext context, int value, Widget child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(child: _children[value]),
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: 5.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.grey.withOpacity(0.2)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: value,
            items: [
              _itemBottomNavbar('Dashboard', Icons.layers, Icons.layers),
              _itemBottomNavbar('Dashboard', Icons.layers, Icons.layers),
              // _itemBottomNavbar('Pesanan', Assets.navbarOrder, Assets.navbarOrderSelected),
              // _itemBottomNavbar('Produk', Assets.navbarProduct, Assets.navbarProductSelected),
              // _itemBottomNavbar('Laporan', Assets.navbarReport, Assets.navbarReportSelected),
              // _itemBottomNavbar('Lainnya', Assets.other, Assets.otherSelected),
            ],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _itemBottomNavbar(String title, IconData iconAsset, IconData selectedIconAsset) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
      ),
      title: Text(title, style: p12),
      activeIcon: Icon(
        Icons.layers,
      ),
    );
  }
}





//oldtabsetting
    // Scaffold(
    //   body: Stack(children: [
    //     Container(child: _children[_currentIndex]),
    //     Positioned(
    //       bottom: 0.0,
    //       child: Container(
    //         height: 5.0,
    //         width: MediaQuery.of(context).size.width,
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //               colors: [Colors.transparent, Colors.grey.withOpacity(0.2)],
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter),
    //         ),
    //       ),
    //     ),
    //   ]),
    //   bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     onTap: onTabTapped,
    //     currentIndex: _currentIndex,
    //     selectedItemColor: systemAccentColor,
    //     unselectedItemColor: systemDarkerGreyColor,
    //     items: [
    //       _itemBottomNavbar('Dashboard', Assets.navbarDashboard, Assets.navbarDashboardSelected),
    //       _itemBottomNavbar('Pesanan', Assets.navbarOrder, Assets.navbarOrderSelected),
    //       _itemBottomNavbar('Produk', Assets.navbarProduct, Assets.navbarProductSelected),
    //       _itemBottomNavbar('Laporan', Assets.navbarReport, Assets.navbarReportSelected),
    //       _itemBottomNavbar('Akun', Assets.navbarAccount, Assets.navbarAccountSelected),
    //     ],
    //   ),
    // );