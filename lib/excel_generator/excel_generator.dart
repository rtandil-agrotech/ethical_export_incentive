import 'package:ethical_export_incentive/excel_generator/zone_type_constants.dart';
import 'package:ethical_export_incentive/models/excel_sheet_row.dart';
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

    await _handleCompile(worksheet, data);
  }

  Future<void> _handleCompile(Worksheet worksheet, IncentiveModel data) async {
    await _writeToExcel(worksheet, data);

    if (data.structure != null) {
      for (IncentiveStructure structure in data.structure!.children!) {
        final response =
            await getIncentive(structure.salesZoneId, structure.salesZoneType);

        if (data.zone.salesZoneType != zoneTypeAsm) {
          await _handleCompile(worksheet, response);
        } else {
          await _writeToExcelAsm(worksheet, response, data);
        }
      }
    }
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
  }

  Future<void> _writeToExcelAsm(
    Worksheet worksheet,
    IncentiveModel dataFF,
    IncentiveModel dataASM,
  ) async {
    final ExcelSheetRow row = ExcelSheetRow(
      period: DateFormat("MMMM yyyy", 'id_ID').format(period),
      salesZoneId: dataFF.zone.salesZoneId.toString(),
      salesZoneName: dataFF.zone.salesZoneName.toString(),
      salesZoneType: dataFF.zone.salesZoneType.toString(),
      userName: dataFF.user.userName ?? "VACANT",
      userNip: dataFF.user.userNip ?? "VACANT",
      roleLabel: dataFF.user.roleLabel ?? "VACANT",
      salesValueMonthly: dataASM.structure!.children!
          .firstWhere(
              (element) => element.salesZoneId == dataFF.zone.salesZoneId)
          .salesValueMonthly
          .toString(),
      salesTargetMonthly: dataASM.structure!.children!
          .firstWhere(
              (element) => element.salesZoneId == dataFF.zone.salesZoneId)
          .salesTargetMonthly
          .toString(),
      valueIncentivePrincipal:
          dataFF.accumulation.valueIncentivePrincipal.toString(),
      achievementPercentage:
          dataFF.accumulation.achievementPercentage.toString(),
      valueIncentiveTotal: dataFF.accumulation.valueIncentiveTotal.toString(),
    );

    await worksheet.values.appendRow(row.getValue);
  }
}
