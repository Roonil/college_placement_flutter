import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_details_bloc.dart';
import '../bloc/contact_details_states.dart';

class ContactDetailsCard extends StatefulWidget {
  const ContactDetailsCard({super.key, required this.expansionTileController});
  final ExpansionTileController expansionTileController;

  @override
  State<ContactDetailsCard> createState() => _ContactDetailsCardState();
}

class _ContactDetailsCardState extends State<ContactDetailsCard> {
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactDetailsBloc, ContactDetailsState>(
      listenWhen: (previous, current) =>
          previous is FetchingContactDetailsState &&
          current is FetchedContactDetailsState,
      listener: (context, state) {
        if (state is FetchedContactDetailsState) {
          emailAddressController.text = state.contactDetails.emailAddress;
          phoneNumberController.text = state.contactDetails.phoneNumber;
          addressLine1Controller.text = state.contactDetails.addressLine1;
          addressLine2Controller.text = state.contactDetails.addressLine2;
          stateController.text = state.contactDetails.state;
          cityController.text = state.contactDetails.city;
          pinCodeController.text = state.contactDetails.pinCode;
          countryController.text = state.contactDetails.country;
        }
      },
      buildWhen: (previous, current) =>
          (previous is FetchingContactDetailsState &&
              current is FetchedContactDetailsState) ||
          (previous is FetchingContactDetailsState &&
              current is ContactDetailsFetchFailedState),
      builder: (context, state) => Card(
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Card(
            margin: EdgeInsets.zero,
            child: ExpansionTile(
                controller: widget.expansionTileController,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(
                  "Contact Details",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          state is FetchingContactDetailsState
                              ? Icons.timer
                              : Icons.check_circle,
                          color: state is FetchingContactDetailsState
                              ? Colors.amber
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(state is FetchedContactDetailsState
                          ? "Details Up-to-Date"
                          : "Fetching Details")
                    ],
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state is FetchingContactDetailsState
                        ? const CircularProgressIndicator()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  controller: emailAddressController,
                                  textInputAction: TextInputAction.next,
                                  validator: (email) => EmailValidator.validate(
                                          email ?? "")
                                      ? null
                                      : "Please enter a valid Email Address",
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(8),
                                      label: const Text("Email Address"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  validator: (phoneNumber) => phoneNumber ==
                                              null ||
                                          phoneNumber.length != 10 ||
                                          phoneNumber
                                              .contains(RegExp(r'[a-z]')) ||
                                          phoneNumber.contains(RegExp(r'[A-Z]'))
                                      ? "Please enter a valid Phone Number"
                                      : null,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(8),
                                      label: const Text("Phone Number"),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      flex: 7,
                                      child: TextFormField(
                                        controller: addressLine1Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: (addressLine1) =>
                                            addressLine1 == null ||
                                                    addressLine1.length < 3
                                                ? "Please enter a valid Address"
                                                : null,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(8),
                                            label: const Text("Address Line 1"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    const Spacer(),
                                    Flexible(
                                      flex: 7,
                                      child: TextFormField(
                                        controller: addressLine2Controller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(8),
                                            label: const Text("Address Line 2"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      flex: 7,
                                      child: TextFormField(
                                        controller: stateController,
                                        textInputAction: TextInputAction.next,
                                        validator: (state) => state == null ||
                                                state.length < 3 ||
                                                state.contains(RegExp(r'[0-9]'))
                                            ? "Please enter a valid State"
                                            : null,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(8),
                                            label: const Text("State"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    const Spacer(),
                                    Flexible(
                                      flex: 7,
                                      child: TextFormField(
                                        controller: cityController,
                                        textInputAction: TextInputAction.next,
                                        validator: (city) => city == null ||
                                                city.length < 3 ||
                                                city.contains(RegExp(r'[0-9]'))
                                            ? "Please enter a valid City Name"
                                            : null,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(8),
                                            label: const Text("City"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      flex: 7,
                                      child: TextFormField(
                                        controller: pinCodeController,
                                        maxLength: 6,
                                        buildCounter: (context,
                                                {required currentLength,
                                                required isFocused,
                                                maxLength}) =>
                                            null,
                                        textInputAction: TextInputAction.next,
                                        validator: (pinCode) => pinCode ==
                                                    null ||
                                                pinCode.length != 6 ||
                                                !pinCode.contains(
                                                    RegExp(r'[0-9]')) ||
                                                pinCode.contains(
                                                    RegExp(r'[a-z]')) ||
                                                pinCode
                                                    .contains(RegExp(r'[A-Z]'))
                                            ? "Please enter a valid Pin Code"
                                            : null,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(8),
                                            label: const Text("Pin Code"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    const Spacer(),
                                    Flexible(
                                      flex: 7,
                                      child: TextFormField(
                                        controller: countryController,
                                        textInputAction: TextInputAction.next,
                                        validator: (country) => country ==
                                                    null ||
                                                country.length < 3 ||
                                                country
                                                    .contains(RegExp(r'[0-9]'))
                                            ? "Please enter a valid Country Name"
                                            : null,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(8),
                                            label: const Text("Country"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
