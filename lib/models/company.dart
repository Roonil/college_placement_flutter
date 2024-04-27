class Company {
  final String name,
      driveType,
      timeLeft,
      startedAtTime,
      details,
      eligibilityCriteria,
      dateOfDrive,
      jobProfile,
      location,
      package,
      bond;

  final String? imageURL;
  final List<String> roles, process;
  final int numRegistrations, companyID;
  final bool hasRegistered;

  Company(
      {required this.name,
      required this.companyID,
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
        other.companyID == companyID;
  }

  @override
  int get hashCode => companyID.hashCode;
}
