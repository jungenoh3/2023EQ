package com.junge.api.Model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class FCMNotification {
    private String token;
    private String titile;
    private String body;
}
