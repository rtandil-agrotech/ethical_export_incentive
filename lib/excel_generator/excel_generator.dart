import 'package:ethical_export_incentive/models/excel_sheet_row.dart';
import 'package:ethical_export_incentive/models/incentive_model/incentive_model.dart';
import 'package:ethical_export_incentive/models/incentive_structure_model/incentive_structure_model.dart';
import 'package:ethical_export_incentive/models/revision/incentive_indicator.dart';
import 'package:ethical_export_incentive/models/revision/incentive_indicator_constants.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

part 'constants.dart';

class ExcelGenerator {
  ExcelGenerator._create();

  static Future<ExcelGenerator> create(
    DateTime period, {
    // required Future<UserProfile> Function(int) getUser,
    required Future<IncentiveModel> Function(int, String) getIncentive,
    required List<IncentiveIndicator> incentiveIndicator,
  }) async {
    final provider = ExcelGenerator._create();

    provider.sheet = await provider.gSheets.spreadsheet(_insentifSheet);
    provider.period = period;
    // provider.getUser = getUser;
    provider.getIncentive = getIncentive;
    provider.incentiveIndicator = incentiveIndicator;

    return provider;
  }

  /* -------------------------------- Variables ------------------------------- */
  final GSheets gSheets = GSheets(_sheetCredentials);
  late final Spreadsheet sheet;
  late final DateTime period;
  // late final Future<UserProfile> Function(int) getUser;
  late final Future<IncentiveModel> Function(int, String) getIncentive;
  late final List<IncentiveIndicator> incentiveIndicator;

  static String get sheetUrl => _sheetUrl;

  /* --------------------------------- Methods -------------------------------- */
  Future<void> compile(IncentiveModel data) async {
    final achievementDivisi = ((data.structure!.salesValueMonthly / data.structure!.salesTargetMonthly) * 100).toInt();

    for (IncentiveStructure districtData in data.structure!.children!) {
      final resultNSM = await getIncentive(districtData.salesZoneId, "districts");

      Worksheet worksheet;

      if (sheet.worksheetByTitle(resultNSM.user.userName!) != null) {
        await sheet.deleteWorksheet(sheet.worksheetByTitle(resultNSM.user.userName!)!);
        worksheet = await sheet.addWorksheet(resultNSM.user.userName!);
        await worksheet.values.insertRow(1, ExcelSheetRow.getColumnTitle);
      } else {
        worksheet = await sheet.addWorksheet(resultNSM.user.userName!);
        await worksheet.values.insertRow(1, ExcelSheetRow.getColumnTitle);
      }

      await writeToExcelNSM(worksheet, resultNSM, achievementDivisi);

      for (IncentiveStructure regionData in resultNSM.structure!.children!) {
        final resultSM = await getIncentive(regionData.salesZoneId, "regions");

        await writeToExcelSM(worksheet, resultSM, resultNSM, achievementDivisi);

        for (IncentiveStructure areaData in resultSM.structure!.children!) {
          final resultASM = await getIncentive(areaData.salesZoneId, "areas");

          await writeToExcelASM(worksheet, resultASM, resultSM, resultNSM, achievementDivisi);

          for (IncentiveStructure gtData in resultASM.structure!.children!) {
            final resultFF = await getIncentive(gtData.salesZoneId, "group_territories");

            await writeToExcelFF(worksheet, resultFF, resultASM, resultSM, resultNSM, achievementDivisi);
          }
        }
      }

      await Future.delayed(Duration(seconds: 20));
    }
  }

  Future<void> writeToExcelNSM(
    Worksheet worksheet,
    IncentiveModel dataNSM,
    int achievementDivisi,
  ) async {
    final ExcelSheetRow row = ExcelSheetRow(
      period: DateFormat("MMMM yyyy", 'id_ID').format(period),
      salesZoneId: dataNSM.zone.salesZoneId.toString(),
      salesZoneName: dataNSM.zone.salesZoneName.toString(),
      salesZoneType: dataNSM.zone.salesZoneType.toString(),
      userName: dataNSM.user.userName ?? "VACANT",
      userNip: dataNSM.user.userNip ?? "VACANT",
      roleLabel: dataNSM.user.roleLabel ?? "VACANT",
      salesValueMonthly: dataNSM.structure!.salesValueMonthly.toString(),
      salesTargetMonthly: dataNSM.structure!.salesTargetMonthly.toString(),
      valueIncentivePrincipal: dataNSM.accumulation.valueIncentivePrincipal.toString(),
      targetDivisi: dataNSM.accumulation.targetDivisi?.toString() ?? "",
      targetAsm: "",
      targetSm: "",
      targetNsm: "",
      targetIndividu: dataNSM.accumulation.targetIndividual?.toString() ?? "",
      achievementPercentage: dataNSM.accumulation.achievementPercentage.toString(),
      valueIncentiveTotal: dataNSM.accumulation.valueIncentiveTotal.toString(),
    );

    await worksheet.values.appendRow(row.getValue);
  }

  Future<void> writeToExcelSM(
    Worksheet worksheet,
    IncentiveModel dataSM,
    IncentiveModel dataNSM,
    int achievementDivisi,
  ) async {
    final ExcelSheetRow row = ExcelSheetRow(
      period: DateFormat("MMMM yyyy", 'id_ID').format(period),
      salesZoneId: dataSM.zone.salesZoneId.toString(),
      salesZoneName: dataSM.zone.salesZoneName.toString(),
      salesZoneType: dataSM.zone.salesZoneType.toString(),
      userName: dataSM.user.userName ?? "VACANT",
      userNip: dataSM.user.userNip ?? "VACANT",
      roleLabel: dataSM.user.roleLabel ?? "VACANT",
      salesValueMonthly: dataSM.structure!.salesValueMonthly.toString(),
      salesTargetMonthly: dataSM.structure!.salesTargetMonthly.toString(),
      valueIncentivePrincipal: dataSM.accumulation.valueIncentivePrincipal.toString(),
      targetDivisi: dataSM.accumulation.targetDivisi?.toString() ?? "",
      targetAsm: "",
      targetSm: "",
      targetNsm: dataSM.accumulation.targetNsm?.toString() ?? "",
      targetIndividu: dataSM.accumulation.targetIndividual?.toString() ?? "",
      achievementPercentage: dataSM.accumulation.achievementPercentage.toString(),
      valueIncentiveTotal: dataSM.accumulation.valueIncentiveTotal.toString(),
    );

    await worksheet.values.appendRow(row.getValue);
  }

  Future<void> writeToExcelASM(
    Worksheet worksheet,
    IncentiveModel dataASM,
    IncentiveModel dataSM,
    IncentiveModel dataNSM,
    int achievementDivisi,
  ) async {
    final ExcelSheetRow row = ExcelSheetRow(
      period: DateFormat("MMMM yyyy", 'id_ID').format(period),
      salesZoneId: dataASM.zone.salesZoneId.toString(),
      salesZoneName: dataASM.zone.salesZoneName.toString(),
      salesZoneType: dataASM.zone.salesZoneType.toString(),
      userName: dataASM.user.userName ?? "VACANT",
      userNip: dataASM.user.userNip ?? "VACANT",
      roleLabel: dataASM.user.roleLabel ?? "VACANT",
      salesValueMonthly: dataASM.structure!.salesValueMonthly.toString(),
      salesTargetMonthly: dataASM.structure!.salesTargetMonthly.toString(),
      valueIncentivePrincipal: dataASM.accumulation.valueIncentivePrincipal.toString(),
      targetDivisi: dataASM.accumulation.targetDivisi?.toString() ?? "",
      targetAsm: "",
      targetSm: dataASM.accumulation.targetSm?.toString() ?? "",
      targetNsm: dataASM.accumulation.targetNsm?.toString() ?? "",
      targetIndividu: dataASM.accumulation.targetIndividual?.toString() ?? "",
      achievementPercentage: dataASM.accumulation.achievementPercentage.toString(),
      valueIncentiveTotal: dataASM.accumulation.valueIncentiveTotal.toString(),
    );

    await worksheet.values.appendRow(row.getValue);
  }

  Future<void> writeToExcelFF(
    Worksheet worksheet,
    IncentiveModel dataFF,
    IncentiveModel dataASM,
    IncentiveModel dataSM,
    IncentiveModel dataNSM,
    int achievementDivisi,
  ) async {
    final ExcelSheetRow row = ExcelSheetRow(
      period: DateFormat("MMMM yyyy", 'id_ID').format(period),
      salesZoneId: dataFF.zone.salesZoneId.toString(),
      salesZoneName: dataFF.zone.salesZoneName.toString(),
      salesZoneType: dataFF.zone.salesZoneType.toString(),
      userName: dataFF.user.userName ?? "VACANT",
      userNip: dataFF.user.userNip ?? "VACANT",
      roleLabel: dataFF.user.roleLabel ?? "VACANT",
      salesValueMonthly:
          dataASM.structure!.children!.firstWhere((element) => element.salesZoneId == dataFF.zone.salesZoneId).salesValueMonthly.toString(),
      salesTargetMonthly:
          dataASM.structure!.children!.firstWhere((element) => element.salesZoneId == dataFF.zone.salesZoneId).salesTargetMonthly.toString(),
      valueIncentivePrincipal: dataFF.accumulation.valueIncentivePrincipal.toString(),
      targetDivisi: dataFF.accumulation.targetDivisi?.toString() ?? "",
      targetAsm: dataFF.accumulation.targetAsm?.toString() ?? "",
      targetSm: dataFF.accumulation.targetSm?.toString() ?? "",
      targetNsm: dataFF.accumulation.targetNsm?.toString() ?? "",
      targetIndividu: dataFF.accumulation.targetIndividual?.toString() ?? "",
      achievementPercentage: dataFF.accumulation.achievementPercentage.toString(),
      valueIncentiveTotal: dataFF.accumulation.valueIncentiveTotal.toString(),
    );

    await worksheet.values.appendRow(row.getValue);
  }
}
