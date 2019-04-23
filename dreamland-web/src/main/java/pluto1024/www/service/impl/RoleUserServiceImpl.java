package pluto1024.www.service.impl;

import org.springframework.stereotype.Service;
import pluto1024.www.entity.RoleUser;
import pluto1024.www.entity.User;
import pluto1024.www.service.RoleUserService;

import java.util.List;

@Service
public class RoleUserServiceImpl implements RoleUserService {
    @Override
    public List<RoleUser> findByUser(User user) {
        return null;
    }

    @Override
    public int add(RoleUser roleUser) {
        return 0;
    }

    @Override
    public void deleteByUid(Long uid) {

    }
}
