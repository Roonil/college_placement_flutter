import 'package:intl/intl.dart';

import '../../dummy_data/filter_actions.dart';
import '../../models/company.dart';

class FilterFunctions {
  static final Set<FilterType> appliedFilters = {};
  static final Set<String> searchFields = {"Name"};
  static String sortByField = "Name";
  static int sortValue = 1;
  static bool showExpired = true;

  static Set<Company> searchCompanies(
      {required Set<Company> companies, required String searchString}) {
    final Set<Company> searchedCompanies = {};

    for (Company company in companies) {
      if (FilterFunctions.searchFields.contains('Name') &&
          company.name.toLowerCase().contains(searchString.toLowerCase())) {
        searchedCompanies.add(company);
      } else if (FilterFunctions.searchFields.contains('Description') &&
          company.details.toLowerCase().contains(searchString.toLowerCase())) {
        searchedCompanies.add(company);
      } else if (FilterFunctions.searchFields.contains('Roles')) {
        for (String role in company.roles) {
          if (role.toLowerCase().contains(searchString.toLowerCase())) {
            searchedCompanies.add(company);
          }
        }
      }
    }

    return sortCompanies(
        companies: searchedCompanies, sortCriteria: sortByField);
  }

  static Set<Company> toggleExpire(Set<Company> companies) {
    return showExpired
        ? companies
        : companies.where((company) => company.timeLeft >= 0).toSet();
  }

  static Set<Company> sortCompanies(
      {required Set<Company> companies, required String sortCriteria}) {
    final List<Company> companiesList = companies.toList();

    if (sortCriteria != sortByField) {
      sortByField = sortCriteria;
      sortValue = 1;
    }

    if (sortCriteria == 'Name') {
      companiesList
          .sort((Company a, Company b) => sortValue * a.name.compareTo(b.name));
    } else if (sortCriteria == "Registrations") {
      companiesList.sort((Company a, Company b) =>
          sortValue * a.numRegistrations.compareTo(b.numRegistrations));
    } else if (sortCriteria == "Date of Drive") {
      companiesList.sort((Company a, Company b) =>
          sortValue *
          DateFormat("dd/MM/yyyy")
              .parse(a.dateOfDrive)
              .compareTo(DateFormat("dd/MM/yyyy").parse(b.dateOfDrive)));
    } else if (sortCriteria == "Time Left") {
      companiesList.sort((Company a, Company b) =>
          sortValue * a.timeLeft.compareTo(b.timeLeft));
    } else if (sortCriteria == "Date of Creation") {
      companiesList.sort((Company a, Company b) =>
          sortValue * b.startedAtTime.compareTo(a.startedAtTime));
    }

    final Set<Company> sortedCompanies = companiesList.toSet();

    return toggleExpire(sortedCompanies);
  }

  static Set<Company> applyFilter(
      {required Set<Company> initialCompanies,
      required FilterType filterType}) {
    switch (filterType) {
      case FilterType.registeredForDrive:
        return initialCompanies
            .where((company) => company.hasRegistered)
            .toSet();
      case FilterType.unregisteredForDrive:
        return initialCompanies
            .where((company) => !company.hasRegistered)
            .toSet();
      case FilterType.clearRegisterType:
        return initialCompanies;

      case FilterType.onlineDriveType:
        return initialCompanies
            .where((company) =>
                company.driveType == "Online" || company.driveType == "Hybrid")
            .toSet();
      case FilterType.offlineDriveType:
        return initialCompanies
            .where((company) =>
                company.driveType == "Offline" || company.driveType == "Hybrid")
            .toSet();
      case FilterType.hybridDriveType:
        return initialCompanies
            .where((company) => company.driveType == "Hybrid")
            .toSet();
      case FilterType.clearDriveType:
        return initialCompanies;
      default:
        return initialCompanies;
    }
  }

  static Set<Company> applyFilters(
      {required FilterType filterType, required Set<Company> companies}) {
    if (appliedFilters.contains(filterType)) return {};
    {
      Set<Company> newlyFilteredCompanies = companies;

      switch (filterType) {
        case FilterType.unregisteredForDrive:
          appliedFilters.remove(FilterType.registeredForDrive);
          break;

        case FilterType.registeredForDrive:
          appliedFilters.remove(FilterType.unregisteredForDrive);
          break;

        case FilterType.clearRegisterType:
          appliedFilters.remove(FilterType.registeredForDrive);
          appliedFilters.remove(FilterType.unregisteredForDrive);
          break;

        case FilterType.onlineDriveType:
          appliedFilters.remove(FilterType.offlineDriveType);
          appliedFilters.remove(FilterType.hybridDriveType);
          break;

        case FilterType.offlineDriveType:
          appliedFilters.remove(FilterType.onlineDriveType);
          appliedFilters.remove(FilterType.hybridDriveType);
          break;

        case FilterType.hybridDriveType:
          appliedFilters.remove(FilterType.offlineDriveType);
          appliedFilters.remove(FilterType.onlineDriveType);
          break;

        case FilterType.clearDriveType:
          appliedFilters.remove(FilterType.onlineDriveType);
          appliedFilters.remove(FilterType.offlineDriveType);
          appliedFilters.remove(FilterType.hybridDriveType);
          break;

        default:
          break;
      }

      filterType != FilterType.clearRegisterType &&
              filterType != FilterType.clearDriveType
          ? appliedFilters.add(filterType)
          : null;

      appliedFilters.isEmpty ? newlyFilteredCompanies.addAll(companies) : null;
      for (FilterType appliedFilter in appliedFilters) {
        newlyFilteredCompanies = applyFilter(
            initialCompanies: newlyFilteredCompanies,
            filterType: appliedFilter);
      }

      return sortCompanies(
          companies: newlyFilteredCompanies, sortCriteria: sortByField);
    }
  }
}
