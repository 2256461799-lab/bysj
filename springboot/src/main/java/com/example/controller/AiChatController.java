package com.example.controller;

import com.example.common.Result;
import com.example.service.AiChatService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.annotation.Resource;

/**
 * AI对话接口
 */
@RestController
@RequestMapping("/ai")
public class AiChatController {

    @Resource
    private AiChatService aiChatService;

    /**
     * 智能问答 - 流式输出
     * @param sessionId 会话ID
     * @param message 用户消息
     */
    @GetMapping("/chat")
    public SseEmitter chat(@RequestParam String sessionId, @RequestParam String message) {
        return aiChatService.chat(sessionId, message);
    }

    /**
     * 清除对话历史
     * @param sessionId 会话ID
     */
    @DeleteMapping("/clear")
    public Result clearHistory(@RequestParam String sessionId) {
        aiChatService.clearHistory(sessionId);
        return Result.success();
    }
}