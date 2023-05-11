import 'package:ethical_export_incentive/api_provider.dart';
import 'package:ethical_export_incentive/excel_generator/excel_generator.dart';

Future<void> generateExcel(
    {required DateTime salesPeriod, required int salesZoneId}) async {
  final provider = ApiProvider();

  final tokenHeader = await provider.login();

  final result = await provider.getIncentiveStructureFromBackend(
      tokenHeader: tokenHeader,
      salesPeriod: salesPeriod,
      salesZoneId: salesZoneId);

  final ExcelGenerator generator = await ExcelGenerator.create(salesPeriod,
      getUser: (userId) =>
          provider.getUserData(tokenHeader: tokenHeader, userId: userId));

  await generator.compile(result);

  print("Success: ${ExcelGenerator.sheetUrl}");
}
