public with sharing class Calculator {
    public Calculator() {
		
    }
    public static Integer Add(Integer num1, Integer num2){
        return num1 + num2;
    }

    public static Integer Multiply(Integer num1, Integer num2){
        Integer total = 0;
        for(Integer i = 0; i < num1; i++)
        {
            total = Add(total, num2);
        }

        return total;
    }

    public static Integer Divide(Integer num1, Integer num2){
        if(num2 == 0)
            return 0;
        Integer count = 0;
        Integer negNum2 = -num2;
        while(num1 > 0){
            num1 = Add(num1, negNum2);
            count++;
        }
        return count;
    }

    public static Integer Mod(Integer num1, Integer num2){
        while(num1 >= num2){
            num1 -= num2;
        }
        return num1;
    }
}