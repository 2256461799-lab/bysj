package com.example.service;

import com.example.entity.Chapter;
import com.example.mapper.ChapterMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 法制课堂章节业务处理
 */
@Service
public class ChapterService {

    @Resource
    private ChapterMapper chapterMapper;

    /**
     * 新增
     */
    public void add(Chapter chapter) {
        chapterMapper.insert(chapter);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        chapterMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            chapterMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Chapter chapter) {
        chapterMapper.updateById(chapter);
    }

    /**
     * 根据ID查询
     */
    public Chapter selectById(Integer id) {
        return chapterMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Chapter> selectAll(Chapter chapter) {
        return chapterMapper.selectAll(chapter);
    }

    /**
     * 分页查询
     */
    public PageInfo<Chapter> selectPage(Chapter chapter, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Chapter> list = chapterMapper.selectAll(chapter);
        return PageInfo.of(list);
    }

    /**
     * 查询所有已发布的章节
     */
    public List<Chapter> selectPublished() {
        return chapterMapper.selectPublished();
    }
}








