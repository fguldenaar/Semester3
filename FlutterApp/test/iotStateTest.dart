import 'package:flutter_test/flutter_test.dart';

import '../lib/Models/IotStates.dart';

void main() {

  test('getCount tester', () {
    int testInt = 10;
    String testString = "test";
    final iotStates = IotStates(testString,testInt);

    expect(testInt, iotStates.getCount());

  });

  test('getState tester', () {
    int testInt = 10;
    String testString = "test";
    final iotStates = IotStates(testString,testInt);

    expect(testString, iotStates.getState());

  });

  test('getCount tester', () {
    int testInt = 10;
    String testString = "test";
    final iotStates = IotStates(testString,testInt);
    iotStates.increaseCount();

    expect(testInt, isNot(iotStates.getCount()));
    expect(testInt+1, iotStates.getCount());

  });
}