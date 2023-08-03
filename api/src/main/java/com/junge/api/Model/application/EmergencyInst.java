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
public class EmergencyInst {

    @Id
    private Long id;
    private String institution;
    private String instCategory;
    private String medCategory;
    private String medZone;
    private Long postalCode;
    private String area;
    private String cityDistrict;
    private String address;
    private double latitude;
    private double longitude;

}
