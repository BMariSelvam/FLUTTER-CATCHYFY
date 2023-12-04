class CreateAddress {
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

  CreateAddress(
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

  CreateAddress.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = orgId;
    data['DeliveryId'] = deliveryId;
    data['CustomerId'] = customerId;
    data['Name'] = name;
    data['AddressLine1'] = addressLine1;
    data['AddressLine2'] = addressLine2;
    data['AddressLine3'] = addressLine3;
    data['CountryId'] = countryId;
    data['PostalCode'] = postalCode;
    data['Mobile'] = mobile;
    data['Phone'] = phone;
    data['Fax'] = fax;
    data['IsDefault'] = isDefault;
    data['IsActive'] = isActive;
    data['CreatedBy'] = createdBy;
    data['CreatedOn'] = createdOn;
    data['ChangedBy'] = changedBy;
    data['ChangedOn'] = changedOn;
    return data;
  }
}
