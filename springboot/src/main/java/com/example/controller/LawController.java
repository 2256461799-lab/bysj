package com.example.controller;

import cn.hutool.core.date.DateUtil;
import com.example.common.Result;
import com.example.entity.Law;
import com.example.service.LawService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 资讯前端操作接口
 */
@RestController
@RequestMapping("/law")
public class LawController {

    @Resource
    private LawService lawService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Law law) {
        law.setPublishTime(DateUtil.today());
        lawService.add(law);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        lawService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        lawService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Law law) {
        lawService.updateById(law);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Law law = lawService.selectById(id);
        return Result.success(law);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Law law) {
        List<Law> list = lawService.selectAll(law);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Law law,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Law> page = lawService.selectPage(law, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 更新浏览量
     */
    @PutMapping("/updateReadCount/{id}")
    public Result updateReadCount(@PathVariable Integer id) {
        lawService.updateReadCount(id);
        return Result.success();
    }
}










