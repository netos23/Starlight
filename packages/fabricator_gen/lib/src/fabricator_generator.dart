import 'dart:async';

import 'package:build/build.dart';
import 'package:fabricator/fabricator.dart';
import 'package:fabricator_gen/src/templates/template.dart';
import 'package:source_gen/source_gen.dart';

import 'container.dart';
import 'templates/class_template.dart';
import 'templates/file_template.dart';

class FabricatorGenerator extends Generator {
  final _moduleTypeChecker = TypeChecker.fromRuntime(Module);
  final _singletonTypeChecker = TypeChecker.fromRuntime(Singleton);
  final _lazySingletonTypeChecker = TypeChecker.fromRuntime(LazySingleton);
  final _factoryTypeChecker = TypeChecker.fromRuntime(Factory);

  @override
  Future<String> generate(
    LibraryReader library,
    BuildStep buildStep,
  ) async {
    final dependencies = <List<AnnotatedElement>>{};
    for(final singleton in library.annotatedWith(_singletonTypeChecker)){

    }



    final buffer = <String>[];
    for (final el in library.annotatedWith(_moduleTypeChecker)) {
      final template = FileTemplate(
        members: [
          ClassTemplate(
            classType: MixinClassTypeTemplate(),
            name: ClassNameTemplate(
              name: '_\$${el.element.name}',
            ),
          ),
        ],
      );
    }

    return buffer.join('\n\n');
  }
}
