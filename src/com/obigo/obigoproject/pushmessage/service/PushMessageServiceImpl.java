package com.obigo.obigoproject.pushmessage.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.MulticastResult;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;
import com.obigo.obigoproject.pushmessage.dao.PushMessageDao;
import com.obigo.obigoproject.registrationid.dao.RegistrationidDao;
import com.obigo.obigoproject.registrationid.service.RegistrationidService;
import com.obigo.obigoproject.uservehicle.dao.UserVehicleDao;
import com.obigo.obigoproject.vo.PushMessageVO;
import com.obigo.obigoproject.vo.RegistrationidVO;

@Service("pushMessageService")
public class PushMessageServiceImpl implements PushMessageService {

	@Autowired
	PushMessageDao pushMessageDao;

	@Autowired
	UserVehicleDao uservehicleDao;

	@Autowired
	RegistrationidDao registrationidDao;

	// PUSHMESSAGE 등록
	@Override
	public boolean insertPushMessage(PushMessageVO vo) {
		int resultCount = 0;

		resultCount = pushMessageDao.insertPushMessage(vo);

		if (resultCount == 1)
			return true;
		else
			return false;

	}

	// PUSHMESSAGE 수정
	@Override
	public boolean updatePushMessage(PushMessageVO vo) {
		int resultCount = 0;

		resultCount = pushMessageDao.updatePushMessage(vo);

		if (resultCount == 1)
			return true;
		else
			return false;
	}

	// PUSHMESSAGE 삭제
	@Override
	public boolean deletePushMessage(int messageNumber) {
		int resultCount = 0;

		resultCount = pushMessageDao.deletePushMessage(messageNumber);

		if (resultCount == 1)
			return true;
		else
			return false;
	}

	// 전체 PUSHMESSAGE를 가지고오는 메소드
	@Override
	public List<PushMessageVO> getPushMessageList() {
		return pushMessageDao.getPushMessageList();
	}

	// 특정 카테고리의 PUSHMESSAGE를 가지고오는 메소드
	@Override
	public List<PushMessageVO> getPushMessageListByCategory(int categoryNumber) {
		return pushMessageDao.getPushMessageListByCategory(categoryNumber);
	}

	// 정기적으로 통계리포트 생성 및 등록된 이메일로 발송 (pdf로 출력하기 기능)
	@Override
	public boolean sendEmail(List<PushMessageVO> list) {
		// TODO Auto-generated method stub
		return false;
	}

	// GCM 서버로 푸시 메시지 전송
	@Override
	public boolean sendPushMessageToGcm(PushMessageVO vo) {
		List<String> userIdList = uservehicleDao.getUserId(vo);
		for (String userId : userIdList) {
			List<String> registrationidList = registrationidDao.getRegistrationidListByuserId(userId);
			String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1); // 메시지
																			// 고유
			boolean SHOW_ON_IDLE = false; // 옙 활성화 상태일때 보여줄것인지
			int LIVE_TIME = 1; // 옙 비활성화 상태일때 FCM가 메시지를 유효화하는 시간
			int RETRY = 2; // 메시지 전송실패시 재시도 횟수
			String simpleApiKey = "AIzaSyAugaUfy_TbAFpMsr91f4_M8cTvePi0now";
			Sender sender = new Sender(simpleApiKey);
			Message message = new Message.Builder().collapseKey(MESSAGE_ID).delayWhileIdle(SHOW_ON_IDLE)
					.timeToLive(LIVE_TIME).addData("content", vo.getContent()).addData("title", vo.getTitle()).build();
			try {
				MulticastResult result1 = sender.send(message, registrationidList, RETRY);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	// 특정 아이디의 pushmessage를 인덱싱하여 가지고오는 메소드
	@Override
	public List<PushMessageVO> getPushMessageList(String userId) {
		return pushMessageDao.getPushMessageList(userId);
	}

	@Override
	public PushMessageVO getPushMessage() {
		return pushMessageDao.getPushMessage();
	}

}
