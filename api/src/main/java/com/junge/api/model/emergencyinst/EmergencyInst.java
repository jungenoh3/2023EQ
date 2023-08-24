package com.junge.api.model.emergencyinst;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmergencyInst implements Serializable {

    @Id
    private Long id;
    private String institution;
    private String inst_category;
    private String med_category;
    private String med_zone;
    private Long postal_code;
    private String area;
    private String city_district;
    private String address;
    private double latitude;
    private double longitude;
}
