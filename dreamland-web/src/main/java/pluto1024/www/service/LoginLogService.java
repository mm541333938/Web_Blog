package pluto1024.www.service;

import pluto1024.www.entity.LoginLog;

import java.util.List;

public interface LoginLogService {
    /**
     * 增加登录日志
     *
     * @param loginLog
     * @return
     */
    int add(LoginLog loginLog);

    /**
     * 查询所有日志
     *
     * @param
     * @return
     */
    List<LoginLog> findAll();

    /**
     * 根据用户id查询日志集合
     *
     * @param uid
     * @return
     */
    List<LoginLog> findByUid(Long uid);

}
