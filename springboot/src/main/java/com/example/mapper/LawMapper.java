package com.example.mapper;

import com.example.entity.Law;

import java.util.List;

/**
 * 反诈资讯Mapper
 */
public interface LawMapper {

    /**
     * 新增
     */
    int insert(Law law);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Law law);

    /**
     * 根据ID查询
     */
    Law selectById(Integer id);

    /**
     * 查询所有
     */
    List<Law> selectAll(Law law);

    /**
     * 更新浏览量
     */
    int updateReadCount(Integer id);
}










