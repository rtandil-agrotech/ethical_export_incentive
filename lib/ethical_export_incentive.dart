import 'package:ethical_export_incentive/api_provider.dart';

Future<void> generateExcel(
    {required DateTime salesPeriod, required int salesZoneId}) async {
  final provider = ApiProvider();

  final tokenHeader = await provider.login();

  await provider.getIncentiveStructureFromBackend(
      tokenHeader: tokenHeader,
      salesPeriod: salesPeriod,
      salesZoneId: salesZoneId);
}
