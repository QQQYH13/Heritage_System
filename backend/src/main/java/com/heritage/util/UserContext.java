package com.heritage.util;

import lombok.Data;

/**
 * 当前登录用户上下文（ThreadLocal）
 */
public class UserContext {

    private static final ThreadLocal<CurrentUser> HOLDER = new ThreadLocal<>();

    public static void set(CurrentUser user) {
        HOLDER.set(user);
    }

    public static CurrentUser get() {
        return HOLDER.get();
    }

    /** 获取当前登录用户ID */
    public static Integer getUserId() {
        CurrentUser user = HOLDER.get();
        return user == null ? null : user.getId();
    }

    public static void clear() {
        HOLDER.remove();
    }

    /**
     * 当前登录用户信息
     */
    @Data
    public static class CurrentUser {
        private Integer id;
        private String username;
        private String role;
    }
}
