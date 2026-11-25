package com.heritage.common;

import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 全局异常处理
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    /** 业务异常 */
    @ExceptionHandler(BusinessException.class)
    public Result handleBusinessException(BusinessException e) {
        return Result.error(e.getCode(), e.getMessage());
    }

    /** 参数校验异常 */
    @ExceptionHandler({MethodArgumentNotValidException.class, BindException.class})
    public Result handleValidException(Exception e) {
        String msg = "参数校验失败";
        if (e instanceof MethodArgumentNotValidException ex) {
            msg = ex.getBindingResult().getFieldError() != null
                    ? ex.getBindingResult().getFieldError().getDefaultMessage() : msg;
        } else if (e instanceof BindException ex) {
            msg = ex.getFieldError() != null ? ex.getFieldError().getDefaultMessage() : msg;
        }
        return Result.error(400, msg);
    }

    /** 其它异常 */
    @ExceptionHandler(Exception.class)
    public Result handleException(Exception e) {
        e.printStackTrace();
        return Result.error("系统异常：" + e.getMessage());
    }
}
