class GetFavProductListModel {
  GetFavProductListModel({
      this.orgId, 
      this.customerId, 
      this.productCode, 
      this.productName, 
      this.isActive, 
      this.createdBy, 
      this.createdOn,});

  GetFavProductListModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    customerId = json['CustomerId'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
  }
  int? orgId;
  String? customerId;
  String? productCode;
  String? productName;
  bool? isActive;
  String? createdBy;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['CustomerId'] = customerId;
    map['ProductCode'] = productCode;
    map['ProductName'] = productName;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    return map;
  }

}