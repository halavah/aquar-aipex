package com.kuafuai.api.auth.handler;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.kuafuai.api.auth.AuthHandler;
import com.kuafuai.api.auth.entity.HuoshanSignResult;
import com.kuafuai.api.auth.sign.HuoshanMusicSign;
import com.kuafuai.api.spec.ApiDefinition;
import com.kuafuai.system.entity.ApiMarket;
import com.kuafuai.system.entity.DynamicApiSetting;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
@Slf4j
public class HuoshanMusicAuthHandler implements AuthHandler {
    private final Type configType = new TypeToken<Map<String, Object>>() {

    }.getType();
    private final Gson gson = new Gson();


    @Override
    public void handle(DynamicApiSetting setting, ApiDefinition apiDefinition, ApiMarket apiMarket, Map<String, Object> params) throws Exception {
        if (apiMarket != null) {
            String authConfig = apiMarket.getAuthConfig();
            Map<String, Object> config = gson.fromJson(authConfig, configType);
            Map<String, String> queryMap = new HashMap<>();
            String accessKey = (String) config.getOrDefault("accessKey", "");
            String secretKey = (String) config.getOrDefault("secretKey", "");
            String action = (String) config.getOrDefault("action", "");
            String version = (String) config.getOrDefault("version", "");
            String host = (String) config.getOrDefault("host", "");
            String service = (String) config.getOrDefault("service", "");
            String body = gson.toJson(params);

            HuoshanSignResult huoshanSignResult = HuoshanMusicSign.signResult(accessKey, secretKey, apiDefinition.getMethod(), queryMap,
                    body.getBytes(StandardCharsets.UTF_8), new Date(), action,
                    version, host, service);
            String xDate = huoshanSignResult.getXDate();
            String xContentSha256 = huoshanSignResult.getXContentSha256();
            String authorization = huoshanSignResult.getAuthorization();
            params.put("host", host);
            params.put("xDate", xDate);
            params.put("xContentSha256", xContentSha256);
            params.put("authorization", authorization);

        }
    }

    @Override
    public String getAuthType() {
        return "huoshanMusic";
    }
}
