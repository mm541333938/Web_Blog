package pluto1024.www.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pluto1024.www.dao.UpvoteMapper;
import pluto1024.www.entity.Upvote;
import pluto1024.www.service.UpvoteService;

@Service
public class UpvoteServiceImpl implements UpvoteService {
    @Autowired
    private UpvoteMapper upvoteMapper;

    public Upvote findByUidAndConId(Upvote upvote) {
        return upvoteMapper.selectOne(upvote);
    }

    @Override
    public int add(Upvote upvote) {
        return 0;
    }

    @Override
    public Upvote getByUid(Upvote upvote) {
        return null;
    }

    @Override
    public void update(Upvote upvote) {

    }
}
