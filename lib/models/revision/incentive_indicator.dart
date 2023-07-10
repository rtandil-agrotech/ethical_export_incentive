class IncentiveIndicator {
  const IncentiveIndicator({
    required this.id,
    required this.indicatorHeaderId,
    this.targetIndividu,
    this.targetAsm,
    this.targetSm,
    this.targetNsm,
    this.targetDivisi,
    required this.marginBottom,
    required this.marginTop,
    required this.periodeStart,
    required this.periodeEnd,
  });

  final int id;
  final int indicatorHeaderId;
  final double? targetIndividu;
  final double? targetAsm;
  final double? targetSm;
  final double? targetNsm;
  final double? targetDivisi;
  final int marginBottom;
  final int marginTop;
  final DateTime periodeStart;
  final DateTime periodeEnd;

  factory IncentiveIndicator.fromJson(Map<String, dynamic> json) {
    return IncentiveIndicator(
      id: json['id'],
      indicatorHeaderId: json['incentive_indicator_header_id'],
      targetIndividu: (json['target_individual'] as num?)?.toDouble(),
      targetAsm: (json['target_asm'] as num?)?.toDouble(),
      targetSm: (json['target_sm'] as num?)?.toDouble(),
      targetNsm: (json['target_nsm'] as num?)?.toDouble(),
      targetDivisi: (json['target_divisi'] as num?)?.toDouble(),
      marginBottom: (json['margin_bottom_achievement'] as num).toInt(),
      marginTop: json['margin_top_achievement'] != 0 ? (json['margin_top_achievement'] as num).toInt() : 999,
      periodeStart: DateTime.fromMillisecondsSinceEpoch(json['period_start_time'] * 1000),
      periodeEnd: DateTime.fromMillisecondsSinceEpoch(json['period_end_time'] * 1000),
    );
  }
}
