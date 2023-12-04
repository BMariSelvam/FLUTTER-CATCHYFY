import 'dart:convert';

/// OrgId : 1
/// Code : "00001"
/// Name : "CUSTOMER SGD"
/// CustomerGroup : ""
/// Remarks : ""
/// CustomerType : ""
/// UniqueNo : ""
/// Mail : ""
/// AddressLine1 : ""
/// AddressLine2 : ""
/// AddressLine3 : ""
/// CountryId : "0003"
/// PostalCode : ""
/// Mobile : ""
/// Phone : ""
/// Fax : ""
/// CurrencyId : null
/// TaxTypeId : "11"
/// DirectorName : ""
/// DirectorPhone : ""
/// DirectorMobile : ""
/// DirectorMail : ""
/// SalesPerson : ""
/// PaymentTerms : ""
/// Source : ""
/// IsActive : true
/// IsOutStanding : false
/// CreatedBy : "admin"
/// CreatedOn : "2023-07-09T16:34:21.49"
/// ChangedBy : "admin"
/// ChangedOn : "2023-07-09T16:34:21.49"
/// Activity1 : ""
/// Activity2 : ""
/// ContactPerson : null
/// CountryName : "SINGAPORE"
/// PriceSettings : ""
/// CreditLimit : 0
/// OutstandingAmount : null
/// Account : ""
/// IsVisited : 0
/// VisitedNo : 0
/// VisitedDate : null
/// Password : null
/// ContactType : "C"

CustomerCreateModel customerCreateModelFromJson(String str) =>
    CustomerCreateModel.fromJson(json.decode(str));
String customerCreateModelToJson(CustomerCreateModel data) =>
    json.encode(data.toJson());

class CustomerCreateModel {
  CustomerCreateModel({
    int? orgId,
    String? code,
    String? name,
    String? customerGroup,
    String? remarks,
    String? customerType,
    String? uniqueNo,
    String? mail,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? countryId,
    String? postalCode,
    String? mobile,
    String? phone,
    String? fax,
    dynamic currencyId,
    String? taxTypeId,
    String? directorName,
    String? directorPhone,
    String? directorMobile,
    String? directorMail,
    String? salesPerson,
    String? paymentTerms,
    String? source,
    bool? isActive,
    bool? isOutStanding,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    String? activity1,
    String? activity2,
    dynamic contactPerson,
    String? countryName,
    String? priceSettings,
    num? creditLimit,
    dynamic outstandingAmount,
    String? account,
    num? isVisited,
    num? visitedNo,
    dynamic visitedDate,
    dynamic password,
    String? contactType,
  }) {
    _orgId = orgId;
    _code = code;
    _name = name;
    _customerGroup = customerGroup;
    _remarks = remarks;
    _customerType = customerType;
    _uniqueNo = uniqueNo;
    _mail = mail;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressLine3 = addressLine3;
    _countryId = countryId;
    _postalCode = postalCode;
    _mobile = mobile;
    _phone = phone;
    _fax = fax;
    _currencyId = currencyId;
    _taxTypeId = taxTypeId;
    _directorName = directorName;
    _directorPhone = directorPhone;
    _directorMobile = directorMobile;
    _directorMail = directorMail;
    _salesPerson = salesPerson;
    _paymentTerms = paymentTerms;
    _source = source;
    _isActive = isActive;
    _isOutStanding = isOutStanding;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _activity1 = activity1;
    _activity2 = activity2;
    _contactPerson = contactPerson;
    _countryName = countryName;
    _priceSettings = priceSettings;
    _creditLimit = creditLimit;
    _outstandingAmount = outstandingAmount;
    _account = account;
    _isVisited = isVisited;
    _visitedNo = visitedNo;
    _visitedDate = visitedDate;
    _password = password;
    _contactType = contactType;
  }

  CustomerCreateModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _code = json['Code'];
    _name = json['Name'];
    _customerGroup = json['CustomerGroup'];
    _remarks = json['Remarks'];
    _customerType = json['CustomerType'];
    _uniqueNo = json['UniqueNo'];
    _mail = json['Mail'];
    _addressLine1 = json['AddressLine1'];
    _addressLine2 = json['AddressLine2'];
    _addressLine3 = json['AddressLine3'];
    _countryId = json['CountryId'];
    _postalCode = json['PostalCode'];
    _mobile = json['Mobile'];
    _phone = json['Phone'];
    _fax = json['Fax'];
    _currencyId = json['CurrencyId'];
    _taxTypeId = json['TaxTypeId'];
    _directorName = json['DirectorName'];
    _directorPhone = json['DirectorPhone'];
    _directorMobile = json['DirectorMobile'];
    _directorMail = json['DirectorMail'];
    _salesPerson = json['SalesPerson'];
    _paymentTerms = json['PaymentTerms'];
    _source = json['Source'];
    _isActive = json['IsActive'];
    _isOutStanding = json['IsOutStanding'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _activity1 = json['Activity1'];
    _activity2 = json['Activity2'];
    _contactPerson = json['ContactPerson'];
    _countryName = json['CountryName'];
    _priceSettings = json['PriceSettings'];
    _creditLimit = json['CreditLimit'];
    _outstandingAmount = json['OutstandingAmount'];
    _account = json['Account'];
    _isVisited = json['IsVisited'];
    _visitedNo = json['VisitedNo'];
    _visitedDate = json['VisitedDate'];
    _password = json['Password'];
    _contactType = json['ContactType'];
  }
  int? _orgId;
  String? _code;
  String? _name;
  String? _customerGroup;
  String? _remarks;
  String? _customerType;
  String? _uniqueNo;
  String? _mail;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _countryId;
  String? _postalCode;
  String? _mobile;
  String? _phone;
  String? _fax;
  dynamic _currencyId;
  String? _taxTypeId;
  String? _directorName;
  String? _directorPhone;
  String? _directorMobile;
  String? _directorMail;
  String? _salesPerson;
  String? _paymentTerms;
  String? _source;
  bool? _isActive;
  bool? _isOutStanding;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  String? _activity1;
  String? _activity2;
  dynamic _contactPerson;
  String? _countryName;
  String? _priceSettings;
  num? _creditLimit;
  dynamic _outstandingAmount;
  String? _account;
  num? _isVisited;
  num? _visitedNo;
  dynamic _visitedDate;
  dynamic _password;
  String? _contactType;
  CustomerCreateModel copyWith({
    int? orgId,
    String? code,
    String? name,
    String? customerGroup,
    String? remarks,
    String? customerType,
    String? uniqueNo,
    String? mail,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? countryId,
    String? postalCode,
    String? mobile,
    String? phone,
    String? fax,
    dynamic currencyId,
    String? taxTypeId,
    String? directorName,
    String? directorPhone,
    String? directorMobile,
    String? directorMail,
    String? salesPerson,
    String? paymentTerms,
    String? source,
    bool? isActive,
    bool? isOutStanding,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    String? activity1,
    String? activity2,
    dynamic contactPerson,
    String? countryName,
    String? priceSettings,
    num? creditLimit,
    dynamic outstandingAmount,
    String? account,
    num? isVisited,
    num? visitedNo,
    dynamic visitedDate,
    dynamic password,
    String? contactType,
  }) =>
      CustomerCreateModel(
        orgId: orgId ?? _orgId,
        code: code ?? _code,
        name: name ?? _name,
        customerGroup: customerGroup ?? _customerGroup,
        remarks: remarks ?? _remarks,
        customerType: customerType ?? _customerType,
        uniqueNo: uniqueNo ?? _uniqueNo,
        mail: mail ?? _mail,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        addressLine3: addressLine3 ?? _addressLine3,
        countryId: countryId ?? _countryId,
        postalCode: postalCode ?? _postalCode,
        mobile: mobile ?? _mobile,
        phone: phone ?? _phone,
        fax: fax ?? _fax,
        currencyId: currencyId ?? _currencyId,
        taxTypeId: taxTypeId ?? _taxTypeId,
        directorName: directorName ?? _directorName,
        directorPhone: directorPhone ?? _directorPhone,
        directorMobile: directorMobile ?? _directorMobile,
        directorMail: directorMail ?? _directorMail,
        salesPerson: salesPerson ?? _salesPerson,
        paymentTerms: paymentTerms ?? _paymentTerms,
        source: source ?? _source,
        isActive: isActive ?? _isActive,
        isOutStanding: isOutStanding ?? _isOutStanding,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        activity1: activity1 ?? _activity1,
        activity2: activity2 ?? _activity2,
        contactPerson: contactPerson ?? _contactPerson,
        countryName: countryName ?? _countryName,
        priceSettings: priceSettings ?? _priceSettings,
        creditLimit: creditLimit ?? _creditLimit,
        outstandingAmount: outstandingAmount ?? _outstandingAmount,
        account: account ?? _account,
        isVisited: isVisited ?? _isVisited,
        visitedNo: visitedNo ?? _visitedNo,
        visitedDate: visitedDate ?? _visitedDate,
        password: password ?? _password,
        contactType: contactType ?? _contactType,
      );
  int? get orgId => _orgId;
  String? get code => _code;
  String? get name => _name;
  String? get customerGroup => _customerGroup;
  String? get remarks => _remarks;
  String? get customerType => _customerType;
  String? get uniqueNo => _uniqueNo;
  String? get mail => _mail;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get addressLine3 => _addressLine3;
  String? get countryId => _countryId;
  String? get postalCode => _postalCode;
  String? get mobile => _mobile;
  String? get phone => _phone;
  String? get fax => _fax;
  dynamic get currencyId => _currencyId;
  String? get taxTypeId => _taxTypeId;
  String? get directorName => _directorName;
  String? get directorPhone => _directorPhone;
  String? get directorMobile => _directorMobile;
  String? get directorMail => _directorMail;
  String? get salesPerson => _salesPerson;
  String? get paymentTerms => _paymentTerms;
  String? get source => _source;
  bool? get isActive => _isActive;
  bool? get isOutStanding => _isOutStanding;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  String? get activity1 => _activity1;
  String? get activity2 => _activity2;
  dynamic get contactPerson => _contactPerson;
  String? get countryName => _countryName;
  String? get priceSettings => _priceSettings;
  num? get creditLimit => _creditLimit;
  dynamic get outstandingAmount => _outstandingAmount;
  String? get account => _account;
  num? get isVisited => _isVisited;
  num? get visitedNo => _visitedNo;
  dynamic get visitedDate => _visitedDate;
  dynamic get password => _password;
  String? get contactType => _contactType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['Code'] = _code;
    map['Name'] = _name;
    map['CustomerGroup'] = _customerGroup;
    map['Remarks'] = _remarks;
    map['CustomerType'] = _customerType;
    map['UniqueNo'] = _uniqueNo;
    map['Mail'] = _mail;
    map['AddressLine1'] = _addressLine1;
    map['AddressLine2'] = _addressLine2;
    map['AddressLine3'] = _addressLine3;
    map['CountryId'] = _countryId;
    map['PostalCode'] = _postalCode;
    map['Mobile'] = _mobile;
    map['Phone'] = _phone;
    map['Fax'] = _fax;
    map['CurrencyId'] = _currencyId;
    map['TaxTypeId'] = _taxTypeId;
    map['DirectorName'] = _directorName;
    map['DirectorPhone'] = _directorPhone;
    map['DirectorMobile'] = _directorMobile;
    map['DirectorMail'] = _directorMail;
    map['SalesPerson'] = _salesPerson;
    map['PaymentTerms'] = _paymentTerms;
    map['Source'] = _source;
    map['IsActive'] = _isActive;
    map['IsOutStanding'] = _isOutStanding;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['Activity1'] = _activity1;
    map['Activity2'] = _activity2;
    map['ContactPerson'] = _contactPerson;
    map['CountryName'] = _countryName;
    map['PriceSettings'] = _priceSettings;
    map['CreditLimit'] = _creditLimit;
    map['OutstandingAmount'] = _outstandingAmount;
    map['Account'] = _account;
    map['IsVisited'] = _isVisited;
    map['VisitedNo'] = _visitedNo;
    map['VisitedDate'] = _visitedDate;
    map['Password'] = _password;
    map['ContactType'] = _contactType;
    return map;
  }
}
