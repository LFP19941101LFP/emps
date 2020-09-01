package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.dao.DepartmentMapper;
/**
* 部门业务类
* @Title: DepartmentService.java  
* @Package com.atguigu.crud.service    
* @author LiFupeng  
* @date 2020年6月26日  
* @company 阿里巴巴
* @version V1.0
 */
@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;

	/**
	 * 获取部门信息
	 * @return
	 */
	public List<Department> getDepts() {
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

}
