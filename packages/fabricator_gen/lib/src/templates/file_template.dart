import 'package:fabricator_gen/src/templates/template.dart';

class FileTemplate implements Template<Template> {
  final List<Template> members;

  FileTemplate({
    required this.members,
  });

  @override
  String render(Template context) {
    return members.map((m) => m.render(this)).join('\n\n');
  }
}
