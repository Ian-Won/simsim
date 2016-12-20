package com.obigo.obigoproject.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.obigo.obigoproject.androiduservehicle.service.AndroidUserVehicleService;
import com.obigo.obigoproject.api.service.ApiService;
import com.obigo.obigoproject.bundle.service.BundleService;
import com.obigo.obigoproject.bundleversion.service.BundleVersionService;
import com.obigo.obigoproject.log.service.LogService;
import com.obigo.obigoproject.messagecategory.service.MessageCategoryService;
import com.obigo.obigoproject.pushmessage.service.PushMessageService;
import com.obigo.obigoproject.registrationid.service.RegistrationidService;
import com.obigo.obigoproject.resource.service.ResourceService;
import com.obigo.obigoproject.user.service.UserService;
import com.obigo.obigoproject.usermessage.service.UserMessageService;
import com.obigo.obigoproject.userrequest.service.UserRequestService;
import com.obigo.obigoproject.uservehicle.service.UserVehicleService;
import com.obigo.obigoproject.vehicle.service.VehicleService;
import com.obigo.obigoproject.vo.RegistrationidVO;
import com.obigo.obigoproject.vo.UserRequestVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class RestFulApiController {
	@Autowired
	ApiService apiService;
	@Autowired
	BundleService bundleService;
	@Autowired
	BundleVersionService bundleVersionService;
	@Autowired
	LogService logService;
	@Autowired
	MessageCategoryService messageCategoryService;
	@Autowired
	PushMessageService pushMessageService;
	@Autowired
	ResourceService resourceService;
	@Autowired
	UserService userService;
	@Autowired
	UserMessageService userMessageService;
	@Autowired
	UserRequestService userRequestService;
	@Autowired
	UserVehicleService userVehicleService;
	@Autowired
	VehicleService vehicleService;
	@Autowired
	AndroidUserVehicleService androiduservehicleService;
	@Autowired
	RegistrationidService registrationidService;

	/**
	 * Image 받아가시오 ~
	 * 
	 * @return 이미지~
	 */
	@RequestMapping(value = "/api/image/{select}/{imagename:.+}", method = { RequestMethod.GET })
	@ResponseBody
	public void image(@PathVariable String select, @PathVariable String imagename, HttpServletResponse response) {
		String path = "c:/obigo/" + select + "/";

		path += imagename;
		FileInputStream fs = null;
		try {
			fs = new FileInputStream(path);
			byte[] iconImage = new byte[fs.available()];
			fs.read(iconImage);
			response.setContentType("image/jpg");
			response.getOutputStream().write(iconImage);
		} catch (Exception e1) {
			try {
				fs = new FileInputStream("C:/obigo/no_img.gif");
				byte[] iconImage = new byte[fs.available()];
				fs.read(iconImage);
				response.setContentType("image/jpg");
				response.getOutputStream().write(iconImage);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					response.getOutputStream().close();
				} catch (Exception e) {
					// e.printStackTrace();
				}
			}

		} finally {
			try {
				response.getOutputStream().close();
			} catch (Exception e) {
				// e.printStackTrace();
			}
		}
	}

	/**
	 * 로그인 체크 Api parameter = "id":유저아이디 "password":비밀번호
	 * 
	 * @return "flag" : 결과
	 */
	@RequestMapping(value = "/api/login/{id}/{password}", method = { RequestMethod.GET })
	@ResponseBody
	public String login(@PathVariable String id, @PathVariable String password) {
		JSONObject jobj = new JSONObject();
		if (!(userService.idCheck(id))) {
			if (userService.getUser(id).getPassword().equals(password)) {
				jobj.put("flag", true);
				jobj.put("userVehicle", userVehicleService.getUserVehicleList(id));
			} else
				jobj.put("flag", false);
		} else {
			jobj.put("flag", false);
		}

		return jobj.toString();
	}

	/**
	 * 번들 체크 Api parameter : "bundleVersion":번들버전
	 * 
	 * @return "flag" : 결과
	 */
	@RequestMapping(value = "/api/bundlecheck/{bundleVersion}", method = { RequestMethod.GET })
	@ResponseBody
	public String bundlecheck(@PathVariable String bundleVersion) {
		JSONObject jobj = new JSONObject();
		if (bundleVersionService.getBundleVersion().equals(bundleVersion))
			jobj.put("flag", true);
		else
			jobj.put("flag", false);
		return jobj.toString();
	}

	/**
	 * 번들 업데이트 Api
	 * 
	 * @return "bundle" : 번들 주소값
	 */
	@RequestMapping(value = "/api/bundleupdate", method = { RequestMethod.GET })
	@ResponseBody
	public String bundleUpdate() {
		JSONObject jobj = new JSONObject();
		jobj.put("path",
				bundleService.getBundleBybundleVersion(bundleVersionService.getBundleVersion()).getFileUpload());
		return jobj.toString();
	}

	/**
	 * 유저 차량 정보 리스트 Api parameter = "userId":유저아이디
	 * 
	 * @return "userVehicleList" : 유저 차량 리스트
	 */
	@RequestMapping(value = "/api/uservehicle/{userId}", method = { RequestMethod.GET })
	@ResponseBody
	public String userVehicle(@PathVariable String userId) {
		System.out.println(userId);
		JSONArray jsonArray = new JSONArray();
		jsonArray.addAll(androiduservehicleService.getAndroidUserVehicleListByUserid(userId));
		System.out.println(jsonArray.toString());
		return jsonArray.toString();
	}

	/**
	 * 유저 차량 정보 Api parameter = "modelCode":차량코드
	 * 
	 * @return "userVehicle" : 유저 차량 정보
	 */
	@RequestMapping(value = "/api/cardetailinfo/{modelCode}", method = { RequestMethod.GET })
	@ResponseBody
	public String userVehicleDetail(@PathVariable String modelCode) {
		JSONObject jobj = new JSONObject();
		jobj.put("userVehicle", vehicleService.getVehicle(modelCode));
		return jobj.toString();
	}

	/**
	 * 유저 차량 등록 요청 Api parameter = "userId":유저아이디, "modelCode":차량코드, "color":색상,
	 * "location":지역, "vin":고유번호
	 * 
	 * @return "flag" : 등록 여부
	 */

	@RequestMapping(value = "/api/userrequest", method = { RequestMethod.POST })
	@ResponseBody
	public String insertUserRequest(@RequestBody String data)
			throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		UserRequestVO vo = mapper.readValue(data, UserRequestVO.class);
		System.out.println(vo);
		if (userRequestService.insertUserRequest(vo) == true)
			return "true";
		else
			return "false";
	}

	/**
	 * 유저 푸시메시지 리스트 요청 Api parameter = "userId":유저아이디, "index":페이지번호
	 * 
	 * @return "messageList" : 메시지 리스트
	 */
	@RequestMapping(value = "/api/message/{userId}", method = { RequestMethod.GET })
	@ResponseBody
	public String getMessageList(@PathVariable String userId) {
		System.out.println(userId);
		JSONArray jsonArray = new JSONArray();
		jsonArray.addAll(pushMessageService.getPushMessageList(userId));
		System.out.println(jsonArray.toString());
		return jsonArray.toString();
	}

	/////////////////////////////////////////////////////////////////////
	/*
	 * 로그인시 Registration ID 가져오기(받은 아이디랑 비밀번호로 db에서 정보를 찾고 registrationid에 token
	 * 값으로 업데이트)
	 * 
	 */
	@RequestMapping(value = "/api/registrationid", method = RequestMethod.POST)
	public String insertRegistrationid(@RequestBody String data)
			throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		RegistrationidVO vo = mapper.readValue(data, RegistrationidVO.class);
		registrationidService.insertRegistrationid(vo);
		return "true";
	}

	@RequestMapping(value = "/api/vehicle", method = RequestMethod.GET)
	@ResponseBody
	public String getVehicleList() {
		JSONArray jsonArray = new JSONArray();
		jsonArray.addAll(vehicleService.getVehicleList());
		System.out.println(jsonArray.toString());
		return jsonArray.toString();
	}

	@RequestMapping(value = "/api/user/{userId}", method = RequestMethod.GET)
	@ResponseBody
	public String getUser(@PathVariable String userId) {
		System.out.println("user");
		System.out.println(userId);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("user", userService.getUser(userId));
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/api/login", method = RequestMethod.GET)
	public String login(){
		return null;
	}
	
	
}
