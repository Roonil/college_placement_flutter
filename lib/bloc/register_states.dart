abstract class RegisterState {
  final bool isLoading;

  final Exception? authError;

  const RegisterState({required this.isLoading, required this.authError});
}

class InitialState extends RegisterState {
  bool personalDetailsEdited,
      contactDetailsEdited,
      undergraduateDetailsEdited,
      intermediateDetailsEdited,
      matricDetailsEdited;

  InitialState(
      {required super.isLoading,
      required super.authError,
      required this.personalDetailsEdited,
      required this.contactDetailsEdited,
      required this.undergraduateDetailsEdited,
      required this.intermediateDetailsEdited,
      required this.matricDetailsEdited});
}
