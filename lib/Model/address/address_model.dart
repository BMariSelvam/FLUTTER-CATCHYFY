class AddressModel {
  int? orgId;
  int? deliveryId;
  String? customerId;
  String? name;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? countryId;
  String? postalCode;
  String? mobile;
  String? phone;
  String? fax;
  bool? isDefault;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;

  AddressModel(
      {this.orgId,
      this.deliveryId,
      this.customerId,
      this.name,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.countryId,
      this.postalCode,
      this.mobile,
      this.phone,
      this.fax,
      this.isDefault,
      this.isActive,
      this.createdBy,
      this.createdOn,
      this.changedBy,
      this.changedOn});

  AddressModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    deliveryId = json['DeliveryId'];
    customerId = json['CustomerId'];
    name = json['Name'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    countryId = json['CountryId'];
    postalCode = json['PostalCode'];
    mobile = json['Mobile'];
    phone = json['Phone'];
    fax = json['Fax'];
    isDefault = json['IsDefault'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['DeliveryId'] = this.deliveryId;
    data['CustomerId'] = this.customerId;
    data['Name'] = this.name;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['CountryId'] = this.countryId;
    data['PostalCode'] = this.postalCode;
    data['Mobile'] = this.mobile;
    data['Phone'] = this.phone;
    data['Fax'] = this.fax;
    data['IsDefault'] = this.isDefault;
    data['IsActive'] = this.isActive;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['ChangedBy'] = this.changedBy;
    data['ChangedOn'] = this.changedOn;
    return data;
  }
}
