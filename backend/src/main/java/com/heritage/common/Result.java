package com.heritage.common;

import lombok.Data;

/**
 * 统一返回结果
 */
@Data
public class Result {

    /** 状态码：200 成功，401 未登录，403 无权限，500 失败 */
    private Integer code;
    /** 提示信息 */
    private String msg;
    /** 返回数据 */
    private Object data;

    public Result() {
    }

    public Result(Integer code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static Result success() {
        return new Result(200, "操作成功", null);
    }

    public static Result success(Object data) {
        return new Result(200, "操作成功", data);
    }

    public static Result success(String msg, Object data) {
        return new Result(200, msg, data);
    }

    public static Result error(String msg) {
        return new Result(500, msg, null);
    }

    public static Result error(Integer code, String msg) {
        return new Result(code, msg, null);
    }
}
