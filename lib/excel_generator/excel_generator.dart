import 'package:ethical_export_incentive/models/incentive_model.dart';
import 'package:ethical_export_incentive/models/incentive_structure_model.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

part 'constants.dart';

class ExcelGenerator {
  ExcelGenerator._create();

  static Future<ExcelGenerator> create(
    DateTime period, {
    // required Future<UserProfile> Function(int) getUser,
    required Future<IncentiveModel> Function(int, String) getIncentive,
  }) async {
    final provider = ExcelGenerator._create();

    provider.sheet = await provider.gSheets.spreadsheet(_insentifSheet);
    provider.period = period;
    // provider.getUser = getUser;
    provider.getIncentive = getIncentive;

    return provider;
  }

  /* -------------------------------- Variables ------------------------------- */
  final GSheets gSheets = GSheets(_sheetCredentials);
  late final Spreadsheet sheet;
  late final DateTime period;
  // late final Future<UserProfile> Function(int) getUser;
  late final Future<IncentiveModel> Function(int, String) getIncentive;

  static String get sheetUrl => _sheetUrl;

  /* --------------------------------- Methods -------------------------------- */
  Future<void> compile(IncentiveModel data) async {
    // Write Worksheet with District Name
    final worksheet = await sheet.addWorksheet(data.zone.salesZoneName);

    await worksheet.values.insertRow(1, ExcelSheetRow.getColumnTitle);

    await _writeToExcel(worksheet, data);
  }

  Future<void> _writeToExcel(
    Worksheet worksheet,
    IncentiveModel data,
  ) async {
    final ExcelSheetRow row = ExcelSheetRow(
      period: DateFormat("MMMM yyyy", 'id_ID').format(period),
      salesZoneId: data.zone.salesZoneId.toString(),
      salesZoneName: data.zone.salesZoneName.toString(),
      salesZoneType: data.zone.salesZoneType.toString(),
      userName: data.user.userName ?? "VACANT",
      userNip: data.user.userNip ?? "VACANT",
      roleLabel: data.user.roleLabel ?? "VACANT",
      salesValueMonthly: data.structure?.salesValueMonthly.toString() ?? "",
      salesTargetMonthly: data.structure?.salesTargetMonthly.toString() ?? "",
      valueIncentivePrincipal:
          data.accumulation.valueIncentivePrincipal.toString(),
      achievementPercentage: data.accumulation.achievementPercentage.toString(),
      valueIncentiveTotal: data.accumulation.valueIncentiveTotal.toString(),
    );

    await worksheet.values.appendRow(row.getValue);

    if (data.structure?.children != null) {
      for (IncentiveStructure data in data.structure!.children!) {
        final response =
            await getIncentive(data.salesZoneId, data.salesZoneType);

        await _writeToExcel(worksheet, response);
      }
    }
  }
}

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
