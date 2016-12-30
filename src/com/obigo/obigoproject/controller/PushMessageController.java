package com.obigo.obigoproject.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.obigo.obigoproject.messagecategory.service.MessageCategoryService;
import com.obigo.obigoproject.pushmessage.service.PushMessageService;
import com.obigo.obigoproject.usermessage.service.UserMessageService;
import com.obigo.obigoproject.uservehicle.service.UserVehicleService;
import com.obigo.obigoproject.vo.PushMessageVO;
import com.obigo.obigoproject.vo.UserMessageVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class PushMessageController {
	@Autowired
	PushMessageService pushMessageService;
	@Autowired
	UserMessageService userMessageService;
	@Autowired
	MessageCategoryService messageCategoryService;
	@Autowired
	UserVehicleService userVehicleService;

	/**
	 * Text Area의 값을 Category로 선택한 대상자에게 메시지 전송
	 * 
	 * 
	 * @return 푸시 메시지 관리 페이지
	 * @throws IOException
	 */
	@RequestMapping(value = "/sendtextmessage", method = RequestMethod.POST)
	public String sendTextMessage(PushMessageVO vo, HttpServletRequest request) throws IOException {
		pushMessageService.sendPushMessageToGcm(vo, request);
		PushMessageVO pushMessage = pushMessageService.getPushMessage();
		List<String> userIdList = userVehicleService.getUserId(pushMessage);
		for (String userId : userIdList) {
			UserMessageVO umvo = new UserMessageVO();
			umvo.setMessageNumber(pushMessage.getMessageNumber());
			umvo.setUserId(userId);
			userMessageService.insertUserMessage(umvo);
		}
		return "redirect:/pushmessage";
	}

	/**
	 * Text Area의 값을 Category로 선택한 대상자에게 메시지 전송 + FILE포함
	 * 
	 * @return 푸시 메시지 관리 페이지
	 */
	@RequestMapping("/sendmarketingmessage")
	public String sendMarketingMessage(@RequestParam PushMessageVO vo) {
		return null;
	}

	/**
	 * Text Area의 값을 Category로 선택한 대상자에게 메시지 전송 + FILE포함
	 * 
	 * @return 푸시 메시지 관리 페이지
	 */
	@RequestMapping(value = "/deletepushmessage", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public String deleteMessage(@RequestParam("messageNumber") int messageNumber) {
		JSONObject jobj = new JSONObject();
		if (pushMessageService.deletePushMessage(messageNumber))
			jobj.put("flag", true);
		else
			jobj.put("flag", false);

		return jobj.toString();
	}

	/**
	 * getmessageanalytics
	 * 
	 * @return 푸시 메시지 관리 페이지
	 */
	@RequestMapping(value = "/getmessageanalytics", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public String getMessageAnalytics() {
		JSONArray jArray = (JSONArray) pushMessageService.getCategoryName();
		return jArray.toString();
	}

}
