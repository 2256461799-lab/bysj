package com.example.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import okhttp3.*;
import okhttp3.sse.EventSource;
import okhttp3.sse.EventSourceListener;
import okhttp3.sse.EventSources;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * AI对话服务
 */
@Service
public class AiChatService {

    @Value("${qianwen.api-key}")
    private String apiKey;

    @Value("${qianwen.model}")
    private String model;

    @Value("${qianwen.base-url}")
    private String baseUrl;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    private static final OkHttpClient client = new OkHttpClient.Builder()
            .connectTimeout(30, TimeUnit.SECONDS)
            .readTimeout(60, TimeUnit.SECONDS)
            .writeTimeout(60, TimeUnit.SECONDS)
            .build();

    /**
     * 智能问答 - 流式输出
     */
    public SseEmitter chat(String sessionId, String userMessage) {
        SseEmitter emitter = new SseEmitter(60000L);

        // 获取历史对话
        List<JSONObject> messages = getHistoryMessages(sessionId);

        // 添加用户消息
        JSONObject userMsg = new JSONObject();
        userMsg.put("role", "user");
        userMsg.put("content", userMessage);
        messages.add(userMsg);

        // 构建请求
        JSONObject requestBody = buildRequest(messages, true);

        // 发起流式请求
        Request request = new Request.Builder()
                .url(baseUrl)
                .header("Authorization", "Bearer " + apiKey)
                .header("Content-Type", "application/json")
                .header("X-DashScope-SSE", "enable")
                .post(RequestBody.create(requestBody.toJSONString(), MediaType.parse("application/json")))
                .build();

        StringBuilder fullResponse = new StringBuilder();

        EventSourceListener listener = new EventSourceListener() {
            @Override
            public void onOpen(EventSource eventSource, Response response) {
                try {
                    emitter.send(SseEmitter.event().data("[START]"));
                } catch (IOException e) {
                    emitter.completeWithError(e);
                }
            }

            @Override
            public void onEvent(EventSource eventSource, String id, String type, String data) {
                try {
                    if (!"[DONE]".equals(data)) {
                        JSONObject jsonData = JSON.parseObject(data);
                        JSONObject output = jsonData.getJSONObject("output");
                        if (output != null) {
                            JSONArray choices = output.getJSONArray("choices");
                            if (choices != null && choices.size() > 0) {
                                JSONObject choice = choices.getJSONObject(0);
                                JSONObject message = choice.getJSONObject("message");
                                if (message != null) {
                                    String content = message.getString("content");
                                    if (content != null && !content.isEmpty()) {
                                        fullResponse.append(content);
                                        emitter.send(SseEmitter.event().data(content));
                                    }
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onClosed(EventSource eventSource) {
                try {
                    // 保存对话历史
                    saveMessage(sessionId, "user", userMessage);
                    saveMessage(sessionId, "assistant", fullResponse.toString());

                    emitter.send(SseEmitter.event().data("[DONE]"));
                    emitter.complete();
                } catch (IOException e) {
                    emitter.completeWithError(e);
                }
            }

            @Override
            public void onFailure(EventSource eventSource, Throwable t, Response response) {
                emitter.completeWithError(t);
            }
        };

        EventSources.createFactory(client).newEventSource(request, listener);

        return emitter;
    }

    /**
     * 构建请求参数
     */
    private JSONObject buildRequest(List<JSONObject> messages, boolean stream) {
        JSONObject request = new JSONObject();
        request.put("model", model);

        JSONObject input = new JSONObject();
        input.put("messages", messages);
        request.put("input", input);

        JSONObject parameters = new JSONObject();
        parameters.put("result_format", "message");
        parameters.put("incremental_output", stream);
        request.put("parameters", parameters);

        return request;
    }

    /**
     * 获取历史对话
     */
    private List<JSONObject> getHistoryMessages(String sessionId) {
        String key = "chat:history:" + sessionId;
        List<String> history = stringRedisTemplate.opsForList().range(key, 0, -1);
        List<JSONObject> messages = new ArrayList<>();
        if (history != null) {
            for (String msg : history) {
                messages.add(JSON.parseObject(msg));
            }
        }
        return messages;
    }

    /**
     * 保存消息到Redis
     */
    private void saveMessage(String sessionId, String role, String content) {
        String key = "chat:history:" + sessionId;
        JSONObject message = new JSONObject();
        message.put("role", role);
        message.put("content", content);
        stringRedisTemplate.opsForList().rightPush(key, message.toJSONString());
        // 设置7天过期
        stringRedisTemplate.expire(key, 7, TimeUnit.DAYS);
    }

    /**
     * 清除对话历史
     */
    public void clearHistory(String sessionId) {
        String key = "chat:history:" + sessionId;
        stringRedisTemplate.delete(key);
    }
}