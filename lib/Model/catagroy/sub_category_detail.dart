import 'package:collection/collection.dart';

class SubCategoryDetail {
  int? orgId;
  String? code;
  String? name;
  dynamic categoryName;
  String? chineseDescription;
  String? categoryCode;
  int? displayOrder;
  bool? isPos;
  bool? isB2B;
  bool? isB2C;
  bool? isErp;
  bool? isActive;
  String? createdBy;
  DateTime? createdOn;
  String? changedBy;
  DateTime? changedOn;
  dynamic createdOnString;
  dynamic changedOnString;

  SubCategoryDetail({
    this.orgId,
    this.code,
    this.name,
    this.categoryName,
    this.chineseDescription,
    this.categoryCode,
    this.displayOrder,
    this.isPos,
    this.isB2B,
    this.isB2C,
    this.isErp,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.createdOnString,
    this.changedOnString,
  });

  factory SubCategoryDetail.fromJson(Map<String, dynamic> json) {
    return SubCategoryDetail(
      orgId: json['OrgId'] as int?,
      code: json['Code'] as String?,
      name: json['Name'] as String?,
      categoryName: json['CategoryName'] as dynamic,
      chineseDescription: json['ChineseDescription'] as String?,
      categoryCode: json['CategoryCode'] as String?,
      displayOrder: json['DisplayOrder'] as int?,
      isPos: json['IsPOS'] as bool?,
      isB2B: json['IsB2B'] as bool?,
      isB2C: json['IsB2C'] as bool?,
      isErp: json['IsERP'] as bool?,
      isActive: json['IsActive'] as bool?,
      createdBy: json['CreatedBy'] as String?,
      createdOn: json['CreatedOn'] == null
          ? null
          : DateTime.parse(json['CreatedOn'] as String),
      changedBy: json['ChangedBy'] as String?,
      changedOn: json['ChangedOn'] == null
          ? null
          : DateTime.parse(json['ChangedOn'] as String),
      createdOnString: json['CreatedOnString'] as dynamic,
      changedOnString: json['ChangedOnString'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'OrgId': orgId,
        'Code': code,
        'Name': name,
        'CategoryName': categoryName,
        'ChineseDescription': chineseDescription,
        'CategoryCode': categoryCode,
        'DisplayOrder': displayOrder,
        'IsPOS': isPos,
        'IsB2B': isB2B,
        'IsB2C': isB2C,
        'IsERP': isErp,
        'IsActive': isActive,
        'CreatedBy': createdBy,
        'CreatedOn': createdOn?.toIso8601String(),
        'ChangedBy': changedBy,
        'ChangedOn': changedOn?.toIso8601String(),
        'CreatedOnString': createdOnString,
        'ChangedOnString': changedOnString,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SubCategoryDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      orgId.hashCode ^
      code.hashCode ^
      name.hashCode ^
      categoryName.hashCode ^
      chineseDescription.hashCode ^
      categoryCode.hashCode ^
      displayOrder.hashCode ^
      isPos.hashCode ^
      isB2B.hashCode ^
      isB2C.hashCode ^
      isErp.hashCode ^
      isActive.hashCode ^
      createdBy.hashCode ^
      createdOn.hashCode ^
      changedBy.hashCode ^
      changedOn.hashCode ^
      createdOnString.hashCode ^
      changedOnString.hashCode;
}
