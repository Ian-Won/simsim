package com.obigo.obigoproject.pushmessage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.obigo.obigoproject.pushmessage.dao.PushMessageDao;
import com.obigo.obigoproject.vo.PushMessageVO;

@Service("pushMessageService")
public class PushMessageServiceImpl implements PushMessageService {

	@Autowired
	PushMessageDao pushMessageDao;

	// PUSHMESSAGE 등록
	@Override
	public boolean insertPushMessage(PushMessageVO vo) {
		int resultCount=0;
		
		resultCount=pushMessageDao.insertPushMessage(vo);
		
		if(resultCount==1)
			return true;
		else
			return false;
		
	}

	// PUSHMESSAGE 수정
	@Override
	public boolean updatePushMessage(PushMessageVO vo) {
		int resultCount=0;
		
		resultCount=pushMessageDao.updatePushMessage(vo);
		
		if(resultCount==1)
			return true;
		else
			return false;
	}

	// PUSHMESSAGE 삭제
	@Override
	public boolean deletePushMessage(int messageNumber) {
		int resultCount=0;
		
		resultCount=pushMessageDao.deletePushMessage(messageNumber);
		
		if(resultCount==1)
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
	public boolean sendPushMessageToGcm(PushMessageVO vo, List<String> listRegistrationId) {
		// TODO Auto-generated method stub
		return false;
	}

}
