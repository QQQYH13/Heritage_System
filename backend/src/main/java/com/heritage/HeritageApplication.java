package com.heritage;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 非遗文化管理系统启动类
 */
@SpringBootApplication
@MapperScan("com.heritage.mapper")
public class HeritageApplication {

    public static void main(String[] args) {
        SpringApplication.run(HeritageApplication.class, args);
        System.out.println("=========================================");
        System.out.println("  非遗文化管理系统后端启动成功！");
        System.out.println("  接口地址: http://localhost:8080");
        System.out.println("=========================================");
    }
}
