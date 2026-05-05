package com.example.service;

import cn.hutool.core.date.DateUtil;
import com.example.common.enums.ResultCodeEnum;
import com.example.entity.Account;
import com.example.entity.Activity;
import com.example.entity.ActivitySign;
import com.example.entity.User;
import com.example.exception.CustomException;
import com.example.mapper.ActivityMapper;
import com.example.mapper.ActivitySignMapper;
import com.example.mapper.UserMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ActivitySignService {

    @Resource
    ActivitySignMapper activitySignMapper;
    
    @Resource
    ActivityMapper activityMapper;
    
    @Resource
    UserMapper userMapper;

    public void add(ActivitySign activitySign) {
        Account currentUser = TokenUtils.getCurrentUser();
        ActivitySign as = this.selectByActivityIdAndUserId(activitySign.getActivityId(), currentUser.getId());  // 查看用户是否已经报名
        if (as != null) {
            throw new CustomException(ResultCodeEnum.ACTIVITY_SIGN_ERROR);
        }
        
        // 获取活动名称
        Activity activity = activityMapper.selectById(activitySign.getActivityId());
        if (activity != null) {
            activitySign.setActivityName(activity.getName());
        }
        
        // 获取用户名称
        User user = userMapper.selectById(currentUser.getId());
        if (user != null) {
            activitySign.setUserName(user.getName());
        }
        
        activitySign.setUserId(currentUser.getId());
        activitySign.setSignTime(DateUtil.now());
        activitySignMapper.insert(activitySign);
    }

    public ActivitySign selectByActivityIdAndUserId(Integer actId, Integer userId) {
        return activitySignMapper.selectByActivityIdAndUserId(actId, userId);
    }

    public PageInfo<ActivitySign> selectPage(ActivitySign activitySign, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<ActivitySign> list = activitySignMapper.selectAll(activitySign);
        return PageInfo.of(list);
    }

    public void deleteById(Integer id) {
        activitySignMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            this.deleteById(id);
        }
    }

    public void userDelete(Integer activityId, Integer useId) {
        activitySignMapper.userDelete(activityId, useId);
    }
}
