import 'dart:convert';

import 'dart:convert';

B2cCustomerRegModel b2cCustomerRegModelFromJson(String str) =>
    B2cCustomerRegModel.fromJson(json.decode(str));
String b2cCustomerRegModelToJson(B2cCustomerRegModel data) =>
    json.encode(data.toJson());

class B2cCustomerRegModel {
  B2cCustomerRegModel({
    this.orgId,
    this.branchCode,
    this.b2CCustomerId,
    this.b2CCustomerName,
    this.emailId,
    this.password,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.mobileNo,
    this.countryId,
    this.postalCode,
    this.isActive,
    this.isApproved,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.orders,
    this.address,
  });

  int? orgId;
  String? branchCode;
  String? b2CCustomerId;
  String? b2CCustomerName;
  String? emailId;
  String? password;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? mobileNo;
  String? countryId;
  String? postalCode;
  bool? isActive;
  bool? isApproved;
  String? createdBy;
  DateTime? createdOn;
  String? changedBy;
  DateTime? changedOn;
  List<Orders>? orders;
  List<Address>? address;

  factory B2cCustomerRegModel.fromJson(Map<String, dynamic> json) =>
      B2cCustomerRegModel(
        orgId: json["OrgId"],
        branchCode: json["BranchCode"],
        b2CCustomerId: json["B2CCustomerId"],
        b2CCustomerName: json["B2CCustomerName"],
        emailId: json["EmailId"],
        password: json["Password"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        addressLine3: json["AddressLine3"],
        mobileNo: json["MobileNo"],
        countryId: json["CountryId"],
        postalCode: json["PostalCode"],
        isActive: json["IsActive"],
        isApproved: json["IsApproved"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        changedBy: json["ChangedBy"],
        changedOn: DateTime.parse(json["ChangedOn"]),
        orders: json["Orders"] != null
            ? List<Orders>.from(json["Orders"].map((x) => Orders.fromJson(x)))
            : null,
        address: json["Address"] != null
            ? List<Address>.from(
                json["Address"].map((x) => Address.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "OrgId": orgId,
        "BranchCode": branchCode,
        "B2CCustomerId": b2CCustomerId,
        "B2CCustomerName": b2CCustomerName,
        "EmailId": emailId,
        "Password": password,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "AddressLine3": addressLine3,
        "MobileNo": mobileNo,
        "CountryId": countryId,
        "PostalCode": postalCode,
        "IsActive": isActive,
        "IsApproved": isApproved,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn?.toIso8601String(),
        "ChangedBy": changedBy,
        "ChangedOn": changedOn?.toIso8601String(),
        "Orders": orders != null
            ? List<dynamic>.from(orders!.map((x) => x.toJson()))
            : null,
        "Address": address != null
            ? List<dynamic>.from(address!.map((x) => x.toJson()))
            : null,
      };
}

class Address {
  Address({
    this.orgId,
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
    this.changedOn,
  });

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
  DateTime? createdOn;
  String? changedBy;
  DateTime? changedOn;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        orgId: json["OrgId"],
        deliveryId: json["DeliveryId"],
        customerId: json["CustomerId"],
        name: json["Name"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        addressLine3: json["AddressLine3"],
        countryId: json["CountryId"],
        postalCode: json["PostalCode"],
        mobile: json["Mobile"],
        phone: json["Phone"],
        fax: json["Fax"],
        isDefault: json["IsDefault"],
        isActive: json["IsActive"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        changedBy: json["ChangedBy"],
        changedOn: DateTime.parse(json["ChangedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "OrgId": orgId,
        "DeliveryId": deliveryId,
        "CustomerId": customerId,
        "Name": name,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "AddressLine3": addressLine3,
        "CountryId": countryId,
        "PostalCode": postalCode,
        "Mobile": mobile,
        "Phone": phone,
        "Fax": fax,
        "IsDefault": isDefault,
        "IsActive": isActive,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn?.toIso8601String(),
        "ChangedBy": changedBy,
        "ChangedOn": changedOn?.toIso8601String(),
      };
}

class Orders {
  Orders({
    this.orderId,
    this.orderDate,
    this.customerId,
    this.totalAmount,
    this.createdOn,
  });

  int? orderId;
  DateTime? orderDate;
  String? customerId;
  double? totalAmount;
  DateTime? createdOn;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["OrderId"],
        orderDate: DateTime.parse(json["OrderDate"]),
        customerId: json["CustomerId"],
        totalAmount: json["TotalAmount"].toDouble(),
        createdOn: DateTime.parse(json["CreatedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "OrderDate": orderDate?.toIso8601String(),
        "CustomerId": customerId,
        "TotalAmount": totalAmount,
        "CreatedOn": createdOn?.toIso8601String(),
      };
}
