package com.kuafuai.manage.mcp.tool;

import com.google.gson.reflect.TypeToken;
import com.kuafuai.common.util.JSON;
import com.kuafuai.common.util.StringUtils;
import com.kuafuai.manage.entity.vo.TableVo;
import com.kuafuai.manage.mcp.server.McpSyncServerExchange;
import com.kuafuai.manage.mcp.service.McpBusinessService;
import com.kuafuai.manage.mcp.spec.McpSchema;
import com.kuafuai.manage.mcp.util.SchemaBuilder;
import com.kuafuai.manage.service.ManageBusinessService;
import com.kuafuai.system.service.ApplicationAPIKeysService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Component
public class ExecuteSQLToolProvider implements MCPToolProvider {

    private static final Logger logger = LoggerFactory.getLogger(ExecuteSQLToolProvider.class);

    @Resource
    private ApplicationAPIKeysService applicationAPIKeysService;

    @Resource
    private ManageBusinessService manageBusinessService;

    @Resource
    private McpBusinessService mcpBusinessService;


    @Override
    public McpSchema.Tool getToolDefinition() {
        String toolName = "execute_sql";
        String description = "当你设计好了 mysql 表结构对应的的 json 字符串后，使用此工具并将字符串传入 `ddl_query` 变量然后调用本工具去创建表结构，注意 `execute_sql` 工具仅支持创建表结构，不支持插入任何具体行数据，调用工具之前请先输出 json 结构进行检查 \n" +
                "参数名：`ddl_query` \n" +
                "参数值样例：[{\"tableName\":\"users\",\"description\":\"用户表\",\"columns\":[{\"tableName\":\"users\",\"columnName\":\"id\",\"columnComment\":\"用户ID\",\"columnType\":\"bigint\",\"dslType\":\"Long\",\"defaultValue\":null,\"isPrimary\":true,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"users\",\"columnName\":\"username\",\"columnComment\":\"用户名\",\"columnType\":\"varchar(50)\",\"dslType\":\"String\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"users\",\"columnName\":\"password\",\"columnComment\":\"密码\",\"columnType\":\"varchar(255)\",\"dslType\":\"password\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"users\",\"columnName\":\"role\",\"columnComment\":\"角色\",\"columnType\":\"varchar(20)\",\"dslType\":\"keyword\",\"defaultValue\":\"student\",\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"users\",\"columnName\":\"phone\",\"columnComment\":\"手机号\",\"columnType\":\"varchar(20)\",\"dslType\":\"phone\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":true,\"referenceTableName\":null},{\"tableName\":\"users\",\"columnName\":\"email\",\"columnComment\":\"邮箱\",\"columnType\":\"varchar(100)\",\"dslType\":\"email\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":true,\"referenceTableName\":null},{\"tableName\":\"users\",\"columnName\":\"created_at\",\"columnComment\":\"创建时间\",\"columnType\":\"datetime\",\"dslType\":\"datetime\",\"defaultValue\":null,\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"users\",\"columnName\":\"updated_at\",\"columnComment\":\"更新时间\",\"columnType\":\"datetime\",\"dslType\":\"datetime\",\"defaultValue\":null,\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null}]},{\"tableName\":\"students\",\"description\":\"学生信息表\",\"columns\":[{\"tableName\":\"students\",\"columnName\":\"id\",\"columnComment\":\"学生ID\",\"columnType\":\"bigint\",\"dslType\":\"Long\",\"defaultValue\":null,\"isPrimary\":true,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"user_id\",\"columnComment\":\"用户ID\",\"columnType\":\"bigint\",\"dslType\":\"Long\",\"defaultValue\":null,\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":\"users\"},{\"tableName\":\"students\",\"columnName\":\"student_no\",\"columnComment\":\"学号\",\"columnType\":\"varchar(20)\",\"dslType\":\"keyword\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"name\",\"columnComment\":\"姓名\",\"columnType\":\"varchar(50)\",\"dslType\":\"String\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"gender\",\"columnComment\":\"性别\",\"columnType\":\"varchar(10)\",\"dslType\":\"keyword\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"birth_date\",\"columnComment\":\"出生日期\",\"columnType\":\"date\",\"dslType\":\"date\",\"defaultValue\":null,\"isPrimary\":false,\"isNullable\":true,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"class_name\",\"columnComment\":\"班级\",\"columnType\":\"varchar(50)\",\"dslType\":\"String\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":true,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"major\",\"columnComment\":\"专业\",\"columnType\":\"varchar(100)\",\"dslType\":\"String\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":true,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"address\",\"columnComment\":\"地址\",\"columnType\":\"varchar(200)\",\"dslType\":\"String\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":true,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"parent_phone\",\"columnComment\":\"家长电话\",\"columnType\":\"varchar(20)\",\"dslType\":\"phone\",\"defaultValue\":\"\",\"isPrimary\":false,\"isNullable\":true,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"created_at\",\"columnComment\":\"创建时间\",\"columnType\":\"datetime\",\"dslType\":\"datetime\",\"defaultValue\":null,\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null},{\"tableName\":\"students\",\"columnName\":\"updated_at\",\"columnComment\":\"更新时间\",\"columnType\":\"datetime\",\"dslType\":\"datetime\",\"defaultValue\":null,\"isPrimary\":false,\"isNullable\":false,\"referenceTableName\":null}]}]";
        Map<String, Object> inputSchemaMap = SchemaBuilder.create()
                .addProperty("ddl_query", "string", "一段固定格式的 json 数据，用于表示一组表结构")
                .build();

        McpSchema.JsonSchema inputSchema = new McpSchema.JsonSchema("object", inputSchemaMap, Collections.singletonList("ddl_query"), null);

        return McpSchema.Tool.builder()
                .name(toolName)
                .description(description)
                .inputSchema(inputSchema)
                .build();
    }

    @Override
    public McpSchema.CallToolResult execute(McpSyncServerExchange exchange, Map<String, Object> params) {
        List<McpSchema.Content> result = new ArrayList<>();
        try {
            String appId = mcpBusinessService.getAppIdByToken(exchange);
            if (StringUtils.isBlank(appId)) {
                // 返回无权访问
                McpSchema.Content content = new McpSchema.TextContent("TOKEN 无权");
                result.add(content);
                return McpSchema.CallToolResult.builder()
                        .content(result)
                        .isError(true)
                        .build();
            }
            String ddlQuery = (String) params.get("ddl_query");

            List<TableVo> tableVos = JSON.parseObject(ddlQuery, new TypeToken<List<TableVo>>() {
            }.getType());

            if (manageBusinessService.createTables(appId,tableVos)) {
                McpSchema.Content content = new McpSchema.TextContent("本次表结构创建完毕: "+ddlQuery);
                result.add(content);
                return McpSchema.CallToolResult.builder()
                        .content(result)
                        .isError(false)
                        .build();
            } else {
                logger.info("未知异常: {}",ddlQuery);
                // 未知异常
                McpSchema.Content content = new McpSchema.TextContent("未知异常:" + ddlQuery);
                result.add(content);
                return McpSchema.CallToolResult.builder()
                        .content(result)
                        .isError(true)
                        .build();
            }

        } catch (Exception e) {
            logger.error("execute_sql: invoke failed {}", e.getMessage());
            McpSchema.Content content = new McpSchema.TextContent("工具执行异常: " + e.getMessage());
            result.add(content);
            return McpSchema.CallToolResult.builder()
                    .content(result)
                    .isError(true)
                    .build();
        }
    }
}
