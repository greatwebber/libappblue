class CategoryBook {
  String? bookId;
  String? bookName;
  String? authorName;
  String? publicationName;
  String? bookPages;
  String? bookQuatity;
  String? bookCategory;

  CategoryBook(
      this.bookId,
      this.bookName,
      this.authorName,
      this.publicationName,
      this.bookPages,
      this.bookQuatity,
      this.bookCategory);

  CategoryBook.fromJson(Map<String, dynamic> json) {
    bookId = json['BookID'];
    bookName = json['BookName'];
    authorName = json['AuthorName'];
    publicationName = json['PublicationName'];
    bookPages = json['BookPages'];
    bookQuatity = json['BookQuantity'];
    bookCategory = json['CategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookId'] = bookId;
    data['bookName'] = bookName;
    data['bookQuantity'] = bookQuatity;
    data['authorName'] = authorName;
    data['publicationName'] = publicationName;
    data['bookPages'] = bookPages;
    data['bookCategory'] = bookCategory;

    return data;
  }
}
