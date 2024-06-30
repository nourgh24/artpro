class Details {
  final String title;
  final String imageUrl;
  final String authorImageUrl;
  final String time;
  bool favorited;

  Details({
    required this.title,
    required this.imageUrl,
    required this.authorImageUrl,
    required this.time,

    this.favorited=false,

  });
}


class AddPaintingLike{
  final String Like;
  AddPaintingLike({
    required this.Like,
  });
}

class AddPaintingDisLike{
  final String DisLike;
  AddPaintingDisLike({
    required this.DisLike,
  });
}


class AddPaintingFavourite{
  final String Favourite;
  AddPaintingFavourite({
    required this.Favourite,
  });
}


class AddArticleFavourite{
  final String Favourite;
  AddArticleFavourite({
    required this.Favourite,
  });
}


class AddPaintingComplaint{
  final String Description;
  AddPaintingComplaint({
    required this.Description,
  });
}