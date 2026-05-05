package com.example.service;

import com.example.entity.Law;
import com.example.mapper.LawMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 法律法规资讯业务处理
 */
@Service
public class LawService {

    @Resource
    private LawMapper lawMapper;

    /**
     * 新增
     */
    public void add(Law law) {
        lawMapper.insert(law);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        lawMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            lawMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Law law) {
        lawMapper.updateById(law);
    }

    /**
     * 根据ID查询
     */
    public Law selectById(Integer id) {
        return lawMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Law> selectAll(Law law) {
        return lawMapper.selectAll(law);
    }

    /**
     * 分页查询
     */
    public PageInfo<Law> selectPage(Law law, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Law> list = lawMapper.selectAll(law);
        return PageInfo.of(list);
    }

    /**
     * 更新浏览量
     */
    public void updateReadCount(Integer id) {
        lawMapper.updateReadCount(id);
    }
}










