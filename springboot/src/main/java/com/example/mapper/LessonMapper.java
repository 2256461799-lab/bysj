package com.example.mapper;

import com.example.entity.Lesson;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 法治课堂课时Mapper
 */
@Mapper
public interface LessonMapper {

    /**
     * 新增
     */
    int insert(Lesson lesson);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Lesson lesson);

    /**
     * 根据ID查询
     */
    Lesson selectById(Integer id);

    /**
     * 查询所有
     */
    List<Lesson> selectAll(Lesson lesson);

    /**
     * 根据章节ID查询课时列表
     */
    @Select("select * from lesson where chapter_id = #{chapterId} and status = '已发布' order by sort_order asc")
    List<Lesson> selectByChapterId(Integer chapterId);
}








