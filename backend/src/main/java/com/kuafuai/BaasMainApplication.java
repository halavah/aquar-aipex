package com.kuafuai;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.core.env.Environment;
import org.springframework.retry.annotation.EnableRetry;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.net.InetAddress;
import java.net.UnknownHostException;

@SpringBootApplication
@EnableAsync
@EnableRetry
@EnableAspectJAutoProxy(exposeProxy = true, proxyTargetClass = true)
@EnableTransactionManagement
public class BaasMainApplication {

    public static void main(String[] args) {
        SpringApplication.run(BaasMainApplication.class, args);
    }

    @Slf4j
    @Component
    static class StartupInfoPrinter implements ApplicationRunner {

        private final Environment env;

        public StartupInfoPrinter(Environment env) {
            this.env = env;
        }

        @Override
        public void run(ApplicationArguments args) throws Exception {
            String protocol = "http";
            String serverPort = env.getProperty("server.port", "9991");
            String contextPath = env.getProperty("server.servlet.context-path", "");
            String hostAddress = "localhost";

            try {
                hostAddress = InetAddress.getLocalHost().getHostAddress();
            } catch (UnknownHostException e) {
                log.warn("无法获取主机地址");
            }

            String banner = "\n" +
                "================================================================\n" +
                "    应用启动成功！\n" +
                "================================================================\n" +
                "  本地访问地址:     " + protocol + "://localhost:" + serverPort + contextPath + "\n" +
                "  网络访问地址:     " + protocol + "://" + hostAddress + ":" + serverPort + contextPath + "\n" +
                "  API文档地址:      " + protocol + "://localhost:" + serverPort + contextPath + "/doc.html\n" +
                "----------------------------------------------------------------\n" +
                "  配置信息:\n" +
                "  - 端口:           " + serverPort + "\n" +
                "  - 环境:           " + env.getProperty("spring.profiles.active", "default") + "\n" +
                "  - 版本:           " + env.getProperty("app.version", "N/A") + "\n" +
                "  - 渠道:           " + env.getProperty("app.channel", "N/A") + "\n" +
                "  - 数据库:         " + env.getProperty("spring.profiles.active", "N/A") + "\n" +
                "  - 缓存类型:       " + env.getProperty("cache.type", "N/A") + "\n" +
                "  - 存储类型:       " + env.getProperty("storage.type", "N/A") + "\n" +
                "  - MCP服务名:      " + env.getProperty("mcp.server.name", "N/A") + "\n" +
                "  - MCP消息端点:    " + env.getProperty("mcp.server.message-endpoint", "N/A") + "\n" +
                "  - MCP SSE端点:    " + env.getProperty("mcp.server.sse-endpoint", "N/A") + "\n" +
                "================================================================\n";

            log.info(banner);
        }
    }
}
