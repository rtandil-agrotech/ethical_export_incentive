import 'package:json_annotation/json_annotation.dart';

part 'incentive_structure_model.g.dart';

@JsonSerializable(createToJson: false)
class IncentiveStructure {
  @JsonKey(name: "sales_zone_id")
  final int salesZoneId;

  @JsonKey(name: "sales_zone_type")
  final String salesZoneType;

  @JsonKey(name: "sales_zone_name")
  final String salesZoneName;

  @JsonKey(name: "user_id")
  final int? userId;

  @JsonKey(name: "role_type")
  final String? roleType;

  @JsonKey(name: "role_label")
  final String? roleLabel;

  @JsonKey(name: "sales_value_monthly")
  final double salesValueMonthly;

  @JsonKey(name: "sales_target_monthly")
  final double salesTargetMonthly;

  @JsonKey(name: "value_incentive_principal")
  final double valueIncentivePrincipal;

  final List<IncentiveStructure>? children;

  const IncentiveStructure({
    required this.salesZoneId,
    required this.salesZoneType,
    required this.salesZoneName,
    this.userId,
    this.roleType,
    this.roleLabel,
    required this.salesValueMonthly,
    required this.salesTargetMonthly,
    required this.valueIncentivePrincipal,
    this.children,
  });

  factory IncentiveStructure.fromJson(Map<String, dynamic> json) => _$IncentiveStructureFromJson(json);
}
