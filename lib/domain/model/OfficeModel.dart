class OfficeModel {
  final int id;
  final String name;
  final String location;

  factory OfficeModel({
    required String name,
    required String location,
}) {
    return OfficeModel._(name.hashCode ^ location.hashCode, name, location);
  }

  const OfficeModel._(
      this.id,
      this.name,
      this.location,
      );
}