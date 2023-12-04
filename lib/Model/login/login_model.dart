import 'dart:convert';

/// OrgId : 0
/// BranchCode : "string"
/// B2CCustomerId : "string"
/// B2CCustomerName : "string"
/// EmailId : "string"
/// Password : "string"
/// AddressLine1 : "string"
/// AddressLine2 : "string"
/// AddressLine3 : "string"
/// MobileNo : "string"
/// CountryId : "string"
/// PostalCode : "string"
/// IsActive : true
/// IsApproved : true
/// CreatedBy : "string"
/// CreatedOn : "2023-07-13T16:49:45.602Z"
/// ChangedBy : "string"
/// ChangedOn : "2023-07-13T16:49:45.602Z"
/// Orders : [{"OrgId":0,"BrachCode":"string","OrderNo":"string","OrderDate":"2023-07-13T16:49:45.603Z","CustomerId":"string","CustomerName":"string","CustomerAddress":"string","PostalCode":"string","TaxCode":0,"TaxType":"string","TaxPerc":0,"CurrencyCode":"string","CurrencyRate":0,"Total":0,"BillDiscount":0,"BillDiscountPerc":0,"SubTotal":0,"Tax":0,"NetTotal":0,"PaymentType":"string","PaidAmount":0,"Remarks":"string","IsActive":true,"CreatedBy":"string","CreatedOn":"2023-07-13T16:49:45.603Z","ChangedBy":"string","ChangedOn":"2023-07-13T16:49:45.603Z","Status":0,"CustomerShipToId":0,"CustomerShipToAddress":"string","Latitude":0,"Longitude":0,"Signatureimage":"string","Cameraimage":"string","OrderDateString":"string","CreatedFrom":"string","OrderDetail":[{"OrgId":0,"OrderNo":"string","SlNo":0,"ProductCode":"string","ProductName":"string","Qty":0,"Price":0,"Foc":0,"Total":0,"ItemDiscount":0,"ItemDiscountPerc":0,"SubTotal":0,"Tax":0,"NetTotal":0,"TaxCode":0,"TaxType":"string","TaxPerc":0,"Remarks":"string","CreatedBy":"string","CreatedOn":"2023-07-13T16:49:45.603Z","ChangedBy":"string","ChangedOn":"2023-07-13T16:49:45.603Z","Weight":0}]}]
/// Address : [{"OrgId":0,"DeliveryId":0,"CustomerId":"string","Name":"string","AddressLine1":"string","AddressLine2":"string","AddressLine3":"string","CountryId":"string","PostalCode":"string","Mobile":"string","Phone":"string","Fax":"string","IsDefault":true,"IsActive":true,"CreatedBy":"string","CreatedOn":"2023-07-13T16:49:45.603Z","ChangedBy":"string","ChangedOn":"2023-07-13T16:49:45.603Z"}]

B2cLoginModel b2cCustomerRegModelFromJson(String str) =>
    B2cLoginModel.fromJson(json.decode(str));
String b2cCustomerRegModelToJson(B2cLoginModel data) =>
    json.encode(data.toJson());

class B2cLoginModel {
  B2cLoginModel({
    int? orgId,
    String? branchCode,
    String? b2CCustomerId,
    String? b2CCustomerName,
    String? emailId,
    String? password,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? mobileNo,
    String? countryId,
    String? postalCode,
    bool? isActive,
    bool? isApproved,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    List<Orders>? orders,
    List<Address>? addresses,
  }) {
    _orgId = orgId;
    _branchCode = branchCode;
    _b2CCustomerId = b2CCustomerId;
    _b2CCustomerName = b2CCustomerName;
    _emailId = emailId;
    _password = password;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressLine3 = addressLine3;
    _mobileNo = mobileNo;
    _countryId = countryId;
    _postalCode = postalCode;
    _isActive = isActive;
    _isApproved = isApproved;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _orders = orders;
    _address = address;
  }

  B2cLoginModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _branchCode = json['BranchCode'];
    _b2CCustomerId = json['B2CCustomerId'];
    _b2CCustomerName = json['B2CCustomerName'];
    _emailId = json['EmailId'];
    _password = json['Password'];
    _addressLine1 = json['AddressLine1'];
    _addressLine2 = json['AddressLine2'];
    _addressLine3 = json['AddressLine3'];
    _mobileNo = json['MobileNo'];
    _countryId = json['CountryId'];
    _postalCode = json['PostalCode'];
    _isActive = json['IsActive'];
    _isApproved = json['IsApproved'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    if (json['Orders'] != null) {
      _orders = [];
      json['Orders'].forEach((v) {
        _orders?.add(Orders.fromJson(v));
      });
    }
    if (json['Address'] != null) {
      _address = [];
      json['Address'].forEach((v) {
        _address?.add(Address.fromJson(v));
      });
    }
  }
  int? _orgId;
  String? _branchCode;
  String? _b2CCustomerId;
  String? _b2CCustomerName;
  String? _emailId;
  String? _password;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _mobileNo;
  String? _countryId;
  String? _postalCode;
  bool? _isActive;
  bool? _isApproved;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  List<Orders>? _orders;
  List<Address>? _address;
  B2cLoginModel copyWith({
    int? orgId,
    String? branchCode,
    String? b2CCustomerId,
    String? b2CCustomerName,
    String? emailId,
    String? password,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? mobileNo,
    String? countryId,
    String? postalCode,
    bool? isActive,
    bool? isApproved,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    List<Orders>? orders,
    List<Address>? address,
  }) =>
      B2cLoginModel(
        orgId: orgId ?? _orgId,
        branchCode: branchCode ?? _branchCode,
        b2CCustomerId: b2CCustomerId ?? _b2CCustomerId,
        b2CCustomerName: b2CCustomerName ?? _b2CCustomerName,
        emailId: emailId ?? _emailId,
        password: password ?? _password,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        addressLine3: addressLine3 ?? _addressLine3,
        mobileNo: mobileNo ?? _mobileNo,
        countryId: countryId ?? _countryId,
        postalCode: postalCode ?? _postalCode,
        isActive: isActive ?? _isActive,
        isApproved: isApproved ?? _isApproved,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        orders: orders ?? _orders,
        addresses: address ?? _address,
      );
  int? get orgId => _orgId;
  String? get branchCode => _branchCode;
  String? get b2CCustomerId => _b2CCustomerId;
  String? get b2CCustomerName => _b2CCustomerName;
  String? get emailId => _emailId;
  String? get password => _password;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get addressLine3 => _addressLine3;
  String? get mobileNo => _mobileNo;
  String? get countryId => _countryId;
  String? get postalCode => _postalCode;
  bool? get isActive => _isActive;
  bool? get isApproved => _isApproved;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  List<Orders>? get orders => _orders;
  List<Address>? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BranchCode'] = _branchCode;
    map['B2CCustomerId'] = _b2CCustomerId;
    map['B2CCustomerName'] = _b2CCustomerName;
    map['EmailId'] = _emailId;
    map['Password'] = _password;
    map['AddressLine1'] = _addressLine1;
    map['AddressLine2'] = _addressLine2;
    map['AddressLine3'] = _addressLine3;
    map['MobileNo'] = _mobileNo;
    map['CountryId'] = _countryId;
    map['PostalCode'] = _postalCode;
    map['IsActive'] = _isActive;
    map['IsApproved'] = _isApproved;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    if (_orders != null) {
      map['Orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    if (_address != null) {
      map['Address'] = _address?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// OrgId : 0
/// DeliveryId : 0
/// CustomerId : "string"
/// Name : "string"
/// AddressLine1 : "string"
/// AddressLine2 : "string"
/// AddressLine3 : "string"
/// CountryId : "string"
/// PostalCode : "string"
/// Mobile : "string"
/// Phone : "string"
/// Fax : "string"
/// IsDefault : true
/// IsActive : true
/// CreatedBy : "string"
/// CreatedOn : "2023-07-13T16:49:45.603Z"
/// ChangedBy : "string"
/// ChangedOn : "2023-07-13T16:49:45.603Z"

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    int? orgId,
    int? deliveryId,
    String? customerId,
    String? name,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? countryId,
    String? postalCode,
    String? mobile,
    String? phone,
    String? fax,
    bool? isDefault,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
  }) {
    _orgId = orgId;
    _deliveryId = deliveryId;
    _customerId = customerId;
    _name = name;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressLine3 = addressLine3;
    _countryId = countryId;
    _postalCode = postalCode;
    _mobile = mobile;
    _phone = phone;
    _fax = fax;
    _isDefault = isDefault;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
  }

  Address.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _deliveryId = json['DeliveryId'];
    _customerId = json['CustomerId'];
    _name = json['Name'];
    _addressLine1 = json['AddressLine1'];
    _addressLine2 = json['AddressLine2'];
    _addressLine3 = json['AddressLine3'];
    _countryId = json['CountryId'];
    _postalCode = json['PostalCode'];
    _mobile = json['Mobile'];
    _phone = json['Phone'];
    _fax = json['Fax'];
    _isDefault = json['IsDefault'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
  }
  int? _orgId;
  int? _deliveryId;
  String? _customerId;
  String? _name;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _countryId;
  String? _postalCode;
  String? _mobile;
  String? _phone;
  String? _fax;
  bool? _isDefault;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  Address copyWith({
    int? orgId,
    int? deliveryId,
    String? customerId,
    String? name,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? countryId,
    String? postalCode,
    String? mobile,
    String? phone,
    String? fax,
    bool? isDefault,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
  }) =>
      Address(
        orgId: orgId ?? _orgId,
        deliveryId: deliveryId ?? _deliveryId,
        customerId: customerId ?? _customerId,
        name: name ?? _name,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        addressLine3: addressLine3 ?? _addressLine3,
        countryId: countryId ?? _countryId,
        postalCode: postalCode ?? _postalCode,
        mobile: mobile ?? _mobile,
        phone: phone ?? _phone,
        fax: fax ?? _fax,
        isDefault: isDefault ?? _isDefault,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
      );
  int? get orgId => _orgId;
  int? get deliveryId => _deliveryId;
  String? get customerId => _customerId;
  String? get name => _name;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get addressLine3 => _addressLine3;
  String? get countryId => _countryId;
  String? get postalCode => _postalCode;
  String? get mobile => _mobile;
  String? get phone => _phone;
  String? get fax => _fax;
  bool? get isDefault => _isDefault;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['DeliveryId'] = _deliveryId;
    map['CustomerId'] = _customerId;
    map['Name'] = _name;
    map['AddressLine1'] = _addressLine1;
    map['AddressLine2'] = _addressLine2;
    map['AddressLine3'] = _addressLine3;
    map['CountryId'] = _countryId;
    map['PostalCode'] = _postalCode;
    map['Mobile'] = _mobile;
    map['Phone'] = _phone;
    map['Fax'] = _fax;
    map['IsDefault'] = _isDefault;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    return map;
  }
}

/// OrgId : 0
/// BrachCode : "string"
/// OrderNo : "string"
/// OrderDate : "2023-07-13T16:49:45.603Z"
/// CustomerId : "string"
/// CustomerName : "string"
/// CustomerAddress : "string"
/// PostalCode : "string"
/// TaxCode : 0
/// TaxType : "string"
/// TaxPerc : 0
/// CurrencyCode : "string"
/// CurrencyRate : 0
/// Total : 0
/// BillDiscount : 0
/// BillDiscountPerc : 0
/// SubTotal : 0
/// Tax : 0
/// NetTotal : 0
/// PaymentType : "string"
/// PaidAmount : 0
/// Remarks : "string"
/// IsActive : true
/// CreatedBy : "string"
/// CreatedOn : "2023-07-13T16:49:45.603Z"
/// ChangedBy : "string"
/// ChangedOn : "2023-07-13T16:49:45.603Z"
/// Status : 0
/// CustomerShipToId : 0
/// CustomerShipToAddress : "string"
/// Latitude : 0
/// Longitude : 0
/// Signatureimage : "string"
/// Cameraimage : "string"
/// OrderDateString : "string"
/// CreatedFrom : "string"
/// OrderDetail : [{"OrgId":0,"OrderNo":"string","SlNo":0,"ProductCode":"string","ProductName":"string","Qty":0,"Price":0,"Foc":0,"Total":0,"ItemDiscount":0,"ItemDiscountPerc":0,"SubTotal":0,"Tax":0,"NetTotal":0,"TaxCode":0,"TaxType":"string","TaxPerc":0,"Remarks":"string","CreatedBy":"string","CreatedOn":"2023-07-13T16:49:45.603Z","ChangedBy":"string","ChangedOn":"2023-07-13T16:49:45.603Z","Weight":0}]

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));
String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  Orders({
    int? orgId,
    String? brachCode,
    String? orderNo,
    String? orderDate,
    String? customerId,
    String? customerName,
    String? customerAddress,
    String? postalCode,
    int? taxCode,
    String? taxType,
    int? taxPerc,
    String? currencyCode,
    int? currencyRate,
    int? total,
    int? billDiscount,
    int? billDiscountPerc,
    int? subTotal,
    int? tax,
    int? netTotal,
    String? paymentType,
    int? paidAmount,
    String? remarks,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    int? status,
    int? customerShipToId,
    String? customerShipToAddress,
    int? latitude,
    int? longitude,
    String? signatureimage,
    String? cameraimage,
    String? orderDateString,
    String? createdFrom,
    List<OrderDetail>? orderDetail,
  }) {
    _orgId = orgId;
    _brachCode = brachCode;
    _orderNo = orderNo;
    _orderDate = orderDate;
    _customerId = customerId;
    _customerName = customerName;
    _customerAddress = customerAddress;
    _postalCode = postalCode;
    _taxCode = taxCode;
    _taxType = taxType;
    _taxPerc = taxPerc;
    _currencyCode = currencyCode;
    _currencyRate = currencyRate;
    _total = total;
    _billDiscount = billDiscount;
    _billDiscountPerc = billDiscountPerc;
    _subTotal = subTotal;
    _tax = tax;
    _netTotal = netTotal;
    _paymentType = paymentType;
    _paidAmount = paidAmount;
    _remarks = remarks;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _status = status;
    _customerShipToId = customerShipToId;
    _customerShipToAddress = customerShipToAddress;
    _latitude = latitude;
    _longitude = longitude;
    _signatureimage = signatureimage;
    _cameraimage = cameraimage;
    _orderDateString = orderDateString;
    _createdFrom = createdFrom;
    _orderDetail = orderDetail;
  }

  Orders.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _brachCode = json['BrachCode'];
    _orderNo = json['OrderNo'];
    _orderDate = json['OrderDate'];
    _customerId = json['CustomerId'];
    _customerName = json['CustomerName'];
    _customerAddress = json['CustomerAddress'];
    _postalCode = json['PostalCode'];
    _taxCode = json['TaxCode'];
    _taxType = json['TaxType'];
    _taxPerc = json['TaxPerc'];
    _currencyCode = json['CurrencyCode'];
    _currencyRate = json['CurrencyRate'];
    _total = json['Total'];
    _billDiscount = json['BillDiscount'];
    _billDiscountPerc = json['BillDiscountPerc'];
    _subTotal = json['SubTotal'];
    _tax = json['Tax'];
    _netTotal = json['NetTotal'];
    _paymentType = json['PaymentType'];
    _paidAmount = json['PaidAmount'];
    _remarks = json['Remarks'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _status = json['Status'];
    _customerShipToId = json['CustomerShipToId'];
    _customerShipToAddress = json['CustomerShipToAddress'];
    _latitude = json['Latitude'];
    _longitude = json['Longitude'];
    _signatureimage = json['Signatureimage'];
    _cameraimage = json['Cameraimage'];
    _orderDateString = json['OrderDateString'];
    _createdFrom = json['CreatedFrom'];
    if (json['OrderDetail'] != null) {
      _orderDetail = [];
      json['OrderDetail'].forEach((v) {
        _orderDetail?.add(OrderDetail.fromJson(v));
      });
    }
  }
  int? _orgId;
  String? _brachCode;
  String? _orderNo;
  String? _orderDate;
  String? _customerId;
  String? _customerName;
  String? _customerAddress;
  String? _postalCode;
  int? _taxCode;
  String? _taxType;
  int? _taxPerc;
  String? _currencyCode;
  int? _currencyRate;
  int? _total;
  int? _billDiscount;
  int? _billDiscountPerc;
  int? _subTotal;
  int? _tax;
  int? _netTotal;
  String? _paymentType;
  int? _paidAmount;
  String? _remarks;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  int? _status;
  int? _customerShipToId;
  String? _customerShipToAddress;
  int? _latitude;
  int? _longitude;
  String? _signatureimage;
  String? _cameraimage;
  String? _orderDateString;
  String? _createdFrom;
  List<OrderDetail>? _orderDetail;
  Orders copyWith({
    int? orgId,
    String? brachCode,
    String? orderNo,
    String? orderDate,
    String? customerId,
    String? customerName,
    String? customerAddress,
    String? postalCode,
    int? taxCode,
    String? taxType,
    int? taxPerc,
    String? currencyCode,
    int? currencyRate,
    int? total,
    int? billDiscount,
    int? billDiscountPerc,
    int? subTotal,
    int? tax,
    int? netTotal,
    String? paymentType,
    int? paidAmount,
    String? remarks,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    int? status,
    int? customerShipToId,
    String? customerShipToAddress,
    int? latitude,
    int? longitude,
    String? signatureimage,
    String? cameraimage,
    String? orderDateString,
    String? createdFrom,
    List<OrderDetail>? orderDetail,
  }) =>
      Orders(
        orgId: orgId ?? _orgId,
        brachCode: brachCode ?? _brachCode,
        orderNo: orderNo ?? _orderNo,
        orderDate: orderDate ?? _orderDate,
        customerId: customerId ?? _customerId,
        customerName: customerName ?? _customerName,
        customerAddress: customerAddress ?? _customerAddress,
        postalCode: postalCode ?? _postalCode,
        taxCode: taxCode ?? _taxCode,
        taxType: taxType ?? _taxType,
        taxPerc: taxPerc ?? _taxPerc,
        currencyCode: currencyCode ?? _currencyCode,
        currencyRate: currencyRate ?? _currencyRate,
        total: total ?? _total,
        billDiscount: billDiscount ?? _billDiscount,
        billDiscountPerc: billDiscountPerc ?? _billDiscountPerc,
        subTotal: subTotal ?? _subTotal,
        tax: tax ?? _tax,
        netTotal: netTotal ?? _netTotal,
        paymentType: paymentType ?? _paymentType,
        paidAmount: paidAmount ?? _paidAmount,
        remarks: remarks ?? _remarks,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        status: status ?? _status,
        customerShipToId: customerShipToId ?? _customerShipToId,
        customerShipToAddress: customerShipToAddress ?? _customerShipToAddress,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        signatureimage: signatureimage ?? _signatureimage,
        cameraimage: cameraimage ?? _cameraimage,
        orderDateString: orderDateString ?? _orderDateString,
        createdFrom: createdFrom ?? _createdFrom,
        orderDetail: orderDetail ?? _orderDetail,
      );
  int? get orgId => _orgId;
  String? get brachCode => _brachCode;
  String? get orderNo => _orderNo;
  String? get orderDate => _orderDate;
  String? get customerId => _customerId;
  String? get customerName => _customerName;
  String? get customerAddress => _customerAddress;
  String? get postalCode => _postalCode;
  int? get taxCode => _taxCode;
  String? get taxType => _taxType;
  int? get taxPerc => _taxPerc;
  String? get currencyCode => _currencyCode;
  int? get currencyRate => _currencyRate;
  int? get total => _total;
  int? get billDiscount => _billDiscount;
  int? get billDiscountPerc => _billDiscountPerc;
  int? get subTotal => _subTotal;
  int? get tax => _tax;
  int? get netTotal => _netTotal;
  String? get paymentType => _paymentType;
  int? get paidAmount => _paidAmount;
  String? get remarks => _remarks;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  int? get status => _status;
  int? get customerShipToId => _customerShipToId;
  String? get customerShipToAddress => _customerShipToAddress;
  int? get latitude => _latitude;
  int? get longitude => _longitude;
  String? get signatureimage => _signatureimage;
  String? get cameraimage => _cameraimage;
  String? get orderDateString => _orderDateString;
  String? get createdFrom => _createdFrom;
  List<OrderDetail>? get orderDetail => _orderDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BrachCode'] = _brachCode;
    map['OrderNo'] = _orderNo;
    map['OrderDate'] = _orderDate;
    map['CustomerId'] = _customerId;
    map['CustomerName'] = _customerName;
    map['CustomerAddress'] = _customerAddress;
    map['PostalCode'] = _postalCode;
    map['TaxCode'] = _taxCode;
    map['TaxType'] = _taxType;
    map['TaxPerc'] = _taxPerc;
    map['CurrencyCode'] = _currencyCode;
    map['CurrencyRate'] = _currencyRate;
    map['Total'] = _total;
    map['BillDiscount'] = _billDiscount;
    map['BillDiscountPerc'] = _billDiscountPerc;
    map['SubTotal'] = _subTotal;
    map['Tax'] = _tax;
    map['NetTotal'] = _netTotal;
    map['PaymentType'] = _paymentType;
    map['PaidAmount'] = _paidAmount;
    map['Remarks'] = _remarks;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['Status'] = _status;
    map['CustomerShipToId'] = _customerShipToId;
    map['CustomerShipToAddress'] = _customerShipToAddress;
    map['Latitude'] = _latitude;
    map['Longitude'] = _longitude;
    map['Signatureimage'] = _signatureimage;
    map['Cameraimage'] = _cameraimage;
    map['OrderDateString'] = _orderDateString;
    map['CreatedFrom'] = _createdFrom;
    if (_orderDetail != null) {
      map['OrderDetail'] = _orderDetail?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// OrgId : 0
/// OrderNo : "string"
/// SlNo : 0
/// ProductCode : "string"
/// ProductName : "string"
/// Qty : 0
/// Price : 0
/// Foc : 0
/// Total : 0
/// ItemDiscount : 0
/// ItemDiscountPerc : 0
/// SubTotal : 0
/// Tax : 0
/// NetTotal : 0
/// TaxCode : 0
/// TaxType : "string"
/// TaxPerc : 0
/// Remarks : "string"
/// CreatedBy : "string"
/// CreatedOn : "2023-07-13T16:49:45.603Z"
/// ChangedBy : "string"
/// ChangedOn : "2023-07-13T16:49:45.603Z"
/// Weight : 0

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));
String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  OrderDetail({
    int? orgId,
    String? orderNo,
    int? slNo,
    String? productCode,
    String? productName,
    int? qty,
    int? price,
    int? foc,
    int? total,
    int? itemDiscount,
    int? itemDiscountPerc,
    int? subTotal,
    int? tax,
    int? netTotal,
    int? taxCode,
    String? taxType,
    int? taxPerc,
    String? remarks,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    int? weight,
  }) {
    _orgId = orgId;
    _orderNo = orderNo;
    _slNo = slNo;
    _productCode = productCode;
    _productName = productName;
    _qty = qty;
    _price = price;
    _foc = foc;
    _total = total;
    _itemDiscount = itemDiscount;
    _itemDiscountPerc = itemDiscountPerc;
    _subTotal = subTotal;
    _tax = tax;
    _netTotal = netTotal;
    _taxCode = taxCode;
    _taxType = taxType;
    _taxPerc = taxPerc;
    _remarks = remarks;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _weight = weight;
  }

  OrderDetail.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _orderNo = json['OrderNo'];
    _slNo = json['SlNo'];
    _productCode = json['ProductCode'];
    _productName = json['ProductName'];
    _qty = json['Qty'];
    _price = json['Price'];
    _foc = json['Foc'];
    _total = json['Total'];
    _itemDiscount = json['ItemDiscount'];
    _itemDiscountPerc = json['ItemDiscountPerc'];
    _subTotal = json['SubTotal'];
    _tax = json['Tax'];
    _netTotal = json['NetTotal'];
    _taxCode = json['TaxCode'];
    _taxType = json['TaxType'];
    _taxPerc = json['TaxPerc'];
    _remarks = json['Remarks'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _weight = json['Weight'];
  }
  int? _orgId;
  String? _orderNo;
  int? _slNo;
  String? _productCode;
  String? _productName;
  int? _qty;
  int? _price;
  int? _foc;
  int? _total;
  int? _itemDiscount;
  int? _itemDiscountPerc;
  int? _subTotal;
  int? _tax;
  int? _netTotal;
  int? _taxCode;
  String? _taxType;
  int? _taxPerc;
  String? _remarks;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  int? _weight;
  OrderDetail copyWith({
    int? orgId,
    String? orderNo,
    int? slNo,
    String? productCode,
    String? productName,
    int? qty,
    int? price,
    int? foc,
    int? total,
    int? itemDiscount,
    int? itemDiscountPerc,
    int? subTotal,
    int? tax,
    int? netTotal,
    int? taxCode,
    String? taxType,
    int? taxPerc,
    String? remarks,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    int? weight,
  }) =>
      OrderDetail(
        orgId: orgId ?? _orgId,
        orderNo: orderNo ?? _orderNo,
        slNo: slNo ?? _slNo,
        productCode: productCode ?? _productCode,
        productName: productName ?? _productName,
        qty: qty ?? _qty,
        price: price ?? _price,
        foc: foc ?? _foc,
        total: total ?? _total,
        itemDiscount: itemDiscount ?? _itemDiscount,
        itemDiscountPerc: itemDiscountPerc ?? _itemDiscountPerc,
        subTotal: subTotal ?? _subTotal,
        tax: tax ?? _tax,
        netTotal: netTotal ?? _netTotal,
        taxCode: taxCode ?? _taxCode,
        taxType: taxType ?? _taxType,
        taxPerc: taxPerc ?? _taxPerc,
        remarks: remarks ?? _remarks,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        weight: weight ?? _weight,
      );
  int? get orgId => _orgId;
  String? get orderNo => _orderNo;
  int? get slNo => _slNo;
  String? get productCode => _productCode;
  String? get productName => _productName;
  int? get qty => _qty;
  int? get price => _price;
  int? get foc => _foc;
  int? get total => _total;
  int? get itemDiscount => _itemDiscount;
  int? get itemDiscountPerc => _itemDiscountPerc;
  int? get subTotal => _subTotal;
  int? get tax => _tax;
  int? get netTotal => _netTotal;
  int? get taxCode => _taxCode;
  String? get taxType => _taxType;
  int? get taxPerc => _taxPerc;
  String? get remarks => _remarks;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  int? get weight => _weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['OrderNo'] = _orderNo;
    map['SlNo'] = _slNo;
    map['ProductCode'] = _productCode;
    map['ProductName'] = _productName;
    map['Qty'] = _qty;
    map['Price'] = _price;
    map['Foc'] = _foc;
    map['Total'] = _total;
    map['ItemDiscount'] = _itemDiscount;
    map['ItemDiscountPerc'] = _itemDiscountPerc;
    map['SubTotal'] = _subTotal;
    map['Tax'] = _tax;
    map['NetTotal'] = _netTotal;
    map['TaxCode'] = _taxCode;
    map['TaxType'] = _taxType;
    map['TaxPerc'] = _taxPerc;
    map['Remarks'] = _remarks;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['Weight'] = _weight;
    return map;
  }
}
