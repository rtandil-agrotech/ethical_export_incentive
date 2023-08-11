import 'package:ethical_export_incentive/api_provider.dart';
import 'package:ethical_export_incentive/excel_generator/excel_generator.dart';
import 'package:ethical_export_incentive/models/revision/incentive_indicator.dart';

Future<void> run({required DateTime salesPeriod}) async {
  final provider = ApiProvider();

  // final tokenHeader = await provider.login();
  final tokenHeader = {'Email': '1'};

  final List<IncentiveIndicator> incentiveIndicator = await provider.getIncentiveIndicator(tokenHeader: tokenHeader);

  final result = await provider.getIncentiveStructureFromBackend(
    tokenHeader: tokenHeader,
    salesPeriod: salesPeriod,
  );

  final ExcelGenerator generator = await ExcelGenerator.create(
    salesPeriod,
    // getUser: (userId) =>
    //     provider.getUserData(tokenHeader: tokenHeader, userId: userId),
    getIncentive: (salesZoneId, salesZoneType) => provider.getIncentiveStructureFromBackend(
      tokenHeader: tokenHeader,
      salesPeriod: salesPeriod,
      salesZoneId: salesZoneId,
      salesZoneType: salesZoneType,
    ),
    incentiveIndicator: incentiveIndicator,
  );

  await generator.compile(result);

  print("SUCCESS - ${ExcelGenerator.sheetUrl}");
}
