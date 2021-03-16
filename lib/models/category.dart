class Category {
  int id;
  String name;

  Category(this.id, this.name);

  static List<Category> getCategories() {
    return <Category>[
      Category(1, 'Market'),
      Category(2, 'Giyim'),
      Category(3, 'Diğer'),
      Category(4, 'Sigara'),
      Category(5, 'Kredi Kartı'),
    ];
  }
}
