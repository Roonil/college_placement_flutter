import 'package:college_placement_flutter/bloc/details_blocs/contact_details_events.dart';
import 'package:college_placement_flutter/models/contact_details.dart';
import 'package:college_placement_flutter/widgets/student_details_screen/contact_details/contact_details_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/details_blocs/contact_details_bloc.dart';
import '../../../bloc/details_blocs/contact_details_states.dart';
import '../details_subtitle.dart';

class ContactDetailsCard extends StatefulWidget {
  const ContactDetailsCard({super.key, required this.expansionTileController});
  final ExpansionTileController expansionTileController;

  @override
  State<ContactDetailsCard> createState() => _ContactDetailsCardState();
}

class _ContactDetailsCardState extends State<ContactDetailsCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  String? previousEmailAddress,
      previousPhoneNumber,
      previousAddressLine2,
      previousAddressLine1,
      previousState,
      previousCity,
      previousPinCode,
      previousCountry;

  bool shouldShowButtons = false;

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

          previousEmailAddress = emailAddressController.text.trim();
          previousPhoneNumber = phoneNumberController.text.trim();
          previousAddressLine2 = addressLine2Controller.text.trim();
          previousAddressLine1 = addressLine1Controller.text.trim();
          previousState = stateController.text.trim();
          previousCity = cityController.text.trim();
          previousPinCode = pinCodeController.text.trim();
          previousCountry = countryController.text.trim();
        } else if (state is UpdatedContactDetailsState) {
          previousEmailAddress = emailAddressController.text.trim();
          previousPhoneNumber = phoneNumberController.text.trim();
          previousAddressLine2 = addressLine2Controller.text.trim();
          previousAddressLine1 = addressLine1Controller.text.trim();
          previousState = stateController.text.trim();
          previousCity = cityController.text.trim();
          previousPinCode = pinCodeController.text.trim();
          previousCountry = countryController.text.trim();
        }
      },
      buildWhen: (previous, current) =>
          (current is FetchedContactDetailsState ||
              current is ContactDetailsFetchFailedState ||
              current is FetchingContactDetailsState ||
              current is UpdatedContactDetailsState ||
              current is UpdatingContactDetailsState ||
              current is ContactDetailsUpdateFailedState) &&
          previous != current,
      builder: (context, state) {
        bool isEdited =
            previousEmailAddress != emailAddressController.text.trim() ||
                previousPhoneNumber != phoneNumberController.text.trim() ||
                previousAddressLine2 != addressLine2Controller.text.trim() ||
                previousAddressLine1 != addressLine1Controller.text.trim() ||
                previousState != stateController.text.trim() ||
                previousCity != cityController.text.trim() ||
                previousPinCode != pinCodeController.text.trim() ||
                previousCountry != countryController.text.trim();

        return Card(
          elevation: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Form(
              key: formKey,
              child: Card(
                margin: EdgeInsets.zero,
                child: ExpansionTile(
                  controller: widget.expansionTileController,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onExpansionChanged: (value) => setState(() {
                    shouldShowButtons = value;
                  }),
                  title: Text(
                    "Contact Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: DetailsSubtitle(
                    hasFetched: state is FetchedContactDetailsState,
                    hasUpdated: state is UpdatedContactDetailsState,
                    isFetching: state is FetchingContactDetailsState,
                    isUpdating: state is UpdatingContactDetailsState,
                    isEdited: isEdited,
                    onSaved: () {
                      formKey.currentState!.validate() && isEdited
                          ? BlocProvider.of<ContactDetailsBloc>(context).add(
                              UpdateContactDetailsEvent(
                                  //TODO: Sync Student details from logged in details
                                  studentID: "1",
                                  contactDetails: ContactDetails(
                                      emailAddress:
                                          emailAddressController.text.trim(),
                                      phoneNumber:
                                          phoneNumberController.text.trim(),
                                      addressLine2:
                                          addressLine2Controller.text.trim(),
                                      addressLine1:
                                          addressLine1Controller.text.trim(),
                                      state: stateController.text.trim(),
                                      city: cityController.text.trim(),
                                      pinCode: pinCodeController.text.trim(),
                                      country: countryController.text.trim())))
                          : null;
                    },
                    onUndo: () {
                      setState(() {
                        emailAddressController.text =
                            previousEmailAddress ?? "";
                        phoneNumberController.text = previousPhoneNumber ?? "";
                        addressLine1Controller.text =
                            previousAddressLine1 ?? "";
                        addressLine2Controller.text =
                            previousAddressLine2 ?? "";
                        stateController.text = previousState ?? "";
                        cityController.text = previousCity ?? "";
                        pinCodeController.text = previousPinCode ?? "";
                        countryController.text = previousCountry ?? "";
                      });
                    },
                    shouldShowButtons: shouldShowButtons,
                  ),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state is FetchingContactDetailsState
                            ? Skeletonizer(
                                effect: ShimmerEffect(
                                    baseColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.5)),
                                child: ContactDetailsInputs(
                                  emailAddressController:
                                      emailAddressController,
                                  phoneNumberController: phoneNumberController,
                                  addressLine1Controller:
                                      addressLine1Controller,
                                  addressLine2Controller:
                                      addressLine2Controller,
                                  stateController: stateController,
                                  cityController: cityController,
                                  pinCodeController: pinCodeController,
                                  countryController: countryController,
                                  isEdited: false,
                                  inputsEnabled: true,
                                  formKey: formKey,
                                  onChanged: (_) {},
                                ))
                            : ContactDetailsInputs(
                                emailAddressController: emailAddressController,
                                phoneNumberController: phoneNumberController,
                                addressLine1Controller: addressLine1Controller,
                                addressLine2Controller: addressLine2Controller,
                                stateController: stateController,
                                cityController: cityController,
                                pinCodeController: pinCodeController,
                                countryController: countryController,
                                isEdited: isEdited,
                                inputsEnabled:
                                    state is! UpdatingContactDetailsState,
                                formKey: formKey,
                                onChanged: (_) => setState(() {}),
                              )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
