import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    int? orgId,
    dynamic branchCode,
    String? code,
    String? name,
    String? productCode,
    String? productName,
    String? specification,
    String? category,
    String? subCategory,
    String? categoryName,
    String? subCategoryName,
    String? uom,
    dynamic uomName,
    num? pcsPerCarton,
    String? productType,
    String? brand,
    num? weight,
    num? unitCost,
    num? averageCost,
    num? pcsPrice,
    num? cartonPrice,
    String? barCode,
    num? displayOrder,
    bool? isActive,
    bool? isStock,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    num? sellingCost,
    double? sellingBoxCost,
    dynamic stockQty,
    dynamic stockBoxQty,
    dynamic stockPcsQty,
    String? salesAccount,
    String? inventoryAccount,
    String? cOGAccount,
    dynamic productImageString,
    dynamic productImage,
    String? createdOnString,
    String? changedOnString,
    String? supplierCode,
    String? supplierName,
    num? taxPerc,
    dynamic productBarcode,
    dynamic boxCount,
    dynamic productImgBase64String,
    String? productImageFileName,
    String? productImagePath,
    num? minSellingCost,
    num? minSellingBoxCost,
    String? tag,
    bool? isWeight,
    dynamic uomPriceDetail,
    dynamic stockWQty,
    num? unitMarginPerc,
    num? boxMarginPerc,
    dynamic haveTransaction,
    dynamic ecommerceDetail,
  }) {
    _orgId = orgId;
    _branchCode = branchCode;
    _code = code;
    _name = name;
    _productCode = productCode;
    _productName = productName;
    _specification = specification;
    _category = category;
    _subCategory = subCategory;
    _categoryName = categoryName;
    _subCategoryName = subCategoryName;
    _uom = uom;
    _uomName = uomName;
    _pcsPerCarton = pcsPerCarton;
    _productType = productType;
    _brand = brand;
    _weight = weight;
    _unitCost = unitCost;
    _averageCost = averageCost;
    _pcsPrice = pcsPrice;
    _cartonPrice = cartonPrice;
    _barCode = barCode;
    _displayOrder = displayOrder;
    _isActive = isActive;
    _isStock = isStock;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _sellingCost = sellingCost;
    _sellingBoxCost = sellingBoxCost;
    _stockQty = stockQty;
    _stockBoxQty = stockBoxQty;
    _stockPcsQty = stockPcsQty;
    _salesAccount = salesAccount;
    _inventoryAccount = inventoryAccount;
    _cOGAccount = cOGAccount;
    _productImageString = productImageString;
    _productImage = productImage;
    _createdOnString = createdOnString;
    _changedOnString = changedOnString;
    _supplierCode = supplierCode;
    _supplierName = supplierName;
    _taxPerc = taxPerc;
    _productBarcode = productBarcode;
    _boxCount = boxCount;
    _productImgBase64String = productImgBase64String;
    _productImageFileName = productImageFileName;
    _productImagePath = productImagePath;
    _minSellingCost = minSellingCost;
    _minSellingBoxCost = minSellingBoxCost;
    _tag = tag;
    _isWeight = isWeight;
    _uomPriceDetail = uomPriceDetail;
    _stockWQty = stockWQty;
    _unitMarginPerc = unitMarginPerc;
    _boxMarginPerc = boxMarginPerc;
    _haveTransaction = haveTransaction;
    _ecommerceDetail = ecommerceDetail;
  }

  ProductModel.fromJson(dynamic json, {bool forSharedPreference = false}) {
    _orgId = json['OrgId'];
    _branchCode = json['BranchCode'];
    _code = json['Code'];
    _name = json['Name'];
    _productCode = json['ProductCode'];
    _productName = json['ProductName'];
    _specification = json['Specification'];
    _category = json['Category'];
    _subCategory = json['SubCategory'];
    _categoryName = json['CategoryName'];
    _subCategoryName = json['SubCategoryName'];
    _uom = json['Uom'];
    _uomName = json['UomName'];
    _pcsPerCarton = json['PcsPerCarton'];
    _productType = json['ProductType'];
    _brand = json['Brand'];
    _weight = json['Weight'];
    _unitCost = json['UnitCost'];
    _averageCost = json['AverageCost'];
    _pcsPrice = json['PcsPrice'];
    _cartonPrice = json['CartonPrice'];
    _barCode = json['BarCode'];
    _displayOrder = json['DisplayOrder'];
    _isActive = json['IsActive'];
    _isStock = json['IsStock'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _sellingCost = json['SellingCost'];
    _sellingBoxCost = json['SellingBoxCost'];
    _stockQty = json['StockQty'];
    _stockBoxQty = json['StockBoxQty'];
    _stockPcsQty = json['StockPcsQty'];
    _salesAccount = json['SalesAccount'];
    _inventoryAccount = json['InventoryAccount'];
    _cOGAccount = json['COGAccount'];
    _productImageString = json['ProductImageString'];
    _productImage = json['ProductImage'];
    _createdOnString = json['CreatedOnString'];
    _changedOnString = json['ChangedOnString'];
    _supplierCode = json['SupplierCode'];
    _supplierName = json['SupplierName'];
    _taxPerc = json['TaxPerc'];
    _productBarcode = json['ProductBarcode'];
    _boxCount = json['BoxCount'];
    _productImgBase64String = json['ProductImg_Base64String'];
    _productImageFileName = json['ProductImageFileName'];
    _productImagePath = json['ProductImagePath'];
    _minSellingCost = json['MinSellingCost'];
    _minSellingBoxCost = json['MinSellingBoxCost'];
    _tag = json['Tag'];
    _isWeight = json['IsWeight'];
    _uomPriceDetail = json['UomPriceDetail'];
    _stockWQty = json['StockWQty'];
    _unitMarginPerc = json['UnitMarginPerc'];
    _boxMarginPerc = json['BoxMarginPerc'];
    _haveTransaction = json['HaveTransaction'];
    _ecommerceDetail = json['EcommerceDetail'];
    if (forSharedPreference == true) {
      qtycount = json['qtycount']  as int? ?? 0;
    }
  }
  int? _orgId;
  dynamic _branchCode;
  String? _code;
  String? _name;
  String? _productCode;
  String? _productName;
  String? _specification;
  String? _category;
  String? _subCategory;
  String? _categoryName;
  String? _subCategoryName;
  String? _uom;
  dynamic _uomName;
  num? _pcsPerCarton;
  String? _productType;
  String? _brand;
  num? _weight;
  num? _unitCost;
  num? _averageCost;
  num? _pcsPrice;
  num? _cartonPrice;
  String? _barCode;
  num? _displayOrder;
  bool? _isActive;
  bool? _isStock;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  num? _sellingCost;
  double? _sellingBoxCost;
  dynamic _stockQty;
  dynamic _stockBoxQty;
  dynamic _stockPcsQty;
  String? _salesAccount;
  String? _inventoryAccount;
  String? _cOGAccount;
  dynamic _productImageString;
  dynamic _productImage;
  String? _createdOnString;
  String? _changedOnString;
  String? _supplierCode;
  String? _supplierName;
  num? _taxPerc;
  dynamic _productBarcode;
  dynamic _boxCount;
  dynamic _productImgBase64String;
  String? _productImageFileName;
  String? _productImagePath;
  num? _minSellingCost;
  num? _minSellingBoxCost;
  String? _tag;
  bool? _isWeight;
  dynamic _uomPriceDetail;
  dynamic _stockWQty;
  num? _unitMarginPerc;
  num? _boxMarginPerc;
  dynamic _haveTransaction;
  dynamic _ecommerceDetail;
  int? slNo = 0;

  bool isfavourite = false;

  ///IncrementDecrement
  int qtycount = 0;
  bool isShowButtons = false;

  increment() {
    qtycount++;
  }

  decrement() {
    if (qtycount > 0) {
      qtycount--;
    }
  }

  ProductModel copyWith({
    int? orgId,
    dynamic branchCode,
    String? code,
    String? name,
    String? productCode,
    String? productName,
    String? specification,
    String? category,
    String? subCategory,
    String? categoryName,
    String? subCategoryName,
    String? uom,
    dynamic uomName,
    num? pcsPerCarton,
    String? productType,
    String? brand,
    num? weight,
    num? unitCost,
    num? averageCost,
    num? pcsPrice,
    num? cartonPrice,
    String? barCode,
    num? displayOrder,
    bool? isActive,
    bool? isStock,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    num? sellingCost,
    double? sellingBoxCost,
    dynamic stockQty,
    dynamic stockBoxQty,
    dynamic stockPcsQty,
    String? salesAccount,
    String? inventoryAccount,
    String? cOGAccount,
    dynamic productImageString,
    dynamic productImage,
    String? createdOnString,
    String? changedOnString,
    String? supplierCode,
    String? supplierName,
    num? taxPerc,
    dynamic productBarcode,
    dynamic boxCount,
    dynamic productImgBase64String,
    String? productImageFileName,
    String? productImagePath,
    num? minSellingCost,
    num? minSellingBoxCost,
    String? tag,
    bool? isWeight,
    dynamic uomPriceDetail,
    dynamic stockWQty,
    num? unitMarginPerc,
    num? boxMarginPerc,
    dynamic haveTransaction,
    dynamic ecommerceDetail,
  }) =>
      ProductModel(
        orgId: orgId ?? _orgId,
        branchCode: branchCode ?? _branchCode,
        code: code ?? _code,
        name: name ?? _name,
        productCode: productCode ?? _productCode,
        productName: productName ?? _productName,
        specification: specification ?? _specification,
        category: category ?? _category,
        subCategory: subCategory ?? _subCategory,
        categoryName: categoryName ?? _categoryName,
        subCategoryName: subCategoryName ?? _subCategoryName,
        uom: uom ?? _uom,
        uomName: uomName ?? _uomName,
        pcsPerCarton: pcsPerCarton ?? _pcsPerCarton,
        productType: productType ?? _productType,
        brand: brand ?? _brand,
        weight: weight ?? _weight,
        unitCost: unitCost ?? _unitCost,
        averageCost: averageCost ?? _averageCost,
        pcsPrice: pcsPrice ?? _pcsPrice,
        cartonPrice: cartonPrice ?? _cartonPrice,
        barCode: barCode ?? _barCode,
        displayOrder: displayOrder ?? _displayOrder,
        isActive: isActive ?? _isActive,
        isStock: isStock ?? _isStock,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        sellingCost: sellingCost ?? _sellingCost,
        sellingBoxCost: sellingBoxCost ?? _sellingBoxCost,
        stockQty: stockQty ?? _stockQty,
        stockBoxQty: stockBoxQty ?? _stockBoxQty,
        stockPcsQty: stockPcsQty ?? _stockPcsQty,
        salesAccount: salesAccount ?? _salesAccount,
        inventoryAccount: inventoryAccount ?? _inventoryAccount,
        cOGAccount: cOGAccount ?? _cOGAccount,
        productImageString: productImageString ?? _productImageString,
        productImage: productImage ?? _productImage,
        createdOnString: createdOnString ?? _createdOnString,
        changedOnString: changedOnString ?? _changedOnString,
        supplierCode: supplierCode ?? _supplierCode,
        supplierName: supplierName ?? _supplierName,
        taxPerc: taxPerc ?? _taxPerc,
        productBarcode: productBarcode ?? _productBarcode,
        boxCount: boxCount ?? _boxCount,
        productImgBase64String:
            productImgBase64String ?? _productImgBase64String,
        productImageFileName: productImageFileName ?? _productImageFileName,
        productImagePath: productImagePath ?? _productImagePath,
        minSellingCost: minSellingCost ?? _minSellingCost,
        minSellingBoxCost: minSellingBoxCost ?? _minSellingBoxCost,
        tag: tag ?? _tag,
        isWeight: isWeight ?? _isWeight,
        uomPriceDetail: uomPriceDetail ?? _uomPriceDetail,
        stockWQty: stockWQty ?? _stockWQty,
        unitMarginPerc: unitMarginPerc ?? _unitMarginPerc,
        boxMarginPerc: boxMarginPerc ?? _boxMarginPerc,
        haveTransaction: haveTransaction ?? _haveTransaction,
        ecommerceDetail: ecommerceDetail ?? _ecommerceDetail,
      );
  int? get orgId => _orgId;
  dynamic get branchCode => _branchCode;
  String? get code => _code;
  String? get name => _name;
  String? get productCode => _productCode;
  String? get productName => _productName;
  String? get specification => _specification;
  String? get category => _category;
  String? get subCategory => _subCategory;
  String? get categoryName => _categoryName;
  String? get subCategoryName => _subCategoryName;
  String? get uom => _uom;
  dynamic get uomName => _uomName;
  num? get pcsPerCarton => _pcsPerCarton;
  String? get productType => _productType;
  String? get brand => _brand;
  num? get weight => _weight;
  num? get unitCost => _unitCost;
  num? get averageCost => _averageCost;
  num? get pcsPrice => _pcsPrice;
  num? get cartonPrice => _cartonPrice;
  String? get barCode => _barCode;
  num? get displayOrder => _displayOrder;
  bool? get isActive => _isActive;
  bool? get isStock => _isStock;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  num? get sellingCost => _sellingCost;
  double? get sellingBoxCost => _sellingBoxCost;
  dynamic get stockQty => _stockQty;
  dynamic get stockBoxQty => _stockBoxQty;
  dynamic get stockPcsQty => _stockPcsQty;
  String? get salesAccount => _salesAccount;
  String? get inventoryAccount => _inventoryAccount;
  String? get cOGAccount => _cOGAccount;
  dynamic get productImageString => _productImageString;
  dynamic get productImage => _productImage;
  String? get createdOnString => _createdOnString;
  String? get changedOnString => _changedOnString;
  String? get supplierCode => _supplierCode;
  String? get supplierName => _supplierName;
  num? get taxPerc => _taxPerc;
  dynamic get productBarcode => _productBarcode;
  dynamic get boxCount => _boxCount;
  dynamic get productImgBase64String => _productImgBase64String;
  String? get productImageFileName => _productImageFileName;
  String? get productImagePath => _productImagePath;
  num? get minSellingCost => _minSellingCost;
  num? get minSellingBoxCost => _minSellingBoxCost;
  String? get tag => _tag;
  bool? get isWeight => _isWeight;
  dynamic get uomPriceDetail => _uomPriceDetail;
  dynamic get stockWQty => _stockWQty;
  num? get unitMarginPerc => _unitMarginPerc;
  num? get boxMarginPerc => _boxMarginPerc;
  dynamic get haveTransaction => _haveTransaction;
  dynamic get ecommerceDetail => _ecommerceDetail;

  Map<String, dynamic> toJson({bool forSharedPreference = false}) {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BranchCode'] = _branchCode;
    map['Code'] = _code;
    map['Name'] = _name;
    map['ProductCode'] = _productCode;
    map['ProductName'] = _productName;
    map['Specification'] = _specification;
    map['Category'] = _category;
    map['SubCategory'] = _subCategory;
    map['CategoryName'] = _categoryName;
    map['SubCategoryName'] = _subCategoryName;
    map['Uom'] = _uom;
    map['UomName'] = _uomName;
    map['PcsPerCarton'] = _pcsPerCarton;
    map['ProductType'] = _productType;
    map['Brand'] = _brand;
    map['Weight'] = _weight;
    map['UnitCost'] = _unitCost;
    map['AverageCost'] = _averageCost;
    map['PcsPrice'] = _pcsPrice;
    map['CartonPrice'] = _cartonPrice;
    map['BarCode'] = _barCode;
    map['DisplayOrder'] = _displayOrder;
    map['IsActive'] = _isActive;
    map['IsStock'] = _isStock;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['SellingCost'] = _sellingCost;
    map['SellingBoxCost'] = _sellingBoxCost;
    map['StockQty'] = _stockQty;
    map['StockBoxQty'] = _stockBoxQty;
    map['StockPcsQty'] = _stockPcsQty;
    map['SalesAccount'] = _salesAccount;
    map['InventoryAccount'] = _inventoryAccount;
    map['COGAccount'] = _cOGAccount;
    map['ProductImageString'] = _productImageString;
    map['ProductImage'] = _productImage;
    map['CreatedOnString'] = _createdOnString;
    map['ChangedOnString'] = _changedOnString;
    map['SupplierCode'] = _supplierCode;
    map['SupplierName'] = _supplierName;
    map['TaxPerc'] = _taxPerc;
    map['ProductBarcode'] = _productBarcode;
    map['BoxCount'] = _boxCount;
    map['ProductImg_Base64String'] = _productImgBase64String;
    map['ProductImageFileName'] = _productImageFileName;
    map['ProductImagePath'] = _productImagePath;
    map['MinSellingCost'] = _minSellingCost;
    map['MinSellingBoxCost'] = _minSellingBoxCost;
    map['Tag'] = _tag;
    map['IsWeight'] = _isWeight;
    map['UomPriceDetail'] = _uomPriceDetail;
    map['StockWQty'] = _stockWQty;
    map['UnitMarginPerc'] = _unitMarginPerc;
    map['BoxMarginPerc'] = _boxMarginPerc;
    map['HaveTransaction'] = _haveTransaction;
    map['EcommerceDetail'] = _ecommerceDetail;
    if (forSharedPreference == true) {
      map['qtycount'] = qtycount;
    }


    return map;
  }
}
