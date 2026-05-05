package com.example.controller;

import cn.hutool.core.date.DateUtil;
import com.example.common.Result;
import com.example.entity.Lesson;
import com.example.service.LessonService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 反诈课堂课时前端操作接口
 */
@RestController
@RequestMapping("/lesson")
public class LessonController {

    @Resource
    private LessonService lessonService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Lesson lesson) {
        lesson.setCreateTime(DateUtil.now());
        lessonService.add(lesson);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        lessonService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        lessonService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Lesson lesson) {
        lessonService.updateById(lesson);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Lesson lesson = lessonService.selectById(id);
        return Result.success(lesson);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Lesson lesson) {
        List<Lesson> list = lessonService.selectAll(lesson);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Lesson lesson,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Lesson> page = lessonService.selectPage(lesson, pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 根据章节ID查询课时列表
     */
    @GetMapping("/selectByChapterId/{chapterId}")
    public Result selectByChapterId(@PathVariable Integer chapterId) {
        List<Lesson> list = lessonService.selectByChapterId(chapterId);
        return Result.success(list);
    }
}








