import 'dart:io';
import 'package:flutter_image/network.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quan_ly_taiducfood/products_action/models/product_cate_data.dart';

import '../../main.dart';

class ProductEdit extends StatefulWidget {
  @override
  _ProductEditState createState() => _ProductEditState();
  static const routeName = '/product-edit';
}

class _ProductEditState extends State<ProductEdit> {
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

  String _downloadImgUrl;
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

  TextEditingController _controllerEditId = TextEditingController();
  TextEditingController _controllerEditName = TextEditingController();
  TextEditingController _controllerEditBrand = TextEditingController();
  TextEditingController _controllerEditImage = TextEditingController();
  // TextEditingController _controllerEditBarcode = TextEditingController();
  TextEditingController _controllerEditDesc = TextEditingController();

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FF0000", "Cancel", true, ScanMode.DEFAULT)
        .then((value) => setState(() => {
              if (value == "-1") {_data = '0'} else {_data = value}
            }));
    // print(_data);
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
    ProductCate(10, ' '),
  ];

  Future downdloadImage() async {
   
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Map data = ModalRoute.of(this.context).settings.arguments;
      _controllerEditId.text = data['id'];
      _controllerEditName.text = data['name'];
      _controllerEditBrand.text = data['brand'];
      _controllerEditImage.text = data['image'];
      _controllerPrice.text = data['price'];
      _data = data['barcode'];
      _controllerEditDesc.text = data['desc'];
      _controllerAmount.text = data['amount'];
      _controllerPriceNhap.text = data['priceNhap'];
      _controllerPriceBuon.text = data['priceBuon'];
      _controllerPriceVon.text = data['priceVon'];
      _controllerWeight.text = data['weight'];
      if (data['allowSale'] == 'true') {
        allowSale = true;
      } else {
        allowSale = false;
      }
      if (data['tax'] == 'true') {
        tax = true;
      } else {
        tax = false;
      }
      int idMainInt = int.parse(data['idMain'].toString() == "null"
              ? "10"
              : data['idMain'].toString()) -
          1;
      productCate = data_cate[idMainInt];
      // print(data['image']);
      // print(image + "  aaaaaa");
      // print(_image.toString() + "  bbbbb");
      // print(_downloadImgUrl + "  cccccc");
      downdloadImage();
    });
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      // print(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text(
          "S????a sa??n ph????m",
          style: TextStyle(
            color: Colors.white,
          ),
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
            height: MediaQuery.of(context).size.height * 1.85,
            padding: EdgeInsets.only(top: 10),
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
                              //print(Image.file(_image));
                            },
                            child: Container(
                              width: 250,
                              height: 230,
                              child: (_image == null)
                                  ? Image(
                                      image: new NetworkImageWithRetry(
                                          _downloadImgUrl == null
                                              ? _controllerEditImage.text
                                              : _downloadImgUrl),
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ]),
                  ),
                ),
                // Text("$_image"),
                // Text("$_downloadImgUrl"),
                // Text(_controllerEditImage.text.toString()),
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
                              controller: _controllerEditName,
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
                                controller: _controllerEditId,
                                // ignore: missing_return
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Ch??a nh????p Ma?? sa??n ph????m';
                                  } else {
                                    id = value;
                                  }
                                },
                                enabled: false,
                                autocorrect: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                decoration: InputDecoration(
                                  labelText: 'Ma?? sa??n ph????m',
                                )),
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
                                key: Key(_data),
                                initialValue: _data,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  labelText: 'Barcode',
                                  suffixIcon: IconButton(
                                      autofocus: false,
                                      onPressed: () {
                                        setState(() {
                                          _data = "0";
                                          _scan();
                                        });
                                      },
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
                            productCate.name == " "
                                ? SizedBox()
                                : new Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      new Text('Loa??i sa??n ph????m'),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            // new DropdownButton<ProductCate>(
                                            //   value: productCate,
                                            //   onChanged: (ProductCate newValue) {
                                            //     setState(() {
                                            //       productCate = newValue;
                                            //       print(
                                            //           "Loa??i: ${productCate.name}  ----  Id : ${productCate.id}");
                                            //     });
                                            //   },
                                            //   items: data_cate.map((ProductCate pdCate) {
                                            //     return new DropdownMenuItem<ProductCate>(
                                            //       value: pdCate,
                                            //       child: new Text(
                                            //         pdCate.name,
                                            //       ),
                                            //     );
                                            //   }).toList(),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      new Text(
                                        "${productCate.name}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                            Container(
                              child: new TextFormField(
                                controller: _controllerEditBrand,
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
                                controller: _controllerEditDesc,
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
            edit();
            editSearchList();
            if (_image != null) {
              editImg();
            }
            Fluttertoast.showToast(
                msg: "S????a sa??n ph????m tha??nh c??ng",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.black87,
                fontSize: 16.0);
            Navigator.of(context).pop();
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

  Future<void> editImg() async {}

  Future<void> edit() async {
    String fileName;
    if (_image != null) {
      fileName = basename(_image.path);
      print(fileName);
    } else {
      fileName = _controllerEditImage.text.toString();
      print(fileName);
    }
    String _controllerPriceString;
    String _controllerPriceVonString;
    String _controllerPriceBuonString;
    String _controllerPriceNhapString;
    String _controllerAmountString;
    String _controllerWeightString;
    String idFood = productCate.id.toString();
    if (formKey.currentState.validate()) {
      _controllerPriceString =
          _controllerPrice.text.toString().replaceAll(",", "");
      _controllerPriceVonString =
          _controllerPriceVon.text.toString().replaceAll(",", "");
      _controllerPriceNhapString =
          _controllerPriceNhap.text.toString().replaceAll(",", "");
      _controllerPriceBuonString =
          _controllerPriceBuon.text.toString().replaceAll(",", "");
      _controllerAmountString =
          _controllerAmount.text.toString().replaceAll(",", "");
      _controllerWeightString =
          _controllerWeight.text.toString().replaceAll(",", "");

      // print(_controllerEditName.text.toString());
      // print(_controllerEditBrand.text.toString());
      // print(_controllerPriceString.toString());
      // print(allowSale);
      // print(tax);
      // print(_controllerWeightString.toString());
      // print(_controllerAmountString.toString());
      // print(_controllerPriceNhapString.toString());
      // print(_controllerPriceBuonString.toString());
      // print(_controllerPriceVonString.toString());
      // print(_controllerEditDesc.text.toString());
      // print(barcode.toString());

    }
  }

  Future<void> editSearchList() async {
    String _controllerPriceString;
    String fileName;
    if (_image != null) {
      fileName = basename(_image.path);
    } else {
      fileName = _controllerEditImage.text.toString();
    }

    if (formKey.currentState.validate()) {
      _controllerPriceString =
          _controllerPrice.text.toString().replaceAll(",", "");
      print(_controllerPriceString);
    }
  }
}
