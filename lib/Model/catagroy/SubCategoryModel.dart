import 'dart:convert';


SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));
String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    int? orgId,
    String? code,
    String? name,
    String? categoryName,
    String? chineseDescription,
    String? categoryCode,
    num? displayOrder,
    bool? isPOS,
    bool? isB2B,
    bool? isB2C,
    bool? isERP,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    String? createdOnString,
    String? changedOnString,

    String? iconImageFileName,
    String? iconImageFilePath,
    String? iconImg_Base64String,
    String? iconImage,
    String? subCategoryImageFileName,
    String? subCategoryImageFilePath,
    String? subCategoryImg_Base64String,
    String? subCategoryImage,
    String? subcatgeoryshorturl,

    // "IconImageFileName": "download - 2023-10-07T145208.883.jpg",
    // "IconImageFilePath": "https://fervent-wilson.154-26-130-251.plesk.page/CATCHIFIVE//SUBCATEGORY//f6452baa-1dcf-4de8-9ad6-75d9e0e39aee_download - 2023-10-07T145208.883.jpg",
    // "IconImg_Base64String": null,
    // "IconImage": null,
    // "SubCategoryImageFileName": "download (52).jpeg",
    // "SubCategoryImageFilePath": "https://fervent-wilson.154-26-130-251.plesk.page/CATCHIFIVE//SUBCATEGORY//46919923-1353-46df-a5bc-98b42a10d788_download (52).jpeg",
    // "SubCategoryImg_Base64String": null,
    // "SubCategoryImage": null,
    // "Subcatgeoryshorturl": "CAKES"









  }) {
    _orgId = orgId;
    _code = code;
    _name = name;
    _categoryName = categoryName;
    _chineseDescription = chineseDescription;
    _categoryCode = categoryCode;
    _displayOrder = displayOrder;
    _isPOS = isPOS;
    _isB2B = isB2B;
    _isB2C = isB2C;
    _isERP = isERP;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _createdOnString = createdOnString;
    _changedOnString = changedOnString;




    _iconImageFileName = iconImageFileName;
    _iconImageFilePath = iconImageFilePath;
    _iconImg_Base64String = iconImg_Base64String;
    _iconImage = iconImage;
    _subCategoryImageFileName = subCategoryImageFileName;
    _subCategoryImageFilePath = subCategoryImageFilePath;
    _subCategoryImg_Base64String = subCategoryImg_Base64String;
    _subCategoryImage = subCategoryImage;
    _subcatgeoryshorturl = subcatgeoryshorturl;
  }

  SubCategoryModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _code = json['Code'];
    _name = json['Name'];
    _categoryName = json['CategoryName'];
    _chineseDescription = json['ChineseDescription'];
    _categoryCode = json['CategoryCode'];
    _displayOrder = json['DisplayOrder'];
    _isPOS = json['IsPOS'];
    _isB2B = json['IsB2B'];
    _isB2C = json['IsB2C'];
    _isERP = json['IsERP'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _createdOnString = json['CreatedOnString'];
    _changedOnString = json['ChangedOnString'];
    _iconImageFileName = json['IconImageFileName'];
    _iconImageFilePath = json['IconImageFilePath'];
    _iconImg_Base64String = json['IconImg_Base64String'];
    _iconImage = json['IconImage'];
    _subCategoryImageFileName = json['SubCategoryImageFileName'];
    _subCategoryImageFilePath = json['SubCategoryImageFilePath'];
    _subCategoryImg_Base64String = json['SubCategoryImg_Base64String'];
    _subCategoryImage = json['SubCategoryImage'];
    _subcatgeoryshorturl = json['Subcatgeoryshorturl'];

  }
  int? _orgId;
  String? _code;
  String? _name;
  String? _categoryName;
  String? _chineseDescription;
  String? _categoryCode;
  num? _displayOrder;
  bool? _isPOS;
  bool? _isB2B;
  bool? _isB2C;
  bool? _isERP;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  String? _createdOnString;
  String? _changedOnString;
  String? _iconImageFileName;
      String? _iconImageFilePath;
  String? _iconImg_Base64String;
      String? _iconImage;
  String? _subCategoryImageFileName;
      String? _subCategoryImageFilePath;
  String? _subCategoryImg_Base64String;
      String? _subCategoryImage;
  String? _subcatgeoryshorturl;

      SubCategoryModel copyWith({
    int? orgId,
    String? code,
    String? name,
    String? categoryName,
    String? chineseDescription,
    String? categoryCode,
    num? displayOrder,
    bool? isPOS,
    bool? isB2B,
    bool? isB2C,
    bool? isERP,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    String? createdOnString,
    String? changedOnString,
    String? iconImageFileName,
    String? iconImageFilePath,
    String? iconImg_Base64String,
    String? iconImage,
    String? subCategoryImageFileName,
    String? subCategoryImageFilePath,
    String? subCategoryImg_Base64String,
    String? subCategoryImage,
    String? subcatgeoryshorturl,
  }) =>
      SubCategoryModel(
        orgId: orgId ?? _orgId,
        code: code ?? _code,
        name: name ?? _name,
        categoryName: categoryName ?? _categoryName,
        chineseDescription: chineseDescription ?? _chineseDescription,
        categoryCode: categoryCode ?? _categoryCode,
        displayOrder: displayOrder ?? _displayOrder,
        isPOS: isPOS ?? _isPOS,
        isB2B: isB2B ?? _isB2B,
        isB2C: isB2C ?? _isB2C,
        isERP: isERP ?? _isERP,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        createdOnString: createdOnString ?? _createdOnString,
        changedOnString: changedOnString ?? _changedOnString,

        iconImageFileName: iconImageFileName ?? _iconImageFileName,
        iconImageFilePath: iconImageFilePath ?? _iconImageFilePath,
        iconImg_Base64String: iconImg_Base64String ?? _iconImg_Base64String,
        iconImage: iconImage ?? _iconImage,
        subCategoryImageFileName: subCategoryImageFileName ?? _subCategoryImageFileName,
        subCategoryImageFilePath: subCategoryImageFilePath ?? _subCategoryImageFilePath,
        subCategoryImg_Base64String: subCategoryImg_Base64String ?? _subCategoryImg_Base64String,
        subCategoryImage: subCategoryImage ?? _subCategoryImage,
        subcatgeoryshorturl: subcatgeoryshorturl ?? _subcatgeoryshorturl,
      );
  int? get orgId => _orgId;
  String? get code => _code;
  String? get name => _name;
  String? get categoryName => _categoryName;
  String? get chineseDescription => _chineseDescription;
  String? get categoryCode => _categoryCode;
  num? get displayOrder => _displayOrder;
  bool? get isPOS => _isPOS;
  bool? get isB2B => _isB2B;
  bool? get isB2C => _isB2C;
  bool? get isERP => _isERP;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  String? get createdOnString => _createdOnString;
  String? get changedOnString => _changedOnString;
  String? get iconImageFileName => _iconImageFileName;
  String? get iconImageFilePath => _iconImageFilePath;
  String? get iconImg_Base64String => _iconImg_Base64String;
  String? get iconImage => _iconImage;
  String? get subCategoryImageFileName => _subCategoryImageFileName;
  String? get subCategoryImageFilePath => _subCategoryImageFilePath;
  String? get subCategoryImg_Base64String => _subCategoryImg_Base64String;
  String? get subCategoryImage => _subCategoryImage;
  String? get subcatgeoryshorturl => _subcatgeoryshorturl;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['Code'] = _code;
    map['Name'] = _name;
    map['CategoryName'] = _categoryName;
    map['ChineseDescription'] = _chineseDescription;
    map['CategoryCode'] = _categoryCode;
    map['DisplayOrder'] = _displayOrder;
    map['IsPOS'] = _isPOS;
    map['IsB2B'] = _isB2B;
    map['IsB2C'] = _isB2C;
    map['IsERP'] = _isERP;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['CreatedOnString'] = _createdOnString;
    map['ChangedOnString'] = _changedOnString;
    map['ChangedOnString'] = _iconImageFileName;
    map['ChangedOnString'] = _iconImageFilePath;
    map['ChangedOnString'] = _iconImg_Base64String;
    map['ChangedOnString'] = _iconImage;
    map['ChangedOnString'] = _subCategoryImageFileName;
    map['ChangedOnString'] = _subCategoryImageFilePath;
    map['ChangedOnString'] = _subCategoryImg_Base64String;
    map['ChangedOnString'] = _subCategoryImage;
    map['ChangedOnString'] = _subcatgeoryshorturl;
    map['IconImageFileName'] = _iconImageFileName;
    map['IconImageFilePath'] = _iconImageFilePath;
    map['IconImg_Base64String'] = _iconImg_Base64String;
    map['IconImage'] = _iconImage;
    map['SubCategoryImageFileName'] = _subCategoryImageFileName;
    map['SubCategoryImageFilePath'] = _subCategoryImageFilePath;
    map['SubCategoryImg_Base64String'] = _subCategoryImg_Base64String;
    map['SubCategoryImage'] = _subCategoryImage;
    map['Subcatgeoryshorturl'] = _subcatgeoryshorturl;






    return map;
  }
}

