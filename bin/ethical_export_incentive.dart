import 'package:args/args.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ethical_export_incentive/ethical_export_incentive.dart'
    as ethical_export_incentive;

const salesPeriodArg = 'period';
const salesZoneIdArg = 'id';
void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(salesPeriodArg, abbr: 'p')
    ..addOption(salesZoneIdArg, abbr: 'i');

  ArgResults argResults = parser.parse(arguments);

  if (argResults[salesPeriodArg] == null ||
      argResults[salesZoneIdArg] == null) {
    throw Exception("Missing arguments");
  }

  await initializeDateFormatting('id_ID');

  print("Loading...");

  await ethical_export_incentive.generateExcel(
      salesPeriod: DateTime.parse(argResults[salesPeriodArg]),
      salesZoneId: int.parse(argResults[salesZoneIdArg]));
}
