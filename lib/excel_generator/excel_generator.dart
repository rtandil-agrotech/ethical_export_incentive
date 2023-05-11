import 'package:ethical_export_incentive/models/incentive_structure_model.dart';
import 'package:ethical_export_incentive/models/user_profile_model.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

part 'constants.dart';

class ExcelGenerator {
  ExcelGenerator._create();

  static Future<ExcelGenerator> create(
    DateTime period, {
    required Future<UserProfile> Function(int) getUser,
  }) async {
    final provider = ExcelGenerator._create();

    provider.sheet = await provider.gSheets.spreadsheet(_insentifSheet);
    provider.period = period;
    provider.getUser = getUser;

    return provider;
  }

  /* -------------------------------- Variables ------------------------------- */
  final GSheets gSheets = GSheets(_sheetCredentials);
  late final Spreadsheet sheet;
  late final DateTime period;
  late final Future<UserProfile> Function(int) getUser;

  static String get sheetUrl => _sheetUrl;

  /* --------------------------------- Methods -------------------------------- */
  Future<void> compile(IncentiveStructure data) async {
    // Write Worksheet with District Name
    final worksheet = await sheet.addWorksheet(data.salesZoneName);

    worksheet.values.insertRow(1, ExcelSheetRow.getColumnTitle);

    await _writeToExcel(worksheet, data);
  }

  Future<void> _writeToExcel(
    Worksheet worksheet,
    IncentiveStructure data,
  ) async {
    final UserProfile? user =
        data.userId != null ? await getUser(data.userId!) : null;

    final ExcelSheetRow row = ExcelSheetRow(
      period: DateFormat("MMMM yyyy", 'id_ID').format(period),
      salesZoneId: data.salesZoneId.toString(),
      salesZoneName: data.salesZoneName,
      salesZoneType: data.salesZoneType,
      userName: user?.userName ?? "VACANT",
      userNip: user?.userNip ?? "VACANT",
      roleLabel: data.roleLabel ?? "VACANT",
      salesValueMonthly: data.salesValueMonthly.toString(),
      salesTargetMonthly: data.salesTargetMonthly.toString(),
      valueIncentivePrincipal: data.valueIncentivePrincipal.toString(),
    );

    await worksheet.values.appendRow(row.getValue);

    if (data.children != null) {
      for (IncentiveStructure data in data.children!) {
        await _writeToExcel(worksheet, data);
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
        "Insentif"
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
        valueIncentivePrincipal
      ];
}
