package com.junge.api.Model.application;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Shelter {

    @Id
    private Long id;
    private String arcd;
    private Long acmdfclty_sn;
    private String ctprvn_nm;
    private String sgg_nm;
    private String vt_acmdfclty_nm;
    private String rdnmadr_cd;
    private String bdong_cd;
    private String hdong_cd;
    private String dtl_adres;
    private Long fclty_ar;
    private double xcord;
    private double ycord;

}
