package com.javalab.board.vo;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
public class EmployeeVo {
	private Long employeeId;
	private String firstName;
	private String lastName;
	private String email;
	private String phoneNumber;
	private Date hireDate;
	private String jobId;
	private Long salary;
	private Long commissionPct;
	private Integer managerId;
	private Integer departmentId;
}
