package com.kuafuai.api.auth.entity;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class HuoshanSignResult {
    private String xDate;
    private String xContentSha256;
    private String authorization;
    private String body;

}
