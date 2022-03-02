class MenuItem {
  MenuItem(
      {this.imagePath = '',
      this.titleTxt = '',
      this.uiId = 0,
      this.childrenMenuItem});
  String imagePath;
  String titleTxt;
  int uiId;
  ChildrenMenuItem childrenMenuItem;

  static List<MenuItem> menuList = <MenuItem>[
    MenuItem(
      imagePath: 'assets/fitness_app/001-bill.png',
      titleTxt: 'Thị Trường',
      uiId: 0,
      childrenMenuItem: null,
    ),
    MenuItem(
      imagePath: 'assets/fitness_app/004-tshirt.png',
      titleTxt: 'Tin tức',
      uiId: 1,
      childrenMenuItem: null,
    ),
    MenuItem(
      imagePath: 'assets/fitness_app/013-truck.png',
      titleTxt: 'Phân tích',
      uiId: 2,
      childrenMenuItem: null,
    ),
    MenuItem(
      imagePath: 'assets/fitness_app/021-invoice.png',
      titleTxt: 'Quản lý tài khoản',
      uiId: 3,
      childrenMenuItem:
          ChildrenMenuItem(id: 3, nameItem: ['Tổng hợp tài sản', 'Nợ ký quỹ']),
    ),
    MenuItem(
      imagePath: 'assets/fitness_app/005-store.png',
      titleTxt: 'Tiện ích',
      uiId: 4,
      childrenMenuItem: null,
    ),
    MenuItem(
      imagePath: 'assets/fitness_app/019-headphone.png',
      titleTxt: 'Báo cáo',
      uiId: 5,
      childrenMenuItem: null,
    ),
    MenuItem(
      imagePath: 'assets/fitness_app/019-headphone.png',
      titleTxt: 'Cài đặt',
      uiId: 6,
      childrenMenuItem: null,
    ),
    MenuItem(
      imagePath: 'assets/fitness_app/019-headphone.png',
      titleTxt: 'Hỗ trợ',
      uiId: 7,
      childrenMenuItem: null,
    ),
  ];
}

class ChildrenMenuItem {
  var id = 0;
  var nameItem = [];
  ChildrenMenuItem({
    this.id,
    this.nameItem,
  });
}
