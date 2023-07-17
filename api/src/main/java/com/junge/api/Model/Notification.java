package com.junge.api.Model;

import lombok.Getter;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
public class Notification {
    private String Auth;
    private String to;
    private Map<String, String> messages;
}
