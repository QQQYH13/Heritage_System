package com.heritage.interceptor;

import com.heritage.annotation.RequireAdmin;
import com.heritage.annotation.RequireLogin;
import com.heritage.common.BusinessException;
import com.heritage.util.JwtUtil;
import com.heritage.util.UserContext;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * JWT 登录校验拦截器
 * 只对标注了 @RequireLogin 或 @RequireAdmin 的接口进行校验
 */
@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 放行非控制器方法
        if (!(handler instanceof HandlerMethod handlerMethod)) {
            return true;
        }
        // 放行 OPTIONS 预检请求
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            return true;
        }

        boolean requireLogin = handlerMethod.hasMethodAnnotation(RequireLogin.class)
                || handlerMethod.getBeanType().isAnnotationPresent(RequireLogin.class);
        boolean requireAdmin = handlerMethod.hasMethodAnnotation(RequireAdmin.class)
                || handlerMethod.getBeanType().isAnnotationPresent(RequireAdmin.class);

        // 未标注权限注解，公开接口直接放行
        if (!requireLogin && !requireAdmin) {
            return true;
        }

        // 需要登录，校验 token
        String token = request.getHeader("Authorization");
        if (token == null || token.isEmpty()) {
            throw new BusinessException(401, "未登录，请先登录");
        }
        try {
            Claims claims = JwtUtil.parseToken(token);
            UserContext.CurrentUser user = new UserContext.CurrentUser();
            user.setId(claims.get("id", Integer.class));
            user.setUsername(claims.getSubject());
            user.setRole(claims.get("role", String.class));
            UserContext.set(user);
        } catch (Exception e) {
            throw new BusinessException(401, "登录已过期，请重新登录");
        }

        // 需要管理员权限，校验角色
        if (requireAdmin && !"admin".equals(UserContext.get().getRole())) {
            throw new BusinessException(403, "无管理员权限");
        }
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        UserContext.clear();
    }
}
