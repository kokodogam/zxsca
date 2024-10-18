package com.human.web.util;

import java.util.ArrayList;
import java.util.List;

public class Conversion {
	//double형의 입력값을 소수점 이하 자리를 버리고 int값으로 반환하는 메소드
	public static int doubleToInt(double d) {
		return (int)d;
	}
	
	//가변길이 매개변수(varargs)로 입력되는 문자열을 문자열 배열로 반환하는 메소드
	public static String[] stringsToArray(String ... args) {
		String [] result = new String[args.length];
		for(int i=0; i<args.length; i++) {
			result[i] = args[i];
		}
		return result;
	}
	
	//가변길이 매개변수로 입력된 Person객체를 List<Person>객체로 반환하는 메소드
	public static List<Person> personsToList(){
		List<Person> result = new ArrayList<>();
		result.add(new Person("이순신", 30));
		result.add(new Person("김유신", 40));
		return result;
	}
}
