package com.javalab.board.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javalab.board.dto.Criteria;
import com.javalab.board.repository.BoardRepository;
import com.javalab.board.vo.BoardVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 게시판 서비스 클래스
 * 
 * @Service : 서비스 레이어에서 사용할 스프링 빈으로 등록
 */
@Service
@RequiredArgsConstructor // 생성자 자동으로 만들어준다.
@Slf4j
public class BoardServiceImpl implements BoardService {
	// @Autowired : 스프링에서 지정한 타입의 빈을 찾아서 주입
	// BoardRepository 타입의 빈을 찾아서 주입해줌.
	// 필드, 생성자 이존성 주입시 필드를 final하는 이유는 불변성을 지키기 위함이다.
	private final BoardRepository repository;

	// 생성자 의존성이 좋은 점은 이 객체 생성시 타입을 체크해준다. 안정성 보장
	// public BoardServiceImpl(BoardRepository repository) {
	// this.repository = repository;
	// }

	/*
	 * 게시물 조회
	 */
	@Override
	public List<BoardVo> getBoardList() {
		List<BoardVo> boardList = repository.getBoardList();
		return boardList;
	}
	/*
	 * 페이징, 검색 기능이 추가된 메소드 호출
	 */
	@Override
	public List<BoardVo> getBoardListPaging(Criteria cri) {
		List<BoardVo> boardList = repository.getBoardListPaging(cri);
		return boardList;
	}
	
	
	// 게시물 내용 보기
	@Override
	public BoardVo getBoard(int boardNo) {
        // 조회수 증가
        repository.increaseHitNo(boardNo);
        // 게시물 조회
		BoardVo boardVo = repository.getBoard(boardNo);
		return boardVo;
	}
	
	// 게시물 저장
//	@Override
//	public int insertBoard(BoardVo boardVo) {
//		return repository.insertBoard(boardVo);
//	}
	
	/*
	 * 게시물 저장[기본, AfterThrowingAdvice 테스트]
	 * 예외 발생시 여기서 직접 처리 안하고 있기 때문에 컨트롤러의 이메소드를 호출한 곳으로 예외가 던져진다.
	 * 컨트롤러의 메소드에서 처리하면 예외가 잡히고 그렇지 않으면 오류메시지 사용자에게 보여진다.  
	 */
	/*
	@Override
	public int insertBoard(BoardVo boardVo) throws RuntimeException{
		 // 첫 번째 정상적인 호출
	    repository.insertBoard(boardVo);
	    
	    // 강제 예외 발생
	    if (true) {
	        throw new RuntimeException("테스트를 위한 강제 예외 발생");
	    }
	    // if (true) 조건으로 인해 항상 throw new RuntimeException이 실행되므로, 
	    // 사실상 return 1;에 도달하지 않습니다. 그러나 컴파일러는 조건문 실행 여부를 알지 못하고 
	    // 모든 코드 경로에서 반환값이 있어야 한다고 판단합니다. 그래서 명시적으로 1을 반환함.
	    return 1;
	}	
	*/
	/*
	 * 트랜잭션 테스트
	 * - 순서 : 게시물 저장 작업 -> 강제로 예외발생 -> 게시물 저장 작업
	 * @Transactional : 여러개의 SQL을 하나의 작업 단위로 묶어서 실행(All or Nothing)
	 *  - @Transactional 어노테이션을 메소드에 사용(가장 우선 순위가 높다)
	 *  - @Transactional 어노테이션을 클래스 차원 적용(두 번째 우선 순위가 높다)
	 *  - @Transactional 어노테이션을 인터페이스 차원 적용(가장 우선 순위가 낮다)
	 * 트랜잭션
	 *  - 이 메소드가 호출되는 시점에 트랜잭션 매니저가 트랜잭션이 시작한다.
	 *  - 1. 첫번째 저장 작업을 처리한다
	 *  - 2. 두번째에서 강제로 예외가 발생한다. 그리고 그 예외는 insertBoard 메소드를
	 *    	호출한 곳으로 던져진다. 즉, 컨트롤러로 간다.
	 *      1.번에서 저장작업 진행했던 것도 롤백된다.
	 * [부연]
	 *  1. @Tranasctional은 체크예외(Exception, 컴파일예외)가 발생하면 트랜잭션을 롤백하지 않는다.     
	 *     반면에 언체크드예외(런타임예외)는 자동으로 롤백된다.
	 *  2. 이 메소드에서 런타임 예외가 발생하면 자동으로 호출한 곳으로 예외가 전파된다.그래서 명시적으로
	 *     throws RuntimeException 구문을 사용하지 않아도 자동으로 컨트롤러에게 전파된다.   
	 */
	@Transactional
	@Override
	public int insertBoard(BoardVo boardVo){
		 // 1. 첫 번째 정상적인 호출
	    return repository.insertBoard(boardVo);
	    
	    // 2. 강제 예외 발생
	    //if (true) {
	    //    throw new RuntimeException("테스트를 위한 강제 예외 발생");
	    //}
	    
		 // 3. 첫 번째 정상적인 호출
	    //repository.insertBoard(boardVo);
	    
	    // if (true) 조건으로 인해 항상 throw new RuntimeException이 실행되므로, 
	    // 사실상 return 1;에 도달하지 않습니다. 그러나 컴파일러는 조건문 실행 여부를 알지 못하고 
	    // 모든 코드 경로에서 반환값이 있어야 한다고 판단합니다. 그래서 명시적으로 1을 반환함.
	    //return 1;
	}	
	
	// 게시물 수정
	@Override
	public int updateBoard(BoardVo boardVo) {
		return repository.updateBoard(boardVo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return repository.deleteBoard(boardNo);
	}

	/*
	 * 게시물 총 갯수 조회
	 */
	@Override
	public int getTotalBoardCount(Criteria cri) {
		return this.repository.getTotalBoardCount(cri);
	}
	
	/*
	 * 답글 작성
	 */
	@Override
	@Transactional	// 여러개의 SQL을 하나의 작업 단위로 묶어서 실행(All or Nothing)
	public int insertReply(BoardVo reply) {
		
		// 1. 기존 답글의 순서 조정
        repository.updateReplyOrder(reply);

        // 2. 새로운 답글의 순서와 들여쓰기 계산
        reply.setReplyOrder(reply.getReplyOrder() + 1);
        reply.setReplyIndent(reply.getReplyIndent() + 1);        
        
        // 3. 새로운 답글 삽입
        int result = repository.insertReply(reply);
        return result;
	}
}
