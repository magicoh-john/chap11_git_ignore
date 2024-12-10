package com.javalab.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javalab.board.dto.Criteria;
import com.javalab.board.dto.EmployeeCommonDto;
import com.javalab.board.repository.EmployeeRepository;
import com.javalab.board.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	private final EmployeeRepository dao;

	@Override
	public List<EmployeeCommonDto> getEmployeeList(Criteria cri) {
		log.info(cri.toString());
		List<EmployeeCommonDto> employeeList = dao.getEmployeeList(cri);
		return employeeList;
	}	
	
	@Override
	public int getTotalEmployees(Criteria cri) {
		return dao.getTotalEmployees(cri);
	}


	@Override
	public void register(EmployeeVo emp) {
		dao.register(emp);
		
	}


	@Override
	public EmployeeCommonDto getEmployee(int employeeId) {
		EmployeeCommonDto employee = dao.getEmployee(employeeId);
		return employee;
	}



}
