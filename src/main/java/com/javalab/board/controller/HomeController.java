package com.javalab.board.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javalab.board.service.BoardService;
import com.javalab.board.vo.BoardVo;

import lombok.RequiredArgsConstructor;

/**
 * 컨트롤러
 * - 스프링 MVC의 주요 구성요소
 * - 사용자의 요청을 처리하고 응답을 반환하는 컨트롤러 클래스
 * - @Controller : 스프링에서 컨트롤러로 사용할 수 있도록 빈으로 등록
 * - 생성자가 한 개 뿐이면 @Autowired 어노테이션 생략 가능
 *  - 생성자가 한 개 뿐이면 스프링이 자동으로 주입해준다.
 *  - 이건 스프링 버전 4.3부터 가능하다.
 */
@Controller
//@RequiredArgsConstructor // 롬복의 @RequiredArgsConstructor 어노테이션을 통한 의존성 주입, 생성자 자동 생성
public class HomeController {
	// 스프링 컨테이너로부터 BoardService Type의 빈을 찾아서 주입해준다.
	// 타입은 인터페이스이지만 실제 구현체인 BoardServiceImpl 객체가 주입된다.
	
	// [1] @Autowired 통한 의존성 주입	
	//@Autowired	// 스프링컨테이너에서 BoardService 타입의 구현체를 찾아서 주입하려고 시도한다.
	
	// [2] @Autowired + @Qualifier("service2")
	// @Autowired
	//@Qualifier("service2")	// 만약 같은 타입의 빈이 두 개 이상이라면 "service2"라는 이름으로 주입시도
	
	// [3] @Resource(name="주입할빈이름")
	// 위의 두 줄을 한줄로 변경 @Resuource(name="service2")로 대체할 수 있다.
	//@Resource(name="service2")
	//private BoardService service;
	
	// [4] 생성자를 통한 의존성 주입, 이때는 필드를 final로 설정, annotation 불필요
	// 스프링 4.3 버전부터 생성자가 한 개이면 @Autowired없이 의존성이 주입된다.
	private final BoardService service;
	// 4.1 생성자의 매개변수로 주입받을 의존성을 명시
	public HomeController(BoardService service) {
		this.service = service;
	}
	
	// [5] 롬복의 @RequiredArgsConstructor 어노테이션을 통한 의존성 간편 주입
	// 롬복의 @RequiredArgsConstructor 어노테이션을 통해 생성자를 만들어서 의존성 주입을 간편하게 처리할 수 있다.
	
	
	/**
	 * @RequestMapping
	 * - 사용자로부터 요청되는 url을 지정하는 기능
	 * value="/" : 서비스가 최초로 구동될 호출되는 url
	 * method : 사용자 요청한 요청 방식
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		return "index";
	}
	
}
