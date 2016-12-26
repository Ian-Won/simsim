package com.obigo.obigoproject.log.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.obigo.obigoproject.log.dao.LogDao;
import com.obigo.obigoproject.vo.LogVO;

@Service("logService")
public class LogServiceImpl implements LogService {
	@Autowired
	LogDao logDao;

	@Override
	public boolean insertLog(LogVO vo) {
		int result = logDao.insertLog(vo);
		if (result == 1)
			return true;
		else
			return false;
	}

	@Override
	public boolean deleteAllLog() {
		int count = logDao.getLogCount();
		int result = logDao.deleteAllLog();
		if (result == count)
			return true;
		else
			return false;
	}

	// 미구현
	@Override
	public boolean sendEmail(List<LogVO> list) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<LogVO> getLogList() {
		return logDao.getLogList();
	}

	@Override
	public List<LogVO> getLogListByUrl(String url) {
		return logDao.getLogListByUrl(url);
	}

	@Override
	public List<Integer> getMonthLogCount(String url) {
		List<Integer> list = new ArrayList<>();
		Map map = new HashMap();
		Calendar cal = Calendar.getInstance();
		map.put("year", cal.get(Calendar.YEAR) - 2000);
		map.put("url", url);

		for (int i = 1; i <= 12; i++) {
			map.put("month", i);
			list.add(logDao.getMonthLogCount(map));
		}
		return list;
	}

}