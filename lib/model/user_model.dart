import './image_model.dart';
import './username_model.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String nat;
  final Username name;
  final Imageuser picture;

  User({    
    required this.gender,
    required this.email,
    required this.phone,
    required this.nat,
    required this.name,
    required this.picture
  });
}
