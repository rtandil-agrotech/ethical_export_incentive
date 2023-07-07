// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incentive_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncentiveModel _$IncentiveModelFromJson(Map<String, dynamic> json) =>
    IncentiveModel(
      zone: IncentiveZone.fromJson(json['zone'] as Map<String, dynamic>),
      user: IncentiveUser.fromJson(json['user'] as Map<String, dynamic>),
      accumulation: IncentiveAccumulation.fromJson(
          json['incentive_accumulation'] as Map<String, dynamic>),
      structure: json['incentive_structures'] == null
          ? null
          : IncentiveStructure.fromJson(
              json['incentive_structures'] as Map<String, dynamic>),
    );

IncentiveZone _$IncentiveZoneFromJson(Map<String, dynamic> json) =>
    IncentiveZone(
      salesZoneId: json['sales_zone_id'] as int,
      salesZoneType: json['sales_zone_type'] as String,
      salesZoneName: json['sales_zone_name'] as String,
    );

IncentiveUser _$IncentiveUserFromJson(Map<String, dynamic> json) =>
    IncentiveUser(
      userId: json['id'] as int?,
      userName: json['name'] as String?,
      userAuthServerId: json['auth_server_id'] as int?,
      userNip: json['nip'] as String?,
      roleId: json['role_id'] as int?,
      roleName: json['role_name'] as String?,
      roleLabel: json['role_label'] as String?,
    );

IncentiveAccumulation _$IncentiveAccumulationFromJson(
        Map<String, dynamic> json) =>
    IncentiveAccumulation(
      valueIncentivePrincipal:
          (json['value_incentive_principal'] as num).toDouble(),
      targetIndividual: (json['target_individual'] as num?)?.toDouble(),
      targetAsm: (json['target_asm'] as num?)?.toDouble(),
      targetSm: (json['target_sm'] as num?)?.toDouble(),
      targetNsm: (json['target_nsm'] as num?)?.toDouble(),
      targetDivisi: (json['target_divisi'] as num?)?.toDouble(),
      achievementPercentage: json['achievement_percentage'] as int,
      valueIncentiveTotal: (json['value_incentive_total'] as num?)?.toDouble(),
    );
