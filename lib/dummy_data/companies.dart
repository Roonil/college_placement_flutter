import '../models/company.dart';

final Set<Company> companies = {
  Company(
      companyID: "1",
      name: "Hogwarts",
      driveType: "Online",
      startedAtTime: "8 hours",
      roles: ['DADA Teacher', 'Muggle Studies Teacher'],
      timeLeft: "10 days",
      numRegistrations: 20,
      imageURL: 'assets/images/hogwarts.jpg',
      bond: "N/A",
      dateOfDrive: "31 Oct 1991",
      details: "Voldemort has arrived!",
      eligibilityCriteria: "Be a Wizard/Witch",
      jobProfile: "Profile",
      location: "Scotland",
      package: "800 Galleon per year",
      process: ["Interview"]),
  Company(
      companyID: "2",
      name: "Ministry of Magic",
      driveType: "Off Campus",
      startedAtTime: "12 hours",
      roles: ['Auror'],
      timeLeft: "2 days",
      numRegistrations: 10,
      imageURL: 'assets/images/Ministry_of_Magic.png',
      bond: "N/A",
      dateOfDrive: "31 Oct 1991",
      details: "Voldemort is not back!",
      eligibilityCriteria: "Don't be a Mudblood",
      jobProfile: "Profile",
      location: "Scotland",
      package: "1300 Galleon per year",
      process: ["Should talk to Lucius Malfoy for the process"])
};
