class ContactDetails {
  final String emailAddress,
      phoneNumber,
      addressLine1,
      addressLine2,
      state,
      city,
      pinCode,
      country;

  ContactDetails(
      {required this.emailAddress,
      required this.phoneNumber,
      required this.addressLine1,
      required this.addressLine2,
      required this.state,
      required this.city,
      required this.pinCode,
      required this.country});
}
