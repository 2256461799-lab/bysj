package com.example.controller;

import cn.hutool.core.date.DateUtil;
import com.example.common.Result;
import com.example.entity.Knowledge;
import com.example.service.KnowledgeService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 反诈知识库前端操作接口
 */
@RestController
@RequestMapping("/knowledge")
public class KnowledgeController {

    @Resource
    private KnowledgeService knowledgeService;

    @PostMapping("/add")
    public Result add(@RequestBody Knowledge knowledge) {
        knowledge.setPublishTime(DateUtil.today());
        knowledgeService.add(knowledge);
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        knowledgeService.deleteById(id);
        return Result.success();
    }

    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        knowledgeService.deleteBatch(ids);
        return Result.success();
    }

    @PutMapping("/update")
    public Result updateById(@RequestBody Knowledge knowledge) {
        knowledgeService.updateById(knowledge);
        return Result.success();
    }

    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Knowledge knowledge = knowledgeService.selectById(id);
        return Result.success(knowledge);
    }

    @GetMapping("/selectAll")
    public Result selectAll(Knowledge knowledge) {
        List<Knowledge> list = knowledgeService.selectAll(knowledge);
        return Result.success(list);
    }

    @GetMapping("/selectPage")
    public Result selectPage(Knowledge knowledge,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Knowledge> page = knowledgeService.selectPage(knowledge, pageNum, pageSize);
        return Result.success(page);
    }

    @PutMapping("/updateReadCount/{id}")
    public Result updateReadCount(@PathVariable Integer id) {
        knowledgeService.updateReadCount(id);
        return Result.success();
    }
}










