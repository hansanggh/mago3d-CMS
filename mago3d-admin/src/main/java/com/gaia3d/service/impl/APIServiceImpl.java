package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.APILog;
import com.gaia3d.persistence.APIMapper;
import com.gaia3d.service.APIService;

/**
 * API
 * @author jeongdae
 *
 */
@Service
public class APIServiceImpl implements APIService {

	@Autowired
	private APIMapper aPIMapper;

	/**
	 * API 이력 총 건수
	 * @param aPILog
	 * @return
	 */
	public Long getAPILogTotalCount(APILog aPILog) {
		return aPIMapper.getAPILogTotalCount(aPILog);
	}
	
	/**
	 * API 이력 목록
	 * @param aPILog
	 * @return
	 */
	public List<APILog> getListAPILog(APILog aPILog) {
		return aPIMapper.getListAPILog(aPILog);
	}
	
	/**
	 * API 이력 정보
	 * @param api_log_id
	 * @return
	 */
	public APILog getAPILog(Long api_log_id) {
		return aPIMapper.getAPILog(api_log_id);
	}
	
	/**
	 * API 호출 정보 등록
	 * @param aPILog
	 * @return
	 */
	public int insertAPILog(APILog aPILog) {
		return aPIMapper.insertAPILog(aPILog);
	}
}
