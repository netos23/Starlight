abstract interface class TemplateContext {}

abstract interface class Template<Parent extends TemplateContext>
    extends TemplateContext {
  String render(Parent context);
}
