class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.itensCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int itensCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'https://manualdousuario.net/wp-content/uploads/2020/06/Escrit%C3%B3rio-em-casa-do-Gabriel-Arruda.jpg',
      title: 'Escritorio',
      itensCount: 24,
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'https://gizmodo.uol.com.br/wp-content/blogs.dir/8/files/2020/07/macbook-caitlin-mcgarry-800x450.jpg',
      title: 'Computadores',
      itensCount: 22,
      money: 18,
      rating: 4.6,
    ),
    Category(
      imagePath: 'https://i.zst.com.br/images/as-5-melhores-impressoras-multifuncionais-em-2019-photo161771907-44-1c-31.jpg',
      title: 'Impressoras',
      itensCount: 24,
      money: 25,
      rating: 4.3,
    ),
  ];

}
