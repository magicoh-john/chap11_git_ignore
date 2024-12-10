package com.javalab.board.common;

import org.aspectj.lang.JoinPoint;

/**
 * After Throwing Advice
 * - 타겟 메소드 실행중 예외가 발생했을 때 수행되는 어드바이스 클래스
 */
public class AfterThrowingAdvice {
	
	public AfterThrowingAdvice() {}
	
	/*
	 * 타겟 메소드 실행중 예외가 발생하면 이 메소드가 호출된다.
	 * 이 때 Exception exceptObj 로 인해서 발생한 예외가 전달된다.
	 */
	public void exceptionLog(JoinPoint jp, Exception exceptObj){
		System.out.println("[AfterThrowingAdvice 예외처리] 타겟메소드 수행 중 예외 발생 =====================================");
	}		

}
