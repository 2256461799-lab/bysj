package com.example.controller;

import cn.hutool.core.date.DateUtil;
import com.example.common.Result;
import com.example.entity.Chapter;
import com.example.service.ChapterService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 反诈课堂章节前端操作接口
 */
@RestController
@RequestMapping("/chapter")
public class ChapterController {

    @Resource
    private ChapterService chapterService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Chapter chapter) {
        chapter.setCreateTime(DateUtil.now());
        chapterService.add(chapter);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        chapterService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        chapterService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Chapter chapter) {
        chapterService.updateById(chapter);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Chapter chapter = chapterService.selectById(id);
        return Result.success(chapter);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Chapter chapter) {
        List<Chapter> list = chapterService.selectAll(chapter);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Chapter chapter,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Chapter> page = chapterService.selectPage(chapter, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 查询所有已发布的章节
     */
    @GetMapping("/selectPublished")
    public Result selectPublished() {
        List<Chapter> list = chapterService.selectPublished();
        return Result.success(list);
    }
}








