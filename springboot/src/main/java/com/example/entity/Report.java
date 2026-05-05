package com.example.entity;

import java.math.BigDecimal;

/**
 * 在线举报实体
 */
public class Report {
    private Integer id;
    private String type;  // 举报类型：线索举报、被骗求助
    private String title;  // 举报标题
    private String content;  // 详细内容
    private String contactName;  // 联系人姓名
    private String contactPhone;  // 联系电话
    private String address;  // 详细地址
    private String suspectPhone;  // 可疑电话
    private String suspectAccount;  // 可疑社交账号
    private String suspectLink;  // 可疑链接
    private String evidence;  // 证据附件
    private BigDecimal amount;  // 涉案金额
    private String reportTime;  // 举报时间
    private String status;  // 状态：待处理、处理中、已处理、已关闭
    private String handler;  // 处理人
    private String handleResult;  // 处理结果
    private String handleTime;  // 处理时间
    private Integer userId;  // 举报人ID

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getSuspectPhone() {
        return suspectPhone;
    }

    public void setSuspectPhone(String suspectPhone) {
        this.suspectPhone = suspectPhone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSuspectAccount() {
        return suspectAccount;
    }

    public void setSuspectAccount(String suspectAccount) {
        this.suspectAccount = suspectAccount;
    }

    public String getSuspectLink() {
        return suspectLink;
    }

    public void setSuspectLink(String suspectLink) {
        this.suspectLink = suspectLink;
    }

    public String getEvidence() {
        return evidence;
    }

    public void setEvidence(String evidence) {
        this.evidence = evidence;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getReportTime() {
        return reportTime;
    }

    public void setReportTime(String reportTime) {
        this.reportTime = reportTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getHandler() {
        return handler;
    }

    public void setHandler(String handler) {
        this.handler = handler;
    }

    public String getHandleResult() {
        return handleResult;
    }

    public void setHandleResult(String handleResult) {
        this.handleResult = handleResult;
    }

    public String getHandleTime() {
        return handleTime;
    }

    public void setHandleTime(String handleTime) {
        this.handleTime = handleTime;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}









