package pluto1024.www.service.impl;

import org.springframework.stereotype.Service;
import pluto1024.www.entity.LoginLog;
import pluto1024.www.service.LoginLogService;

import java.util.List;

@Service
public class LoginLogServiceImpl implements LoginLogService {
    @Override
    public int add(LoginLog loginLog) {
        return 0;
    }

    @Override
    public List<LoginLog> findAll() {
        return null;
    }

    @Override
    public List<LoginLog> findByUid(Long uid) {
        return null;
    }
}
