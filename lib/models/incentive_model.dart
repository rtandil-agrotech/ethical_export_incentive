import 'package:ethical_export_incentive/models/incentive_structure_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incentive_model.g.dart';

@JsonSerializable(createToJson: false)
class IncentiveModel {
  @JsonKey(name: 'zone')
  final IncentiveZone zone;

  @JsonKey(name: 'user')
  final IncentiveUser user;

  @JsonKey(name: 'incentive_accumulation')
  final IncentiveAccumulation accumulation;

  @JsonKey(name: 'incentive_structures')
  final IncentiveStructure? structure;

  const IncentiveModel({
    required this.zone,
    required this.user,
    required this.accumulation,
    required this.structure,
  });

  factory IncentiveModel.fromJson(Map<String, dynamic> json) => _$IncentiveModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class IncentiveZone {
  @JsonKey(name: 'sales_zone_id')
  final int salesZoneId;

  @JsonKey(name: 'sales_zone_type')
  final String salesZoneType;

  @JsonKey(name: 'sales_zone_name')
  final String salesZoneName;

  const IncentiveZone({
    required this.salesZoneId,
    required this.salesZoneType,
    required this.salesZoneName,
  });

  factory IncentiveZone.fromJson(Map<String, dynamic> json) => _$IncentiveZoneFromJson(json);
}

@JsonSerializable(createToJson: false)
class IncentiveUser {
  @JsonKey(name: 'id')
  final int? userId;

  @JsonKey(name: 'name')
  final String? userName;

  @JsonKey(name: 'auth_server_id')
  final int? userAuthServerId;

  @JsonKey(name: 'nip')
  final String? userNip;

  @JsonKey(name: 'role_id')
  final int? roleId;

  @JsonKey(name: 'role_name')
  final String? roleName;

  @JsonKey(name: 'role_label')
  final String? roleLabel;

  const IncentiveUser({
    this.userId,
    this.userName,
    this.userAuthServerId,
    this.userNip,
    this.roleId,
    this.roleName,
    this.roleLabel,
  });

  factory IncentiveUser.fromJson(Map<String, dynamic> json) => _$IncentiveUserFromJson(json);
}

@JsonSerializable(createToJson: false)
class IncentiveAccumulation {
  @JsonKey(name: 'value_incentive_principal')
  final double valueIncentivePrincipal;

  @JsonKey(name: 'achievement_percentage')
  final int achievementPercentage;

  @JsonKey(name: 'target_individual')
  final double? targetIndividual;

  @JsonKey(name: 'target_asm')
  final double? targetAsm;

  @JsonKey(name: 'target_sm')
  final double? targetSm;

  @JsonKey(name: 'target_nsm')
  final double? targetNsm;

  @JsonKey(name: 'target_divisi')
  final double? targetDivisi;

  @JsonKey(name: 'value_incentive_total')
  final double? valueIncentiveTotal;

  const IncentiveAccumulation({
    required this.valueIncentivePrincipal,
    this.targetIndividual,
    this.targetAsm,
    this.targetSm,
    this.targetNsm,
    this.targetDivisi,
    required this.achievementPercentage,
    required this.valueIncentiveTotal,
  });

  factory IncentiveAccumulation.fromJson(Map<String, dynamic> json) => _$IncentiveAccumulationFromJson(json);
}
