package com.example.mapper;

import com.example.entity.Knowledge;

import java.util.List;

/**
 * 治理案例知识库Mapper
 */
public interface KnowledgeMapper {

    int insert(Knowledge knowledge);

    int deleteById(Integer id);

    int updateById(Knowledge knowledge);

    Knowledge selectById(Integer id);

    List<Knowledge> selectAll(Knowledge knowledge);

    int updateReadCount(Integer id);
}










