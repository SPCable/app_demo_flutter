import 'dart:collection';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_taiducfood/main.dart';
import 'package:quan_ly_taiducfood/products_action/models/product_cate_data.dart';

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  String id,
      brand,
      name,
      image,
      price,
      barcode,
      weight,
      cate,
      priceNhap,
      priceBuon,
      priceVon,
      amount,
      desc;
  String _data = "";
  bool tax = false;
  bool allowSale = false;

  File _image;

  var formKey = GlobalKey<FormState>();

  final _controllerAmount = MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');
  final _controllerWeight = MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');
  final _controllerPriceVon = MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');
  final _controllerPrice = MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');
  final _controllerPriceNhap = MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');
  final _controllerPriceBuon = MoneyMaskedTextController(
      precision: 0, decimalSeparator: '', thousandSeparator: ',');

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FF0000", "Cancel", true, ScanMode.DEFAULT)
        .then((value) => setState(() => {
              if (value == "-1") {_data = '0'} else {_data = value}
            }));
    print(_data);
  }

  ProductCate productCate;
  // ignore: non_constant_identifier_names
  List<ProductCate> data_cate = <ProductCate>[
    ProductCate(1, 'Thi??t Bo?? U??c'),
    ProductCate(2, 'Thi??t Ga??'),
    ProductCate(3, 'Thi??t Bo?? My??'),
    ProductCate(4, 'Thi??t C????u'),
    ProductCate(5, 'Thi??t D??'),
    ProductCate(6, 'Thi??t Heo'),
    ProductCate(7, 'Thi??t Tr??u'),
    ProductCate(8, 'Ha??i Sa??n'),
    ProductCate(9, 'Sa??n Ph????m Kha??c'),
  ];

  @override
  void initState() {
    super.initState();
    productCate = data_cate[0];
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print(_image);
      });
    }

    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(
          'Th??m sa??n ph????m',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.check),
        //     onPressed: () {},
        //     color: Colors.white,
        //   ),
        // ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            height: 1000,
            padding: EdgeInsets.only(top: 0),
            child: Column(
              children: [
                new Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              width: 200,
                              height: 150,
                              child: (_image != null)
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      "https://nameproscdn.com/a/2018/05/106343_82907bfea9fe97e84861e2ee7c5b4f5b.png",
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: new Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Ch??a nh????p T??n sa??n ph????m';
                                } else {
                                  name = value;
                                }
                              },
                              autocorrect: true,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                labelText: 'T??n sa??n ph????m',
                              ),
                            ),
                            new TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Ch??a nh????p Ma?? sa??n ph????m';
                                } else {
                                  id = value;
                                }
                              },
                              autocorrect: true,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                labelText: 'Ma?? sa??n ph????m',
                              ),
                            ),
                            new TextFormField(
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Ch??a nh????p Barcode sa??n ph????m';
                                  } else {
                                    barcode = value;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                key: Key(_data), // <- Magic!
                                initialValue: _data,
                                //controller: _controller,
                                //onChanged: (text) {},
                                autocorrect: true,
                                decoration: InputDecoration(
                                  labelText: 'Barcode',
                                  suffixIcon: IconButton(
                                      autofocus: false,
                                      onPressed: () => _scan(),
                                      icon:
                                          Icon(Icons.qr_code_scanner_outlined)),
                                )),
                            new TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty || value == '0') {
                                  return 'Ch??a nh????p Kh????i l??????ng sa??n ph????m';
                                } else {
                                  weight = value;
                                }
                              },
                              controller: _controllerWeight,
                              autocorrect: true,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                labelText: 'Kh????i l??????ng (g)',
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: new Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 140,
                                  child: new TextFormField(
                                    // ignore: missing_return
                                    validator: (value) {
                                      if (value.isEmpty || value == '0') {
                                        return 'Ch??a nh????p T????n kho sa??n ph????m';
                                      } else {
                                        amount = value;
                                      }
                                    },
                                    controller: _controllerAmount,
                                    decoration: InputDecoration(
                                      labelText: 'T????n kho',
                                    ),
                                    keyboardType: TextInputType.number,
                                    autocorrect: true,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  child: new TextFormField(
                                    // ignore: missing_return
                                    validator: (value) {
                                      if (value.isEmpty || value == '0') {
                                        return 'Ch??a nh????p Gia?? v????n sa??n ph????m';
                                      } else {
                                        priceVon = value;
                                      }
                                    },
                                    controller: _controllerPriceVon,
                                    autocorrect: true,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                    decoration: InputDecoration(
                                      labelText: 'Gia?? v????n',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 140,
                                  child: new TextFormField(
                                    // ignore: missing_return
                                    validator: (value) {
                                      if (value.isEmpty || value == '0') {
                                        return 'Ch??a nh????p Gia?? ba??n le?? sa??n ph????m';
                                      } else {
                                        price = value;
                                      }
                                    },
                                    controller: _controllerPrice,
                                    decoration: InputDecoration(
                                      labelText: 'Gia?? ba??n le??',
                                    ),
                                    keyboardType: TextInputType.number,
                                    autocorrect: true,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  child: new TextFormField(
                                    // ignore: missing_return
                                    validator: (value) {
                                      if (value.isEmpty || value == '0') {
                                        return 'Ch??a nh????p Gia?? ba??n bu??n sa??n ph????m';
                                      } else {
                                        priceBuon = value;
                                      }
                                    },
                                    controller: _controllerPriceBuon,
                                    autocorrect: true,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                    decoration: InputDecoration(
                                      labelText: 'Gia?? ba??n bu??n',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: new TextFormField(
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty || value == '0') {
                                    return 'Ch??a nh????p Gia?? nh????p sa??n ph????m';
                                  } else {
                                    priceNhap = value;
                                  }
                                },
                                controller: _controllerPriceNhap,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                decoration: InputDecoration(
                                  labelText: 'Gia?? nh????p',
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                    child: new Text(
                                  'A??p du??ng thu????',
                                  style: new TextStyle(fontSize: 17),
                                )),
                                Container(
                                    child: new Switch(
                                        activeColor: HexColor('#54D3C2'),
                                        value: tax,
                                        onChanged: (bool s) {
                                          setState(() {
                                            tax = s;
                                            print(tax);
                                          });
                                        }))
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: new Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text('Loa??i sa??n ph????m'),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  new DropdownButton<ProductCate>(
                                    value: productCate,
                                    onChanged: (ProductCate newValue) {
                                      setState(() {
                                        productCate = newValue;
                                        print(
                                            "Loa??i: ${productCate.name}  ----  Id : ${productCate.id}");
                                      });
                                    },
                                    items: data_cate.map((ProductCate pdCate) {
                                      return new DropdownMenuItem<ProductCate>(
                                        value: pdCate,
                                        child: new Text(
                                          pdCate.name,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            // new Text(
                            //     "Loa??i: ${productCate.name}  ----  Id : ${productCate.id}"),
                            Container(
                              child: new TextFormField(
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    brand = 'Kh??ng co?? th????ng hi????u';
                                  } else {
                                    brand = value;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Th????ng Hi????u',
                                ),
                                autocorrect: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),
                            Container(
                              child: new TextFormField(
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    desc = 'Kh??ng co?? m?? ta??';
                                  } else {
                                    desc = value;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'M?? ta??',
                                ),
                                autocorrect: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                    child: new Text(
                                  'Cho phe??p ba??n',
                                  style: new TextStyle(fontSize: 17),
                                )),
                                Container(
                                    child: new Switch(
                                        activeColor: HexColor('#54D3C2'),
                                        value: allowSale,
                                        onChanged: (bool s) {
                                          setState(() {
                                            allowSale = s;
                                            print(allowSale);
                                          });
                                        })),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 33,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_image == null) {
              Fluttertoast.showToast(
                  msg: "Sa??n ph????m ch??a co?? a??nh",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.black87,
                  fontSize: 16.0);
            } else {
              checkId(context);
            }
          },
          backgroundColor: HexColor('#54D3C2'),
          label: Text('L??u'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  checkId(BuildContext context) {
    String idFood = productCate.id.toString();

    // ignore: missing_return
    bool cId() {
      if (formKey.currentState.validate()) {
        print('b');
        return false;
      }
    }

    if (cId() == false) {
      print('-----------------');
      print('ch??a co?? sp thi??m ??i');
      uploadImg();
      uploadSearchList();
      upload();
      Fluttertoast.showToast(
          msg: "Th??m sa??n ph????m tha??nh c??ng",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.black87,
          fontSize: 16.0);
      Navigator.pop(context);
    }
    if (cId() == true) {
      print('-----------------');
      print('co?? sp r thi??m ??i');
    }
  }

  Future<void> uploadImg() async {}

  Future<void> upload() async {
    final now = DateTime.now();
    String fileName = basename(_image.path);
    String idFood = productCate.id.toString();
    if (formKey.currentState.validate()) {

      HashMap mapProList = new HashMap();

      weight = weight.replaceAll(",", "");
      price = price.replaceAll(",", "");
      priceBuon = priceBuon.replaceAll(",", "");
      priceNhap = priceNhap.replaceAll(",", "");
      priceVon = priceVon.replaceAll(",", "");
      amount = amount.replaceAll(",", "");

      mapProList["id"] = id;
      mapProList["brand"] = brand;
      mapProList["image"] = fileName;
      mapProList["name"] = name;
      mapProList["price"] = price;
      mapProList["barcode"] = barcode;
      mapProList["weight"] = weight;
      mapProList["cate"] = productCate.id.toString();
      mapProList["priceNhap"] = priceNhap;
      mapProList["priceBuon"] = priceBuon;
      mapProList["priceVon"] = priceVon;
      mapProList["amount"] = amount;
      mapProList["desc"] = desc;
      mapProList["allowSale"] = allowSale;
      mapProList["tax"] = tax;
      mapProList["ngayUp"] = DateFormat('dd/MM/yyyy').format(now).toString();
      mapProList["daban"] = "0";

    }
  }

  Future<void> uploadSearchList() async {
    String fileName = basename(_image.path);
    DateTime now = DateTime.now();
    if (formKey.currentState.validate()) {


      HashMap mapSearch = new HashMap();

      price = price.replaceAll(",", "");

      mapSearch["id"] = id;
      mapSearch["image"] = fileName;
      mapSearch["brand"] = brand;
      mapSearch["name"] = name;
      mapSearch["price"] = price;
      mapSearch["idMain"] = productCate.id.toString();
      mapSearch["dateUp"] = now.toString();

    }
  }
}
