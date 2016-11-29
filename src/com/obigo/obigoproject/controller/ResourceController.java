package com.obigo.obigoproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.obigo.obigoproject.resource.service.ResourceService;
import com.obigo.obigoproject.vo.ResourceVO;

@Controller
public class ResourceController {
	@Autowired
	ResourceService resourceService;

	/**
	 * 리소스 등록 폼에서 등록 요청이 들어오면 등록해주는 기능
	 * 
	 * @return 리소스 관리 페이지
	 */
	@RequestMapping("/insertresource")
	public String insertResource(@RequestParam ResourceVO vo) {
		return null;
	}

	/**
	 * 리소스 수정 폼에서 수정 요청이 들어오면 수정해주는 기능
	 * 
	 * @return 리소스 관리 페이지
	 */
	@RequestMapping("/updateresource")
	public String updateResource(@RequestParam ResourceVO vo) {
		return null;
	}

	/**
	 * 리소스 조회 페이지에서 해당 리소스 삭제 버튼 클릭시 리소스 삭제해주는 기능
	 * 
	 * @return 리소스 관리 페이지
	 */
	@RequestMapping("/deleteresource")
	public String deleteResource(@RequestParam int resourceNumber) {
		return null;
	}

	/**
	 * 리소스 조회 페이지에서 번들 클릭시 해당 번들의 Resource리스트를 보여주는 기능
	 * 
	 * @return 리소스 관리 페이지
	 */
	@RequestMapping("/selectresource")
	public String selectResource(@RequestParam String bundleKey) {
		return null;
	}

}
