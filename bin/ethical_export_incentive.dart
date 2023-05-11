import 'package:args/args.dart';
import 'package:ethical_export_incentive/ethical_export_incentive.dart'
    as ethical_export_incentive;

const salesPeriodArg = 'period';
const salesZoneIdArg = 'id';
void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag(salesPeriodArg, negatable: false, abbr: 'p')
    ..addFlag(salesZoneIdArg, negatable: false, abbr: 'i');

  ArgResults argResults = parser.parse(arguments);

  print(argResults);

  ethical_export_incentive.generateExcel(
      salesPeriod: DateTime(2023, 3, 1), salesZoneId: 12);
}
