package com.example.mapper;

import com.example.entity.Chapter;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 法治课堂章节Mapper
 */
@Mapper
public interface ChapterMapper {

    /**
     * 新增
     */
    int insert(Chapter chapter);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Chapter chapter);

    /**
     * 根据ID查询
     */
    Chapter selectById(Integer id);

    /**
     * 查询所有
     */
    List<Chapter> selectAll(Chapter chapter);

    /**
     * 查询所有已发布的章节（包含课时列表）
     */
    @Select("select * from chapter where status = '已发布' order by sort_order asc")
    List<Chapter> selectPublished();
}








