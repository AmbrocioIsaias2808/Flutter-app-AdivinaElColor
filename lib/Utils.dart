import 'dart:math';

int randomNumber(int min, int max){
  Random rnd = new Random();
  return min + rnd.nextInt(max - min);
}