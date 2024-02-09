class User {
  const User({
    required this.name,
    required this.email,
    required this.password,
    this.address,
    this.phone,
    this.profilePictureUrl,
  });
  final String name;
  final String email;
  final String password;
  final String? address;
  final String? phone;
  final String? profilePictureUrl;
}
