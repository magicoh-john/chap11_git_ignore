package com.javalab.board.common;

/**
 * Before Advice
 * - AOP에서 부가적인 관심사를 정의하는 클래스로 특정 메소드 호출시 
 *   메소드 실행 전에 적용된다. 
 * - 여기에는 메소드 실행전에 실행될 메소드가 정의되어 있어야 한다.
 */
public class BeforeAdvice {

	public BeforeAdvice() {
		System.out.println("BeforeAdvice 생성자");
	}
	
	public void beforeLog() {
		System.out.println("[BeforeAdvice] 타겟 메소드 실행전에 로그를 남김 =============================");
	}
}
