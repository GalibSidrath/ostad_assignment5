/// _id : "664d62b9e9935d7ad5bb05fd"
/// ProductName : "T-shirt"
/// ProductCode : "t12345"
/// Img : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAygYavZV50FQrrxy8xlXEB2YRzl-dkeuxoHdBFTamjg&s"
/// UnitPrice : "500"
/// Qty : "2"
/// TotalPrice : "1000"
/// CreatedDate : "2024-05-21T08:28:21.484Z"

class ProductModel {
  ProductModel({
      String? id, 
      String? productName, 
      String? productCode, 
      String? img, 
      String? unitPrice, 
      String? qty, 
      String? totalPrice, 
      String? createdDate,}){
    _id = id;
    _productName = productName;
    _productCode = productCode;
    _img = img;
    _unitPrice = unitPrice;
    _qty = qty;
    _totalPrice = totalPrice;
    _createdDate = createdDate;
}

  ProductModel.fromJson(dynamic json) {
    _id = json['_id'];
    _productName = json['ProductName'];
    _productCode = json['ProductCode'];
    _img = json['Img'];
    _unitPrice = json['UnitPrice'];
    _qty = json['Qty'];
    _totalPrice = json['TotalPrice'];
    _createdDate = json['CreatedDate'];
  }
  String? _id;
  String? _productName;
  String? _productCode;
  String? _img;
  String? _unitPrice;
  String? _qty;
  String? _totalPrice;
  String? _createdDate;
ProductModel copyWith({  String? id,
  String? productName,
  String? productCode,
  String? img,
  String? unitPrice,
  String? qty,
  String? totalPrice,
  String? createdDate,
}) => ProductModel(  id: id ?? _id,
  productName: productName ?? _productName,
  productCode: productCode ?? _productCode,
  img: img ?? _img,
  unitPrice: unitPrice ?? _unitPrice,
  qty: qty ?? _qty,
  totalPrice: totalPrice ?? _totalPrice,
  createdDate: createdDate ?? _createdDate,
);
  String? get id => _id;
  String? get productName => _productName;
  String? get productCode => _productCode;
  String? get img => _img;
  String? get unitPrice => _unitPrice;
  String? get qty => _qty;
  String? get totalPrice => _totalPrice;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['ProductName'] = _productName;
    map['ProductCode'] = _productCode;
    map['Img'] = _img;
    map['UnitPrice'] = _unitPrice;
    map['Qty'] = _qty;
    map['TotalPrice'] = _totalPrice;
    map['CreatedDate'] = _createdDate;
    return map;
  }

}