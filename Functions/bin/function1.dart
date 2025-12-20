import 'package:function1/function1.dart' as function1;

void main() {
  print('Hello world');
  sum();
  sumParams(10, 20);
  print(sumReturn(11, 11));
  sumReq(num1: 100, num2: 200);
  sumOpti(num1: 10, num2: 10,num3: 1);
}




void sum()
{
  print("${1+2}");
}

void sumParams(int a, int b)
{
  print("${a+b}");
}


int sumReturn(int a,int b)
{
  return a+b;
}

void sumReq({required int num1,required int num2})
{
  print(num1+num2);
}
void sumOpti({required int num1,required int num2,int num3 = 0})
{
  print(num1+num2+num3);
}

