import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  final int selectedIndex;
  final bool showLanguageDialog;
  final String? submittedCode;
  final bool showTourDetail;
  final bool? isOdd;
  final bool resetKeypad;

  const HomeInitial({
    this.selectedIndex = 0,
    this.showLanguageDialog = false,
    this.submittedCode,
    this.showTourDetail = false,
    this.isOdd,
    this.resetKeypad = false,
  });

  @override
  List<Object?> get props => [
    selectedIndex,
    showLanguageDialog,
    submittedCode,
    showTourDetail,
    isOdd,
    resetKeypad,
  ];

  HomeInitial copyWith({
    int? selectedIndex,
    bool? showLanguageDialog,
    String? submittedCode,
    bool? showTourDetail,
    bool? isOdd,
    bool? resetKeypad,
  }) {
    return HomeInitial(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      showLanguageDialog: showLanguageDialog ?? this.showLanguageDialog,
      submittedCode: submittedCode ?? this.submittedCode,
      showTourDetail: showTourDetail ?? this.showTourDetail,
      isOdd: isOdd,
      resetKeypad: resetKeypad ?? this.resetKeypad,
    );
  }
}
