abstract class AppNewsStates {}

class AppNewsInitialState extends AppNewsStates {}

class AppNewsNavBarState extends AppNewsStates {}

class AppNewsDetBusinessDataState extends AppNewsStates {}

class AppNewsDetBusinessErrorDataState extends AppNewsStates {
  final String error;
  AppNewsDetBusinessErrorDataState(this.error);
}

class AppNewsDetBusinessLoadingState extends AppNewsStates {}

class AppNewsDetSportDataState extends AppNewsStates {}

class AppNewsDetSportErrorDataState extends AppNewsStates {
  final String error;
  AppNewsDetSportErrorDataState(this.error);
}

class AppNewsDetSportLoadingState extends AppNewsStates {}

class AppNewsDetScienceDataState extends AppNewsStates {}

class AppNewsDetScienceErrorDataState extends AppNewsStates {
  final String error;
  AppNewsDetScienceErrorDataState(this.error);
}

class AppNewsDetScienceLoadingState extends AppNewsStates {}

class AppChangModeState extends AppNewsStates {}

class AppNewsSearchDataState extends AppNewsStates {}

class AppNewsSearchErrorDataState extends AppNewsStates {
  final String error;
  AppNewsSearchErrorDataState(this.error);
}

class AppNewsSearchLoadingState extends AppNewsStates {}
