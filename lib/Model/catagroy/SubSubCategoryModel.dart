class SubSubCategoryModel {
  SubSubCategoryModel({
    this.orgId,
    this.code,
    this.name,
    this.categoryCode,
    this.subCategoryCode,
    this.groupLevel,
    this.displayOrder,
    this.isPOS,
    this.isB2B,
    this.isB2C,
    this.isERP,
    this.isActive,
    this.subL2IconImageFileName,
    this.subL2IconImageFilePath,
    this.subCategoryL2ImageFileName,
    this.subCategoryL2ImageFilePath,
    this.subCatgeoryL2shorturl,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.subCategoryL2ImgBase64String,
    this.subCategoryL2Image,
    this.subL2IconImgBase64String,
    this.subL2IconImage,
    this.categoryName,
    this.createdOnString,
    this.changedOnString,
    this.subCategoryName,
  });

  SubSubCategoryModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    code = json['Code'];
    name = json['Name'];
    categoryCode = json['CategoryCode'];
    subCategoryCode = json['SubCategoryCode'];
    groupLevel = json['GroupLevel'];
    displayOrder = json['DisplayOrder'];
    isPOS = json['IsPOS'];
    isB2B = json['IsB2B'];
    isB2C = json['IsB2C'];
    isERP = json['IsERP'];
    isActive = json['IsActive'];
    subL2IconImageFileName = json['SubL2IconImageFileName'];
    subL2IconImageFilePath = json['SubL2IconImageFilePath'];
    subCategoryL2ImageFileName = json['SubCategoryL2ImageFileName'];
    subCategoryL2ImageFilePath = json['SubCategoryL2ImageFilePath'];
    subCatgeoryL2shorturl = json['SubCatgeoryL2shorturl'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    subCategoryL2ImgBase64String = json['SubCategoryL2Img_Base64String'];
    subCategoryL2Image = json['SubCategoryL2Image'];
    subL2IconImgBase64String = json['SubL2IconImg_Base64String'];
    subL2IconImage = json['SubL2IconImage'];
    categoryName = json['CategoryName'];
    createdOnString = json['CreatedOnString'];
    changedOnString = json['ChangedOnString'];
    subCategoryName = json['SubCategoryName'];
  }
  int? orgId;
  String? code;
  String? name;
  String? categoryCode;
  String? subCategoryCode;
  int? groupLevel;
  int? displayOrder;
  bool? isPOS;
  bool? isB2B;
  bool? isB2C;
  bool? isERP;
  bool? isActive;
  String? subL2IconImageFileName;
  String? subL2IconImageFilePath;
  String? subCategoryL2ImageFileName;
  String? subCategoryL2ImageFilePath;
  String? subCatgeoryL2shorturl;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  String? subCategoryL2ImgBase64String;
  String? subCategoryL2Image;
  String? subL2IconImgBase64String;
  String? subL2IconImage;
  String? categoryName;
  String? createdOnString;
  String? changedOnString;
  String? subCategoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['Code'] = code;
    map['Name'] = name;
    map['CategoryCode'] = categoryCode;
    map['SubCategoryCode'] = subCategoryCode;
    map['GroupLevel'] = groupLevel;
    map['DisplayOrder'] = displayOrder;
    map['IsPOS'] = isPOS;
    map['IsB2B'] = isB2B;
    map['IsB2C'] = isB2C;
    map['IsERP'] = isERP;
    map['IsActive'] = isActive;
    map['SubL2IconImageFileName'] = subL2IconImageFileName;
    map['SubL2IconImageFilePath'] = subL2IconImageFilePath;
    map['SubCategoryL2ImageFileName'] = subCategoryL2ImageFileName;
    map['SubCategoryL2ImageFilePath'] = subCategoryL2ImageFilePath;
    map['SubCatgeoryL2shorturl'] = subCatgeoryL2shorturl;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['SubCategoryL2Img_Base64String'] = subCategoryL2ImgBase64String;
    map['SubCategoryL2Image'] = subCategoryL2Image;
    map['SubL2IconImg_Base64String'] = subL2IconImgBase64String;
    map['SubL2IconImage'] = subL2IconImage;
    map['CategoryName'] = categoryName;
    map['CreatedOnString'] = createdOnString;
    map['ChangedOnString'] = changedOnString;
    map['SubCategoryName'] = subCategoryName;
    return map;
  }
}
