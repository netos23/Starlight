import 'package:fabricator_gen/src/templates/file_template.dart';
import 'package:fabricator_gen/src/templates/template.dart';

sealed class ClassTypeTemplate implements Template<ClassTemplate> {}

final class BaseClassTypeTemplate extends ClassTypeTemplate {
  @override
  String render(ClassTemplate context) {
    return 'base';
  }
}

final class InterfaceClassTypeTemplate extends ClassTypeTemplate {
  @override
  String render(ClassTemplate context) {
    return 'interface';
  }
}

final class MixinClassTypeTemplate extends ClassTypeTemplate {
  @override
  String render(ClassTemplate context) {
    return 'mixin';
  }
}

final class BaseMixinClassTypeTemplate extends ClassTypeTemplate {
  @override
  String render(ClassTemplate context) {
    return 'base mixin';
  }
}

class GenericArgTemplate implements Template<ClassNameTemplate> {
  final String name;
  final ClassNameTemplate? superTypeTemplate;

  GenericArgTemplate({
    required this.name,
    this.superTypeTemplate,
  });

  @override
  String render(ClassNameTemplate context) {
    final suffix = _buildSuffix(context);
    return '<$name$suffix>';
  }

  String _buildSuffix(ClassNameTemplate context) {
    final superType = superTypeTemplate?.render(this);

    if (superType == null) {
      return '';
    }

    return ' extends $superType';
  }
}

class ClassNameTemplate implements Template<Template> {
  final String name;
  final GenericArgTemplate? genericArgTemplate;

  ClassNameTemplate({
    required this.name,
    this.genericArgTemplate,
  });

  @override
  String render(Template context) {
    final genericArg = genericArgTemplate?.render(this) ?? '';
    return '$name$genericArg';
  }
}

class ClassTemplate implements Template<FileTemplate> {
  final bool isAbstract;
  final ClassTypeTemplate? classType;
  final List<Template> children;
  final ClassNameTemplate name;
  final ClassNameTemplate? superType;
  final List<ClassNameTemplate> interfaces;
  final List<ClassNameTemplate> mixins;

  ClassTemplate({
    this.isAbstract = false,
    this.classType,
    this.children = const [],
    required this.name,
    this.superType,
    this.interfaces = const [],
    this.mixins = const [],
  });

  @override
  String render(FileTemplate context) {
    final prefix = _renderPrefix(context);
    final suffix = _renderSuffix(context);
    final children = _renderChildren();

    return '''
      $prefix class $name $suffix {
       $children
      }
    ''';
  }

  String _renderPrefix(FileTemplate context) {
    final abstractPrefix = isAbstract ? 'abstract' : '';
    final type = classType?.render(this) ?? '';

    return '$abstractPrefix $type'.trim();
  }

  String _renderSuffix(FileTemplate context) {
    final buffer = StringBuffer();

    final superType = this.superType?.render(this);
    if(superType != null){
      buffer.write(' extends $superType');
    }

    if(mixins.isNotEmpty){
      buffer.write(' with');
      final length = mixins.length;
      for(final mixin in mixins.take(length - 1)){
        buffer.write(' $mixin,');
      }
      buffer.write(' ${mixins.last}');
    }

    if(interfaces.isNotEmpty){
      buffer.write(' implements');
      final length = mixins.length;
      for(final interface in interfaces.take(length - 1)){
        buffer.write(' $interface,');
      }
      buffer.write(' ${interfaces.last}');
    }

    return buffer.toString();
  }

  String _renderChildren() {
    return children.map((ch) => ch.render(this)).join('\n\n');
  }
}
