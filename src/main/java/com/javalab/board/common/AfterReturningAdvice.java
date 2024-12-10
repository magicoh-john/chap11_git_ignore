package com.javalab.board.common;

import org.aspectj.lang.JoinPoint;

/**
 * AfterReturning Advice
 * - 타겟 메소드(포인트컷)가 정상적으로 실행된 후에 호출되는 어드바이스
 *
 */
public class AfterReturningAdvice {
	public AfterReturningAdvice() {}
	
	/*
	 * JoinPoint jp : 클라이언트가 호출한 타겟(비즈니스) 메소드 정보를 가지고 있는 객체
	 * Object returnObj : 바인드 변수라고 하며 타겟 메소드가 실행되고 반환된 값을 가지고 있는 객체
	 */
	public void afterLog(JoinPoint jp, Object returnObj) {

		System.out.println("[AfterReturningAdvice 사후처리] 타겟 메소드 수행 후에 실행 ==================================");
		String method = jp.getSignature().getName();
		System.out.println("[사후 처리] " + method + "() 메소드 리턴값 : " + returnObj.toString());
	}	

}
