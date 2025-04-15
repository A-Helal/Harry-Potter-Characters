class Character {
  final String charId;
  final String charName;
  final String actorName;
  final bool status;
  final String gender;
  final String img;

  Character({
    required this.charId,
    required this.charName,
    required this.actorName,
    required this.status,
    required this.gender,
    required this.img,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      charId: json['id'] as String,
      charName: json['name'] as String,
      actorName: json['actor'] as String,
      status: json['alive'] ?? false,
      gender: json['gender'] as String,
      img: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': charId,
      'name': charName,
      'actor': actorName,
      'alive': status,
      'gender': gender,
      'image': img,
    };
  }
}
