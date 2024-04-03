class Company {
  final String name,
      driveID,
      driveType,
      timeLeft,
      imageURL,
      startedAtTime,
      details,
      eligibilityCriteria,
      dateOfDrive,
      jobProfile,
      location,
      package,
      bond;
  final List<String> roles, process;
  final int numRegistrations;
  final bool hasRegistered;

  Company(
      {required this.name,
      required this.driveID,
      required this.driveType,
      required this.timeLeft,
      required this.imageURL,
      required this.startedAtTime,
      required this.details,
      required this.eligibilityCriteria,
      required this.dateOfDrive,
      required this.jobProfile,
      required this.location,
      required this.package,
      required this.bond,
      required this.roles,
      required this.process,
      required this.numRegistrations,
      required this.hasRegistered});

  @override
  bool operator ==(Object other) {
    return other is Company &&
        other.runtimeType == runtimeType &&
        other.driveID == driveID;
  }

  @override
  int get hashCode => driveID.hashCode;
}
