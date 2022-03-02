import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quan_ly_taiducfood/desgin/menu_item.dart';
import 'dart:io';
import 'package:quan_ly_taiducfood/nhaphang_action/theme/nhaphang_theme.dart';
import 'package:flutter/services.dart';
import 'package:quan_ly_taiducfood/customer_action/view/history_customer.dart';
import 'package:quan_ly_taiducfood/main_action/widget/home_widget.dart';
import 'package:quan_ly_taiducfood/products_action/View/product_out_soluong/product_detail_SL.dart';
import 'package:quan_ly_taiducfood/products_action/View/products_search.dart';
import 'package:quan_ly_taiducfood/order_action/View/Order/order_detail_screen.dart';
import 'package:quan_ly_taiducfood/order_action/View/Order/order_list_screen.dart';
import 'products_action/View/product_detail.dart';
import 'products_action/View/product_edit.dart';
import 'statistical_action/View/bao_cao_chi_tiet/loi_nhuan_in_a_day.dart';
import 'statistical_action/View/bao_cao_chi_tiet/doanh_thu_in_a_day.dart';
import 'statistical_action/View/bao_cao_chi_tiet/thanh_toan_in_a_day.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

var fontStyle = TextStyle(color: Colors.white, fontSize: 16);
var fontStyle1 = TextStyle(color: Colors.white54, fontSize: 14);
var fontStyle2 = TextStyle(color: Colors.white54, fontSize: 12);
var menu = [
  'Thị trường',
  'Tin tức',
  'Phân tích',
  'Quản lý tài khoản',
  'Tiện ích',
  'Báo cáo',
  'Cài đặt',
  'Hỗ trợ'
];

var menuList = MenuItem.menuList;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quản Lý Bán Hàng TaiDucFood',
        theme: ThemeData(
          primaryColor: HexColor('#54D3C2'),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: Scaffold(
          drawer: Drawer(
            child: Container(
              child: Column(
                children: [
                  myDrawerHeader(),
                  myDrawerBody(),
                ],
              ),
            ),
          ),
          body: HomeWidget(),
        ),
        routes: {
          ProductDetailScreen.routeName: (ctxPD) => ProductDetailScreen(),
          ProductEdit.routeName: (ctxPE) => ProductEdit(),
          ProductSearchScreen.routeName: (ctxPS) => ProductSearchScreen(),
          OrderListScreen.routeName: (ctxOLS) => OrderListScreen(),
          OrderDetailScreen.routeName: (ctxODS) => OrderDetailScreen(),
          HistoryCustomer.routeName: (ctxHC) => HistoryCustomer(),
          DonhangInADay.routeName: (ctxDIAD) => DonhangInADay(),
          ProductDetailNotification.routeName: (ctxPDN) =>
              ProductDetailNotification(),
          DonhangInADay1.routeName: (ctxDIADA) => DonhangInADay1(),
          DonhangInADay2.routeName: (ctxDIADB) => DonhangInADay2(),
        });
  }
}

Widget myDrawerBody() {
  return Container(
    color: HexColor("001D33"),
    child: Column(
      children: menu.map((e) => menuItem(e)).toList(),
    ),
  );
}

Widget myDrawerHeader() {
  return Column(
    children: [
      Container(
        color: Colors.green,
        padding: EdgeInsets.only(top: 64),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.account_circle_sharp,
                      size: 50,
                      color: Colors.white54,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Cao Thi Niem",
                            style: fontStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Thuong.009C104217",
                        style: fontStyle1,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: HexColor("001D33"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đăng nhập gần nhất: 23/02/2022 15:19:25",
              style: fontStyle2,
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white54,
                    ),
                    hintText: "Tìm kiếm",
                    hintStyle: fontStyle2,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fillColor: HexColor("142F43"),
                  ),
                  style: fontStyle,
                ),
              ),
              height: 40,
            ),
          ],
        ),
      ),
    ],
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

Widget menuItem(String text) {
  return Container(
    color: HexColor("142F43"),
    child: ListTile(
      onTap: () {},
      title: Text(
        text,
        style: fontStyle,
      ),
      leading: Icon(
        Icons.ac_unit_outlined,
        color: Colors.green[900],
      ),
    ),
  );
}
