import '../../dummy_data/filter_actions.dart';
import '../../models/company.dart';

class FilterFunctions {
  static final Set<FilterType> appliedFilters = {};

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
                company.driveType == "Online" ||
                company.driveType == "Online/On Campus")
            .toSet();
      case FilterType.offlineDriveType:
        return initialCompanies
            .where((company) =>
                company.driveType == "On Campus" ||
                company.driveType == "Online/On Campus")
            .toSet();
      case FilterType.hybridDriveType:
        return initialCompanies
            .where((company) => company.driveType == "Online/On Campus")
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

      return newlyFilteredCompanies;
    }
  }
}
