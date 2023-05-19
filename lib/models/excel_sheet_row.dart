class ExcelSheetRow {
  final String period;
  final String salesZoneId;
  final String salesZoneName;
  final String salesZoneType;
  final String userName;
  final String userNip;
  final String roleLabel;
  final String salesValueMonthly;
  final String salesTargetMonthly;
  final String valueIncentivePrincipal;
  final String achievementPercentage;
  final String valueIncentiveTotal;

  const ExcelSheetRow({
    required this.period,
    required this.salesZoneId,
    required this.salesZoneName,
    required this.salesZoneType,
    required this.userName,
    required this.userNip,
    required this.roleLabel,
    required this.salesValueMonthly,
    required this.salesTargetMonthly,
    required this.valueIncentivePrincipal,
    required this.achievementPercentage,
    required this.valueIncentiveTotal,
  });

  static List<String> get getColumnTitle => [
        "Bulan",
        "Sales Zone ID",
        "Sales Zone Name",
        "Sales Zone Type",
        "Nama",
        "NIP",
        "Role Name",
        "Sales Bulanan",
        "Target Sales Bulanan",
        "Insentif Pokok",
        "Pencapaian (%)",
        "Insentif Akhir",
      ];

  List<String> get getValue => [
        period,
        salesZoneId,
        salesZoneName,
        salesZoneType,
        userName,
        userNip,
        roleLabel,
        salesValueMonthly,
        salesTargetMonthly,
        valueIncentivePrincipal,
        achievementPercentage,
        valueIncentiveTotal,
      ];
}
