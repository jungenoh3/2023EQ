package com.junge.api.Model.application;

import java.io.Serializable;

public interface EmergencyInstSpecific extends Serializable {
    Long getId();
    String getInstitution();
    String getMed_category();
    String getAddress();
    double getLatitude();
    double getLongitude();
}
