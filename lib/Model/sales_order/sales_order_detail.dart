class SalesOrderDetail {
  int? orgId;
  String? orderNo;
  int? slNo;
  String? productCode;
  String? productName;
  int? qty;
  int? price;
  int? foc;
  int? total;
  int? itemDiscount;
  int? itemDiscountPerc;
  int? subTotal;
  int? tax;
  int? netTotal;
  int? taxCode;
  String? taxType;
  int? taxPerc;
  String? remarks;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  int? weight;

  SalesOrderDetail(
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

  SalesOrderDetail.fromJson(Map<String, dynamic> json) {
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
