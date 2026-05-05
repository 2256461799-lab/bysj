package com.example.service;

import com.example.entity.Lesson;
import com.example.mapper.LessonMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 法制课堂课时业务处理
 */
@Service
public class LessonService {

    @Resource
    private LessonMapper lessonMapper;

    /**
     * 新增
     */
    public void add(Lesson lesson) {
        lessonMapper.insert(lesson);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        lessonMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            lessonMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Lesson lesson) {
        lessonMapper.updateById(lesson);
    }

    /**
     * 根据ID查询
     */
    public Lesson selectById(Integer id) {
        return lessonMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Lesson> selectAll(Lesson lesson) {
        return lessonMapper.selectAll(lesson);
    }

    /**
     * 分页查询
     */
    public PageInfo<Lesson> selectPage(Lesson lesson, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Lesson> list = lessonMapper.selectAll(lesson);
        return PageInfo.of(list);
    }

    /**
     * 根据章节ID查询课时列表
     */
    public List<Lesson> selectByChapterId(Integer chapterId) {
        return lessonMapper.selectByChapterId(chapterId);
    }
}








