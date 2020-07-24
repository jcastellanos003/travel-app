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
        id: data[0]['_id'],
        location: data[0]['location'],
        title: data[0]['title'],
        description: data[0]['description'],
        address: data[0]['address'],
        photo: data[0]['photo'],
        isActive: data[0]['isActive'],
        created: data[0]['created']);
  }

  @override
  List<Object> get props =>
      [id, location, title, description, address, photo, isActive, created];
}
