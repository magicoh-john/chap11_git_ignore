package com.javalab.board.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * ajax 요청에서 서버의 처리 결과 상태와 처리결과 값 또는 메시지를 함께 가지고 있는 객체
 * @author magic
 *
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@ToString
public class ResponseVo {
	private boolean success; // 처리 결과(true/false) 중복/중복이 아닌지
	private String message; // 구체적인 처리 결과 메시지
}
