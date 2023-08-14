package com.junge.api.Model.application;

import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ShelterProjection implements Serializable, ShelterSpecific {
    private Long id;
    private String vt_acmdfclty_nm;
    private String dtl_adres;
    private double xcord;
    private double ycord;
}

