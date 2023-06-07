import 'package:args/args.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ethical_export_incentive/ethical_export_incentive.dart' as ethical_export_incentive;

const salesPeriodArg = 'period';
const help = 'help';

const salesPeriodHelp = r'''
  Pass period argument in YYYY-MM-DD format.
  Must not be null.
''';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(salesPeriodArg, abbr: 'p', help: salesPeriodHelp)
    ..addFlag(help, abbr: 'h', negatable: false);

  ArgResults argResults = parser.parse(arguments);

  if (argResults[help]) {
    print(parser.usage);
    return;
  }

  if (argResults[salesPeriodArg] == null) {
    throw Exception("Missing arguments");
  }

  await initializeDateFormatting('id_ID');

  print("Loading...");

  await ethical_export_incentive.generateExcel(salesPeriod: DateTime.parse(argResults[salesPeriodArg]));
}
