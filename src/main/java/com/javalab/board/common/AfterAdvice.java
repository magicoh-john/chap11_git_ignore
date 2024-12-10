package com.javalab.board.common;

/**
 * After Advice
 * - 타겟 메소드(포인트컷) 실행 후에 적용되는 메소드를 갖고 있는 어드바이스
 *
 */
public class AfterAdvice {
	
	public AfterAdvice() {
		
	}
	// 포인트컷 호출시 해당 메소드 실행 후에 이 메소드가 실행된다.
	public void finallyLog() {
		System.out.println("[AfterAdvice] 타겟메소드(포인트컷) 메소드 실행후 로그를 남김 ====================");
	}

}
