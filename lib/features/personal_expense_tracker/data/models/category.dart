class Category {
  final String name;

  Category(this.name);

  // Additional methods (optional)
  Map<String, String> toJson() => {'name': name};

  factory Category.fromJson(Map<String, dynamic> json) => Category(json['name'] as String);

  // ... other methods (optional)

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Category && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
