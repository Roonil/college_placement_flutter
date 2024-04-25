class Student {
  final int id;
  final String universityEmail, firstName, lastName, uID;
  String token = "";

  Student(
      {required this.id,
      required this.universityEmail,
      required this.firstName,
      required this.lastName,
      required this.uID,
      required this.token});
}
