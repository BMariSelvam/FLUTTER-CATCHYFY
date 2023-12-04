class OrderListModel {
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
  dynamic orderDetail;

  OrderListModel(
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

  OrderListModel.fromJson(Map<String, dynamic> json) {
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
    orderDetail = json['OrderDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = orgId;
    data['BrachCode'] = brachCode;
    data['OrderNo'] = orderNo;
    data['OrderDate'] = orderDate;
    data['CustomerId'] = customerId;
    data['CustomerName'] = customerName;
    data['CustomerAddress'] = customerAddress;
    data['PostalCode'] = postalCode;
    data['TaxCode'] = taxCode;
    data['TaxType'] = taxType;
    data['TaxPerc'] = taxPerc;
    data['CurrencyCode'] = currencyCode;
    data['CurrencyRate'] = currencyRate;
    data['Total'] = total;
    data['BillDiscount'] = billDiscount;
    data['BillDiscountPerc'] = billDiscountPerc;
    data['SubTotal'] = subTotal;
    data['Tax'] = tax;
    data['NetTotal'] = netTotal;
    data['PaymentType'] = paymentType;
    data['PaidAmount'] = paidAmount;
    data['Remarks'] = remarks;
    data['IsActive'] = isActive;
    data['CreatedBy'] = createdBy;
    data['CreatedOn'] = createdOn;
    data['ChangedBy'] = changedBy;
    data['ChangedOn'] = changedOn;
    data['Status'] = status;
    data['CustomerShipToId'] = customerShipToId;
    data['CustomerShipToAddress'] = customerShipToAddress;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Signatureimage'] = signatureimage;
    data['Cameraimage'] = cameraimage;
    data['OrderDateString'] = orderDateString;
    data['CreatedFrom'] = createdFrom;
    data['CustomerEmail'] = customerEmail;
    data['OrderDetail'] = orderDetail;
    return data;
  }
}
