import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));
String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    int? orgId,
    String? branchCode,
    String? bannerId,
    String? title,
    String? description,
    String? additionalDesc,
    String? bannerImageFileName,
    String? bannerImageFilePath,
    dynamic bannerImgBase64String,
    dynamic banneImage,
    num? displayOrder,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? createdOnString,
    String? changedBy,
    String? changedOn,
    String? changedOnString,
  }) {
    _orgId = orgId;
    _branchCode = branchCode;
    _bannerId = bannerId;
    _title = title;
    _description = description;
    _additionalDesc = additionalDesc;
    _bannerImageFileName = bannerImageFileName;
    _bannerImageFilePath = bannerImageFilePath;
    _bannerImgBase64String = bannerImgBase64String;
    _banneImage = banneImage;
    _displayOrder = displayOrder;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _createdOnString = createdOnString;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _changedOnString = changedOnString;
  }

  BannerModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _branchCode = json['BranchCode'];
    _bannerId = json['BannerId'];
    _title = json['Title'];
    _description = json['Description'];
    _additionalDesc = json['AdditionalDesc'];
    _bannerImageFileName = json['BannerImageFileName'];
    _bannerImageFilePath = json['BannerImageFilePath'];
    _bannerImgBase64String = json['BannerImg_Base64String'];
    _banneImage = json['BanneImage'];
    _displayOrder = json['DisplayOrder'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _createdOnString = json['CreatedOnString'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _changedOnString = json['ChangedOnString'];
  }
  int? _orgId;
  String? _branchCode;
  String? _bannerId;
  String? _title;
  String? _description;
  String? _additionalDesc;
  String? _bannerImageFileName;
  String? _bannerImageFilePath;
  dynamic _bannerImgBase64String;
  dynamic _banneImage;
  num? _displayOrder;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _createdOnString;
  String? _changedBy;
  String? _changedOn;
  String? _changedOnString;
  BannerModel copyWith({
    int? orgId,
    String? branchCode,
    String? bannerId,
    String? title,
    String? description,
    String? additionalDesc,
    String? bannerImageFileName,
    String? bannerImageFilePath,
    dynamic bannerImgBase64String,
    dynamic banneImage,
    num? displayOrder,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? createdOnString,
    String? changedBy,
    String? changedOn,
    String? changedOnString,
  }) =>
      BannerModel(
        orgId: orgId ?? _orgId,
        branchCode: branchCode ?? _branchCode,
        bannerId: bannerId ?? _bannerId,
        title: title ?? _title,
        description: description ?? _description,
        additionalDesc: additionalDesc ?? _additionalDesc,
        bannerImageFileName: bannerImageFileName ?? _bannerImageFileName,
        bannerImageFilePath: bannerImageFilePath ?? _bannerImageFilePath,
        bannerImgBase64String: bannerImgBase64String ?? _bannerImgBase64String,
        banneImage: banneImage ?? _banneImage,
        displayOrder: displayOrder ?? _displayOrder,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        createdOnString: createdOnString ?? _createdOnString,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        changedOnString: changedOnString ?? _changedOnString,
      );
  int? get orgId => _orgId;
  String? get branchCode => _branchCode;
  String? get bannerId => _bannerId;
  String? get title => _title;
  String? get description => _description;
  String? get additionalDesc => _additionalDesc;
  String? get bannerImageFileName => _bannerImageFileName;
  String? get bannerImageFilePath => _bannerImageFilePath;
  dynamic get bannerImgBase64String => _bannerImgBase64String;
  dynamic get banneImage => _banneImage;
  num? get displayOrder => _displayOrder;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get createdOnString => _createdOnString;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  String? get changedOnString => _changedOnString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BranchCode'] = _branchCode;
    map['BannerId'] = _bannerId;
    map['Title'] = _title;
    map['Description'] = _description;
    map['AdditionalDesc'] = _additionalDesc;
    map['BannerImageFileName'] = _bannerImageFileName;
    map['BannerImageFilePath'] = _bannerImageFilePath;
    map['BannerImg_Base64String'] = _bannerImgBase64String;
    map['BanneImage'] = _banneImage;
    map['DisplayOrder'] = _displayOrder;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['CreatedOnString'] = _createdOnString;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['ChangedOnString'] = _changedOnString;
    return map;
  }
}
