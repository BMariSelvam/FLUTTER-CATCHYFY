//DashBoardNewLaunch
class NewLaunchList {
  final String image;
  final String name;
  final String weight;
  final String rupees;

  NewLaunchList(
      {required this.image,
      required this.name,
      required this.weight,
      required this.rupees});
}

//DashBoardCategoryHeadGrid
class CategoryHeadGrid {
  final String image;
  final String name;

  CategoryHeadGrid({
    required this.image,
    required this.name,
  });
}

//DashBoardSubCategoryGrid
class SubCategoryGrid {
  final String name;
  final String image;

  SubCategoryGrid({
    required this.name,
    required this.image,
  });
}

//DashBoardOfferList
class OfferList {
  final String image;
  final String mainLine;
  final String subLine;

  OfferList({
    required this.image,
    required this.mainLine,
    required this.subLine,
  });
}

//Category
class Category {
  final String image;
  final String text;
  final List<SubCategory> item;

  Category({
    required this.image,
    required this.text,
    required this.item,
  });
}

//SubCategory
class SubCategory {
  final String image;
  final String name;
  final String quantity;
  final String amount;

  SubCategory({
    required this.image,
    required this.name,
    required this.quantity,
    required this.amount,
  });
}

class Grid {
  final String name;
  final String image;

  Grid({
    required this.name,
    required this.image,
  });
}

class Banners {
  final String name;
  final String image;
  final String offer;

  Banners({
    required this.name,
    required this.image,
    required this.offer,
  });
}

class SubGrid {
  final String name;
  final String image;
  final String offer;

  SubGrid({
    required this.name,
    required this.image,
    required this.offer,
  });
}
