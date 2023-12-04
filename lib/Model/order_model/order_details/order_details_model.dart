class OrderDetailsModel {
  int? orgId;
  String? brachCode;
  String? orderNo;
  String? orderDate;
  String? customerId;
  String? customerName;
  String? customerAddress;
  String? postalCode;
  int? taxCode;
  String? taxType;
  double? taxPerc;
  String? currencyCode;
  double? currencyRate;
  double? total;
  double? billDiscount;
  double? billDiscountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  String? paymentType;
  double? paidAmount;
  String? remarks;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  int? status;
  int? customerShipToId;
  String? customerShipToAddress;
  double? latitude;
  double? longitude;
  String? signatureimage;
  String? cameraimage;
  String? orderDateString;
  String? createdFrom;
  String? customerEmail;
  List<OrderDetailsList>? orderDetail;

  OrderDetailsModel(
      {this.orgId,
      this.brachCode,
      this.orderNo,
      this.orderDate,
      this.customerId,
      this.customerName,
      this.customerAddress,
      this.postalCode,
      this.taxCode,
      this.taxType,
      this.taxPerc,
      this.currencyCode,
      this.currencyRate,
      this.total,
      this.billDiscount,
      this.billDiscountPerc,
      this.subTotal,
      this.tax,
      this.netTotal,
      this.paymentType,
      this.paidAmount,
      this.remarks,
      this.isActive,
      this.createdBy,
      this.createdOn,
      this.changedBy,
      this.changedOn,
      this.status,
      this.customerShipToId,
      this.customerShipToAddress,
      this.latitude,
      this.longitude,
      this.signatureimage,
      this.cameraimage,
      this.orderDateString,
      this.createdFrom,
      this.customerEmail,
      this.orderDetail});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    brachCode = json['BrachCode'];
    orderNo = json['OrderNo'];
    orderDate = json['OrderDate'];
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
    postalCode = json['PostalCode'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    currencyCode = json['CurrencyCode'];
    currencyRate = json['CurrencyRate'];
    total = json['Total'];
    billDiscount = json['BillDiscount'];
    billDiscountPerc = json['BillDiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    paymentType = json['PaymentType'];
    paidAmount = json['PaidAmount'];
    remarks = json['Remarks'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    status = json['Status'];
    customerShipToId = json['CustomerShipToId'];
    customerShipToAddress = json['CustomerShipToAddress'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    signatureimage = json['Signatureimage'];
    cameraimage = json['Cameraimage'];
    orderDateString = json['OrderDateString'];
    createdFrom = json['CreatedFrom'];
    customerEmail = json['CustomerEmail'];
    if (json['OrderDetail'] != null) {
      orderDetail = <OrderDetailsList>[];
      json['OrderDetail'].forEach((v) {
        orderDetail!.add(new OrderDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['BrachCode'] = this.brachCode;
    data['OrderNo'] = this.orderNo;
    data['OrderDate'] = this.orderDate;
    data['CustomerId'] = this.customerId;
    data['CustomerName'] = this.customerName;
    data['CustomerAddress'] = this.customerAddress;
    data['PostalCode'] = this.postalCode;
    data['TaxCode'] = this.taxCode;
    data['TaxType'] = this.taxType;
    data['TaxPerc'] = this.taxPerc;
    data['CurrencyCode'] = this.currencyCode;
    data['CurrencyRate'] = this.currencyRate;
    data['Total'] = this.total;
    data['BillDiscount'] = this.billDiscount;
    data['BillDiscountPerc'] = this.billDiscountPerc;
    data['SubTotal'] = this.subTotal;
    data['Tax'] = this.tax;
    data['NetTotal'] = this.netTotal;
    data['PaymentType'] = this.paymentType;
    data['PaidAmount'] = this.paidAmount;
    data['Remarks'] = this.remarks;
    data['IsActive'] = this.isActive;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['ChangedBy'] = this.changedBy;
    data['ChangedOn'] = this.changedOn;
    data['Status'] = this.status;
    data['CustomerShipToId'] = this.customerShipToId;
    data['CustomerShipToAddress'] = this.customerShipToAddress;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Signatureimage'] = this.signatureimage;
    data['Cameraimage'] = this.cameraimage;
    data['OrderDateString'] = this.orderDateString;
    data['CreatedFrom'] = this.createdFrom;
    data['CustomerEmail'] = this.customerEmail;
    if (this.orderDetail != null) {
      data['OrderDetail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetailsList {
  int? orgId;
  String? orderNo;
  int? slNo;
  String? productCode;
  String? productName;
  int? qty;
  double? price;
  int? foc;
  double? total;
  double? itemDiscount;
  double? itemDiscountPerc;
  double? subTotal;
  double? tax;
  double? netTotal;
  int? taxCode;
  String? taxType;
  double? taxPerc;
  String? remarks;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? weight;

  OrderDetailsList(
      {this.orgId,
      this.orderNo,
      this.slNo,
      this.productCode,
      this.productName,
      this.qty,
      this.price,
      this.foc,
      this.total,
      this.itemDiscount,
      this.itemDiscountPerc,
      this.subTotal,
      this.tax,
      this.netTotal,
      this.taxCode,
      this.taxType,
      this.taxPerc,
      this.remarks,
      this.createdBy,
      this.createdOn,
      this.changedBy,
      this.changedOn,
      this.weight});

  OrderDetailsList.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    orderNo = json['OrderNo'];
    slNo = json['SlNo'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    qty = json['Qty'];
    price = json['Price'];
    foc = json['Foc'];
    total = json['Total'];
    itemDiscount = json['ItemDiscount'];
    itemDiscountPerc = json['ItemDiscountPerc'];
    subTotal = json['SubTotal'];
    tax = json['Tax'];
    netTotal = json['NetTotal'];
    taxCode = json['TaxCode'];
    taxType = json['TaxType'];
    taxPerc = json['TaxPerc'];
    remarks = json['Remarks'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    weight = json['Weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['OrderNo'] = this.orderNo;
    data['SlNo'] = this.slNo;
    data['ProductCode'] = this.productCode;
    data['ProductName'] = this.productName;
    data['Qty'] = this.qty;
    data['Price'] = this.price;
    data['Foc'] = this.foc;
    data['Total'] = this.total;
    data['ItemDiscount'] = this.itemDiscount;
    data['ItemDiscountPerc'] = this.itemDiscountPerc;
    data['SubTotal'] = this.subTotal;
    data['Tax'] = this.tax;
    data['NetTotal'] = this.netTotal;
    data['TaxCode'] = this.taxCode;
    data['TaxType'] = this.taxType;
    data['TaxPerc'] = this.taxPerc;
    data['Remarks'] = this.remarks;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['ChangedBy'] = this.changedBy;
    data['ChangedOn'] = this.changedOn;
    data['Weight'] = this.weight;
    return data;
  }
}
