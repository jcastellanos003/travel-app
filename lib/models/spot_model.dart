class Spot {
  final String id;
  final List<dynamic> location;
  final String title;
  final String description;
  final String address;
  final String photo;
  final bool isActive;
  final String created;

  const Spot(
      {this.id,
      this.location,
      this.title,
      this.description,
      this.address,
      this.photo,
      this.isActive,
      this.created});

  factory Spot.fromJson(Map<String, dynamic> data) {
    return Spot(
        id: data['_id'],
        location: data['location'],
        title: data['title'],
        description: data['description'],
        address: data['address'],
        photo: data['photo'],
        isActive: data['isActive'],
        created: data['created']);
  }

  @override
  List<Object> get props =>
      [id, location, title, description, address, photo, isActive, created];
}
