package pluto1024.www.service.impl;

import org.springframework.stereotype.Service;
import pluto1024.www.entity.UserInfo;
import pluto1024.www.service.UserInfoService;

@Service
public class UserInfoServiceImpl implements UserInfoService {
    @Override
    public UserInfo findByUid(Long id) {
        return null;
    }

    @Override
    public void update(UserInfo userInfo) {

    }

    @Override
    public void add(UserInfo userInfo) {

    }
}
