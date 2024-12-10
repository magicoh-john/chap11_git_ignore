package com.javalab.board.common;

import org.aspectj.lang.ProceedingJoinPoint;

/**
 * Around Advice
 * - 포인트컷 메소드 실행 전과 후에 모두 실행되는 클래스
 */
public class AroundAdvice {
	
	public AroundAdvice() {}
	
	/*
	 * ProceedingJoinPoint 객체를 메소드의 매개변수로 받아서 
	 * 타겟 메소드를 알아낼 수 있으며 관련된 정보도 알아낼 수 있다.
	 * 이게 없으면 타겟 메소드를 호출할 수 없다.
	 */
	public Object aroundLog(ProceedingJoinPoint pjp) throws Throwable{
		System.out.println("[AroundAdvice - Before] : 타겟 메소드 수행 전에 실행 ==========================");
		
		// 인자로 주어진 ProceedingJoinPoint 통해서 타겟 메소드 호출 가능.
		// 다음 코드를 실행하지 않으면 타겟 메소드(핵심 메소드) 호출 불가함.
		Object returnObj = pjp.proceed();
		
		System.out.println("[AroundAdvice - After] : 타겟 메소드 수행 후에 실행 ==========================");		
		return returnObj;
	}	

}
