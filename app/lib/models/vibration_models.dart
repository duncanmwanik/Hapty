// list of vibration pattern objects
class VibrationPatternObject {
  const VibrationPatternObject({required this.patternNumber, required this.patternImage});
  final int patternNumber;
  final String patternImage;
}

List<VibrationPatternObject> vibrationPatternList = [
  const VibrationPatternObject(patternNumber: 0, patternImage: 'assets/images/homie300.png'),
  const VibrationPatternObject(patternNumber: 1, patternImage: 'assets/images/homie300.png'),
  const VibrationPatternObject(patternNumber: 2, patternImage: 'assets/images/homie300.png'),
  const VibrationPatternObject(patternNumber: 3, patternImage: 'assets/images/homie300.png'),
];
