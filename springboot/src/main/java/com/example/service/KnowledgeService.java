package com.example.service;

import com.example.entity.Knowledge;
import com.example.mapper.KnowledgeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 治理知识库业务处理
 */
@Service
public class KnowledgeService {

    @Resource
    private KnowledgeMapper knowledgeMapper;

    public void add(Knowledge knowledge) {
        knowledgeMapper.insert(knowledge);
    }

    public void deleteById(Integer id) {
        knowledgeMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            knowledgeMapper.deleteById(id);
        }
    }

    public void updateById(Knowledge knowledge) {
        knowledgeMapper.updateById(knowledge);
    }

    public Knowledge selectById(Integer id) {
        return knowledgeMapper.selectById(id);
    }

    public List<Knowledge> selectAll(Knowledge knowledge) {
        return knowledgeMapper.selectAll(knowledge);
    }

    public PageInfo<Knowledge> selectPage(Knowledge knowledge, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Knowledge> list = knowledgeMapper.selectAll(knowledge);
        return PageInfo.of(list);
    }

    public void updateReadCount(Integer id) {
        knowledgeMapper.updateReadCount(id);
    }
}










