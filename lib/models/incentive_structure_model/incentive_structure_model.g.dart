// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incentive_structure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncentiveStructure _$IncentiveStructureFromJson(Map<String, dynamic> json) =>
    IncentiveStructure(
      salesZoneId: json['sales_zone_id'] as int,
      salesZoneType: json['sales_zone_type'] as String,
      salesZoneName: json['sales_zone_name'] as String,
      userId: json['user_id'] as int?,
      roleType: json['role_type'] as String?,
      roleLabel: json['role_label'] as String?,
      salesValueMonthly: (json['sales_value_monthly'] as num).toDouble(),
      salesTargetMonthly: (json['sales_target_monthly'] as num).toDouble(),
      valueIncentivePrincipal:
          (json['value_incentive_principal'] as num).toDouble(),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => IncentiveStructure.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
