package com.junge.api.Model.server;

import java.sql.Timestamp;

public interface EarthquakeSpecific {

    Long getId();
    double getLat();
    double getLng();
    Timestamp getUpdate_time();
    Long getAssoc_id();
}
