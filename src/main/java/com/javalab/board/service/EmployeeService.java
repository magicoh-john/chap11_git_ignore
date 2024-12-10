package com.javalab.board.service;

import java.util.List;

import com.javalab.board.dto.Criteria;
import com.javalab.board.dto.EmployeeCommonDto;
import com.javalab.board.vo.EmployeeVo;


public interface EmployeeService {
	public List<EmployeeCommonDto> getEmployeeList(Criteria cri);	// 전사원조회	
	//public List<EmployeeCommonDto> getEmployeeList(EmployeeCommonDto eDto);	// 전사원조회
	public int getTotalEmployees(Criteria cri);			// 페이징을 위한 사원숫자 조회	
	public void register(EmployeeVo emp);
	public EmployeeCommonDto getEmployee(int employeeId);
}

