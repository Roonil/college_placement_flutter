import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/details_blocs/contact_details_bloc.dart';
import '../../../bloc/details_blocs/contact_details_events.dart';
import '../../../models/contact_details.dart';

class ContactDetailsInputs extends StatelessWidget {
  final TextEditingController emailAddressController,
      phoneNumberController,
      addressLine1Controller,
      addressLine2Controller,
      stateController,
      cityController,
      pinCodeController,
      countryController;

  final GlobalKey<FormState> formKey;
  final bool isEdited, inputsEnabled;
  final Function(String) onChanged;

  const ContactDetailsInputs(
      {super.key,
      required this.emailAddressController,
      required this.phoneNumberController,
      required this.addressLine1Controller,
      required this.addressLine2Controller,
      required this.stateController,
      required this.cityController,
      required this.pinCodeController,
      required this.countryController,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 7,
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
                            label: const Text("Address Line 1"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 7,
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: addressLine2Controller,
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
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: stateController,
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
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: cityController,
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
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: pinCodeController,
                        maxLength: 6,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            null,
                        textInputAction: TextInputAction.next,
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
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: countryController,
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            enabled: inputsEnabled,
            controller: countryController,
            onChanged: onChanged,
            onFieldSubmitted: (value) =>
                formKey.currentState!.validate() && isEdited
                    ? BlocProvider.of<ContactDetailsBloc>(context)
                        .add(UpdateContactDetailsEvent(
                            studentID: "1",
                            contactDetails: ContactDetails(
                              emailAddress: emailAddressController.text.trim(),
                              phoneNumber: phoneNumberController.text.trim(),
                              addressLine1: addressLine1Controller.text.trim(),
                              addressLine2: addressLine2Controller.text.trim(),
                              state: stateController.text.trim(),
                              city: cityController.text.trim(),
                              pinCode: pinCodeController.text.trim(),
                              country: countryController.text.trim(),
                            )))
                    : null,
            textInputAction: TextInputAction.go,
            validator: (country) => country == null ||
                    country.contains(RegExp(r'[0-9]')) ||
                    country.length < 3
                ? "Please enter a valid country"
                : null,
            decoration: InputDecoration(
                errorMaxLines: 4,
                contentPadding: const EdgeInsets.all(8),
                label: const Text("country"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
      ],
    );
  }
}
