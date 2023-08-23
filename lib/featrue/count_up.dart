class CountUp {
  int increment(int count) {
    count++;
    return count;
  }

  int decrement(int count) {
    count--;
    if (count < 0) {
      count = 0;
    }
    return count;
  }

  int resetCount(int count) {
    count = 0;
    return count;
  }
}
