package com.junge.api.Repository.application;

import com.junge.api.Model.application.FCMToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FCMTokenRep extends JpaRepository<FCMToken, String > {

    // @Cacheable(value = "FCMToken", key = "'FCMToken: ' + (#token != null ? #token : '')")
    FCMToken getReferenceBytoken(String token);

    @Query(value = "SELECT token FROM fcmtoken WHERE now() - update_time > interval '20 day';", nativeQuery = true)
    List<String> findAllDeprecated();

    // void deleteAllByTokenInBatch(String token);
}
