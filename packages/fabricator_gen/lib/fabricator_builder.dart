import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/fabricator_generator.dart';

Builder fabricatorBuilder(BuilderOptions options) => SharedPartBuilder(
      [FabricatorGenerator()],
      'fabricator',
    );
