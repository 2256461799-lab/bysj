package com.example.mapper;

import com.example.entity.Report;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 事件上报Mapper接口
 */
public interface ReportMapper {

    /**
     * 新增
     */
    int insert(Report report);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Report report);

    /**
     * 根据ID查询
     */
    Report selectById(Integer id);

    /**
     * 查询所有
     */
    List<Report> selectAll(Report report);
}









