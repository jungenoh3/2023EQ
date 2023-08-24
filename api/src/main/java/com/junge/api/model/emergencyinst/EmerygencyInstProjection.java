package com.junge.api.model.emergencyinst;

import com.junge.api.model.emergencyinst.EmergencyInstSpecific;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmerygencyInstProjection implements Serializable, EmergencyInstSpecific {
    private Long id;
    private String institution;
    private String med_category;
    private String address;
    private double latitude;
    private double longitude;
}
