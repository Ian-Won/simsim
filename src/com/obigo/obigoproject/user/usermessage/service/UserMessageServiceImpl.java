package com.obigo.obigoproject.user.usermessage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.obigo.obigoproject.user.usermessage.dao.UserMessageDao;
import com.obigo.obigoproject.user.usermessage.vo.UserMessageVO;

@Service("userMessageService")
public class UserMessageServiceImpl implements UserMessageService {
	@Autowired
	UserMessageDao userMessageDao;

	@Override
	public boolean insertUserMessage(UserMessageVO vo) {
		int resultcount = userMessageDao.insertUserMessage(vo);
		if (resultcount == 1)
			return true;
		else
			return false;
	}

	@Override
	public boolean updateUserMessage(UserMessageVO vo) {
		int resultcount = userMessageDao.updateUserMessage(vo);
		if (resultcount == 1)
			return true;
		else
			return false;
	}

	@Override
	public boolean deleteUserMessage(int userMessageNumber) {
		int resultcount = userMessageDao.deleteUserMessage(userMessageNumber);
		if (resultcount == 1)
			return true;
		else
			return false;
	}

	// 특정 유저의 Message List를 가져오는 메소드
	@Override
	public List<UserMessageVO> getUserMessageList(String userId) {
		return userMessageDao.getUserMessageListByUserId(userId);
	}

}
