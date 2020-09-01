package com.atguigu.crud.bean;
/**
* 部门类实体类
* @Title: Department.java  
* @Package com.atguigu.crud.bean    
* @author LiFupeng  
* @date 2020年6月26日  
* @company 阿里巴巴
* @version V1.0
 */
public class Department {
    private Integer deptId;

    private String deptName;
    
    

    public Department() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}