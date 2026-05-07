package com.example.service;
import com.example.entity.Report;
import com.example.mapper.ReportMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;
/**
 * 事件上报业务处理
 */
@Service
public class ReportService {
    @Resource
    private ReportMapper reportMapper;
    @Resource
    private StringRedisTemplate stringRedisTemplate;
    /**
     * 新增
     */
    public void add(Report report) {
        reportMapper.insert(report);
    }
    /**
     * 删除
     */
    public void deleteById(Integer id) {
        reportMapper.deleteById(id);
    }
    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            reportMapper.deleteById(id);
        }
    }
    /**
     * 修改
     */
    public void updateById(Report report) {
        reportMapper.updateById(report);
    }
    /**
     * 根据ID查询
     */
    public Report selectById(Integer id) {
        return reportMapper.selectById(id);
    }
    /**
     * 查询所有
     */
    public List<Report> selectAll(Report report) {
        return reportMapper.selectAll(report);
    }
    /**
     * 分页查询
     */
    public PageInfo<Report> selectPage(Report report, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Report> list = reportMapper.selectAll(report);
        return PageInfo.of(list);
    }
    /**
     * 获取上报总数（带Redis缓存，5分钟过期）
     */
    public Integer getReportCount() {
        String key = "stats:reportCount";
        String count = stringRedisTemplate.opsForValue().get(key);
        if (count != null) {
            return Integer.valueOf(count);
        }
        Integer dbCount = reportMapper.selectAll(null).size();
        stringRedisTemplate.opsForValue().set(key, String.valueOf(dbCount), 5, TimeUnit.MINUTES);
        return dbCount;
    }
}