class IotStates{
  IotStates(this.IotState, this.StateCount);

  String IotState;
  int StateCount;

  String getState(){
    return IotState;
  }
  double getCount(){
    return StateCount.toDouble();
  }
  void increaseCount(){
    this.StateCount++;
  }

}