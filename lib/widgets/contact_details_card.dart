import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ContactDetailsCard extends StatelessWidget {
  const ContactDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Contact Details",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (email) => EmailValidator.validate(email ?? "")
                    ? null
                    : "Please enter a valid Email Address",
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    label: const Text("Email Address"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
                validator: (phoneNumber) => phoneNumber == null ||
                        phoneNumber.length != 10 ||
                        phoneNumber.contains(RegExp(r'[a-z]')) ||
                        phoneNumber.contains(RegExp(r'[A-Z]'))
                    ? "Please enter a valid Phone Number"
                    : null,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    label: const Text("Phone Number"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      validator: (addressLine1) =>
                          addressLine1 == null || addressLine1.length < 3
                              ? "Please enter a valid Address"
                              : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          label: const Text("Address Line 1"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          label: const Text("Address Line 2"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (state) => state == null ||
                              state.length < 3 ||
                              state.contains(RegExp(r'[0-9]'))
                          ? "Please enter a valid State"
                          : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          label: const Text("State"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (city) => city == null ||
                              city.length < 3 ||
                              city.contains(RegExp(r'[0-9]'))
                          ? "Please enter a valid City Name"
                          : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          label: const Text("City"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      maxLength: 6,
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              maxLength}) =>
                          null,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (pinCode) => pinCode == null ||
                              pinCode.length != 6 ||
                              !pinCode.contains(RegExp(r'[0-9]')) ||
                              pinCode.contains(RegExp(r'[a-z]')) ||
                              pinCode.contains(RegExp(r'[A-Z]'))
                          ? "Please enter a valid Pin Code"
                          : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          label: const Text("Pin Code"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (country) => country == null ||
                              country.length < 3 ||
                              country.contains(RegExp(r'[0-9]'))
                          ? "Please enter a valid Country Name"
                          : null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          label: const Text("Country"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
