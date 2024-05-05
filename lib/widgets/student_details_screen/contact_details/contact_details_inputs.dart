import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ContactDetailsInputs extends StatelessWidget {
  final TextEditingController emailAddressController,
      phoneNumberController,
      addressLine1Controller,
      addressLine2Controller;

  final GlobalKey<FormState> formKey;
  final bool isEdited, inputsEnabled;
  final Function(String) onChanged;

  const ContactDetailsInputs(
      {super.key,
      required this.emailAddressController,
      required this.phoneNumberController,
      required this.addressLine1Controller,
      required this.addressLine2Controller,
      required this.onChanged,
      required this.isEdited,
      required this.inputsEnabled,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  enabled: inputsEnabled,
                  onChanged: onChanged,
                  controller: emailAddressController,
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
                  enabled: inputsEnabled,
                  onChanged: onChanged,
                  controller: phoneNumberController,
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
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    enabled: inputsEnabled,
                    onChanged: onChanged,
                    controller: addressLine1Controller,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    validator: (addressLine1) =>
                        addressLine1 == null || addressLine1.length < 3
                            ? "Please enter a valid Address"
                            : null,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        label: const Text("Current Address"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    enabled: inputsEnabled,
                    onChanged: onChanged,
                    controller: addressLine2Controller,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        label: const Text("Permanent Address"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
